local GlobalAddonName, E = ... 
----------------------------------------------------------------------------------------------------------------------------------
--Hide_ObjectivesInInstance
tinsert(E.Modules, function()
		if OctoToDo_DB_Vars.config.Hide_ObjectivesInInstance then
			-- local className, classFilename, classId = UnitClass("PLAYER")
			-- local classColor = C_ClassColor.GetClassColor(classFilename)
			-- local r, g, b = classColor:GetRGB()
			-- local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
			-- local classColorHexCurrent = E.func_rgb2hex(r, g, b)
			-- function Hide_ObjectivesInInstanceOnLoad()
			-- 	local EventFrame = nil
			-- 	if not EventFrame then
			-- 		EventFrame = CreateFrame("Frame")
			-- 		EventFrame:Hide()
			-- 	end
			-- 	EventFrame:RegisterEvent("PLAYER_LOGIN")
			-- 	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")


			-- 	EventFrame:RegisterEvent("QUEST_TURNED_IN")
			-- 	EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
			-- 	EventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
			-- 	EventFrame:RegisterEvent("QUEST_ACCEPTED")
			-- 	EventFrame:RegisterEvent("QUEST_REMOVED")


			-- 	EventFrame:RegisterEvent("ZONE_CHANGED")
			-- 	EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

			-- 	EventFrame:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
			-- 	EventFrame:RegisterEvent("SCENARIO_POI_UPDATE")
			-- 	EventFrame:RegisterEvent("SCENARIO_BONUS_VISIBILITY_UPDATE")
			-- 	EventFrame:RegisterEvent("SCENARIO_UPDATE")
			-- 	EventFrame:RegisterEvent("SCENARIO_SPELL_UPDATE")
			-- 	EventFrame:RegisterEvent("SCENARIO_COMPLETED")
			-- 	EventFrame:RegisterEvent("SCENARIO_CRITERIA_SHOW_STATE_UPDATE")

			-- 	EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
			-- 	EventFrame:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
			-- 	EventFrame:RegisterEvent("CRITERIA_COMPLETE")
			-- 	EventFrame:RegisterEvent("UNIT_AURA")
			-- 	EventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")

			-- 	EventFrame:RegisterEvent("WORLD_STATE_TIMER_START")
			-- 	EventFrame:RegisterEvent("CHALLENGE_MODE_START")
			-- 	EventFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")




			-- 	EventFrame:HookScript("OnEvent", function(...)
			-- 			Hide_ObjectivesInInstanceOnEvent(...)
			-- 	end)
			-- end
			-- function Hide_ObjectivesInInstanceOnEvent(self, event, ...)
			-- 	if event and ObjectiveTrackerFrame:IsShown() then
			-- 		myfunction(event)
			-- 	end
			-- end
			-- function myfunction(event)
			-- 	local name, instanceType, difficultyID = GetInstanceInfo()
			-- 	-- /dump GetInstanceInfo()
			-- 	if instanceType == "party" or instanceType == "raid" or instanceType == "arena" or instanceType == "pvp" or instanceType == "scenario" then
			-- 		-- print (name, instanceType, difficultyID)
			-- 		-- if difficultyID == 1 -- Normal party (DRAENOR)
			-- 		if difficultyID == 2 -- Heroic party isHeroic
			-- 		or difficultyID == 8 -- Mythic Keystone party isHeroic, isChallengeMode
			-- 		-- or difficultyID == 19 -- Event party
			-- 		or difficultyID == 23 -- Mythic party isHeroic, displayMythic
			-- 		-- or difficultyID == 24 -- Timewalking party
			-- 		or difficultyID == 150 -- Normal party
			-- 		-- PVP
			-- 		or difficultyID == 29 -- PvEvP Scenario pvp
			-- 		or difficultyID == 34 -- PvP pvp
			-- 		-- raid
			-- 		-- or difficultyID == 3 -- 10 Player raid toggleDifficultyID: 5
			-- 		-- or difficultyID == 4 -- 25 Player raid toggleDifficultyID: 6
			-- 		-- or difficultyID == 5 -- 10 Player (Heroic) raid isHeroic, toggleDifficultyID: 3
			-- 		-- or difficultyID == 6 -- 25 Player (Heroic) raid isHeroic, toggleDifficultyID: 4
			-- 		or difficultyID == 7 -- Looking For Raid raid Legacy LFRs prior to SoO
			-- 		-- or difficultyID == 9 -- 40 Player raid
			-- 		or difficultyID == 14 -- Normal raid
			-- 		or difficultyID == 15 -- Heroic raid displayHeroic
			-- 		or difficultyID == 16 -- Mythic raid isHeroic, displayMythic
			-- 		or difficultyID == 17 -- Looking For Raid raid
			-- 		-- or difficultyID == 18 -- Event raid
			-- 		-- or difficultyID == 33 -- Timewalking raid
			-- 		-- or difficultyID == 151 -- Looking For Raid raid Timewalking
			-- 		-- scenario
			-- 		-- 12 ХРОМИ
			-- 		-- or difficultyID == 11 -- Heroic Scenario    scenario isHeroic
			-- 		or difficultyID == 12 -- Normal Scenario scenario
			-- 		-- or difficultyID == 20 -- Event Scenario scenario
			-- 		-- or difficultyID == 25 -- World PvP Scenario scenario
			-- 		-- or difficultyID == 30 -- Event scenario
			-- 		-- or difficultyID == 32 -- World PvP Scenario scenario
			-- 		-- or difficultyID == 38 -- Normal scenario
			-- 		-- or difficultyID == 39 -- Heroic scenario displayHeroic
			-- 		-- or difficultyID == 40 -- Mythic scenario displayMythic
			-- 		-- or difficultyID == 45 -- PvP scenario displayHeroic
			-- 		-- or difficultyID == 147 -- Normal scenario Warfronts
			-- 		-- or difficultyID == 149 -- Heroic scenario displayHeroic Warfronts
			-- 		-- or difficultyID == 152 -- Visions of N'Zoth scenario
			-- 		-- or difficultyID == 153 -- Teeming Island scenario displayHeroic
			-- 		-- or difficultyID == 167 -- Torghast scenario
			-- 		-- or difficultyID == 168 -- Path of Ascension: Courage scenario
			-- 		-- or difficultyID == 169 -- Path of Ascension: Loyalty scenario
			-- 		-- or difficultyID == 170 -- Path of Ascension: Wisdom scenario
			-- 		-- or difficultyID == 171 -- Path of Ascension: Humility scenario
			-- 		then
			-- 			-- C_Timer.NewTicker(.1, function()
			-- 			if ObjectiveTrackerFrame and ObjectiveTrackerFrame:IsShown() then
			-- 				print (E.Skyblue_Color..event.."|r")
			-- 				ObjectiveTrackerFrame:Hide()
			-- 				print ("ObjectiveTrackerFrame: "..E.Orange_Color.."Hide()|r")
			-- 				-- if ObjectiveTrackerFrame:GetAlpha() ~= 0 then
			-- 				-- 	ObjectiveTrackerFrame:SetAlpha(0)
			-- 				-- print ("ObjectiveTrackerFrame: "..E.Blue_Color.."SetAlpha(0)|r")
			-- 				-- end
			-- 				ObjectiveTrackerFrame:UnregisterAllEvents()
			-- 				print ("ObjectiveTrackerFrame: "..E.Red_Color.."UnregisterAllEvents()|r")
			-- 			end
			-- 			-- end)
			-- 		end
			-- 	else
			-- 		if ObjectiveTrackerFrame and not ObjectiveTrackerFrame:IsShown() then
			-- 			ObjectiveTrackerFrame:Show()
			-- 			print ("ObjectiveTrackerFrame: "..E.Green_Color.."Show()|r")
			-- 			-- if ObjectiveTrackerFrame:GetAlpha() ~= 1 then
			-- 			-- 	ObjectiveTrackerFrame:SetAlpha(1)
			-- 			-- 	print ("ObjectiveTrackerFrame: "..E.Green_Color.."SetAlpha(1)|r")
			-- 			-- end
			-- 		end
			-- 	end
			-- end
			-- -- Dump: value=GetInstanceInfo()
			-- Hide_ObjectivesInInstanceOnLoad()
		end
end)

