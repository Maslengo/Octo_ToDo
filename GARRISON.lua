GARRISON_LANDING_PAGE_TITLE
ORDER_HALL_LANDING_PAGE_TITLE
GARRISON_LANDING_PAGE_TITLE
-- /run ShowGarrisonLandingPage(2) -- Draenor 
if ( SpellCanTargetGarrisonMission() ) then
	-- TODO: Determine garrison/follower mission type for this spell
	if ( not GarrisonLandingPage ) then
		Garrison_LoadUI();
	end
	-- if the mission UI is already open, go with that
	if ( GarrisonMissionFrame:IsShown() ) then
		if ( PanelTemplates_GetSelectedTab(GarrisonMissionFrame) ~= 1 ) then
			GarrisonMissionFrame_SelectTab(1);
		end
		if ( PanelTemplates_GetSelectedTab(GarrisonMissionFrame.MissionTab.MissionList) ~= 2 ) then
			GarrisonMissionListTab_SetTab(GarrisonMissionFrame.MissionTab.MissionList.Tab2);
		end
	else
		if (C_Garrison.HasGarrison(Enum.GarrisonType.Type_6_0_Garrison)) then
			ShowGarrisonLandingPage(Enum.GarrisonType.Type_6_0_Garrison);
			-- switch to the mission tab
			if ( PanelTemplates_GetSelectedTab(GarrisonLandingPage) ~= 1 ) then
				GarrisonLandingPageTab_SetTab(GarrisonLandingPageTab1);
			end
			if ( PanelTemplates_GetSelectedTab(GarrisonLandingPageReport) ~= GarrisonLandingPageReport.InProgress ) then
				GarrisonLandingPageReport_SetTab(GarrisonLandingPageReport.InProgress);
			end
		end
	end
end
ORDER_HALL_LANDING_PAGE_TITLE
/run ShowGarrisonLandingPage(3) -- Legion
GARRISON_TYPE_8_0_LANDING_PAGE_TITLE
/run ShowGarrisonLandingPage(9) -- BattleForAzeroth WAR_CAMPAIGN
GARRISON_TYPE_9_0_LANDING_PAGE_TITLE
/run ShowGarrisonLandingPage(111) -- Shadowland
C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(LE_EXPANSION_DRAGONFLIGHT)
MajorFactions_LoadUI()
DRAGONFLIGHT_LANDING_PAGE_TITLE
function DragonridingPanelSkillsButtonMixin:OnClick()
	/run GenericTraitUI_LoadUI();
	/run GenericTraitFrame:SetSystemID(Constants.MountDynamicFlightConsts.TRAIT_SYSTEM_ID);
	/run GenericTraitFrame:SetTreeID(Constants.MountDynamicFlightConsts.TREE_ID);
	/run ToggleFrame(GenericTraitFrame);
end
C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(LE_EXPANSION_WAR_WITHIN)
WAR_WITHIN_LANDING_PAGE_TITLE - Сводка Каз Алгара
