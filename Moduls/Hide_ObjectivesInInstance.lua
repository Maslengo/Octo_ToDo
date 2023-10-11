local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--Hide_ObjectivesInInstance
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.Hide_ObjectivesInInstance then
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
				local difficultyID = select(3, GetInstanceInfo()) or "|cffFF0000-|r"
				-- https://wowpedia.fandom.com/wiki/DifficultyID
				-- PARTY
				if difficultyID == 1 -- Normal party
				or difficultyID == 2 -- Heroic party isHeroic
				or difficultyID == 8 -- Mythic Keystone party isHeroic, isChallengeMode
				or difficultyID == 19 -- Event party
				or difficultyID == 23 -- Mythic party isHeroic, displayMythic
				or difficultyID == 24 -- Timewalking party
				or difficultyID == 150 -- Normal party
				-- PVP
				or difficultyID == 29 -- PvEvP Scenario pvp
				or difficultyID == 34 -- PvP pvp
				-- raid
				or difficultyID == 3 -- 10 Player raid toggleDifficultyID: 5
				or difficultyID == 4 -- 25 Player raid toggleDifficultyID: 6
				or difficultyID == 5 -- 10 Player (Heroic) raid isHeroic, toggleDifficultyID: 3
				or difficultyID == 6 -- 25 Player (Heroic) raid isHeroic, toggleDifficultyID: 4
				or difficultyID == 7 -- Looking For Raid raid Legacy LFRs prior to SoO
				or difficultyID == 9 -- 40 Player raid
				or difficultyID == 14 -- Normal raid
				or difficultyID == 15 -- Heroic raid displayHeroic
				or difficultyID == 16 -- Mythic raid isHeroic, displayMythic
				or difficultyID == 17 -- Looking For Raid raid
				or difficultyID == 18 -- Event raid
				or difficultyID == 33 -- Timewalking raid
				or difficultyID == 151 -- Looking For Raid raid Timewalking
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
					-- print (E.Octo_Globals.Red_Color.."ObjectiveTrackerFrame:Hide()".."|r")
				else
					ObjectiveTrackerFrame:Show()
					-- print (E.Octo_Globals.Green_Color.."ObjectiveTrackerFrame:Show()".."|r")
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
		end
end)

