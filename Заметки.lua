/fprint C_BattleNet.GetAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
/fprint C_BattleNet.GetAccountInfoByID(select(3, BNGetInfo()))
/fprint C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
["Player-1615-0AE9B27E"]
/dump GetPlayerInfoByGUID("Player-1615-0AE9B27E")
/dump GetPlayerInfoByGUID(UnitGUID("player"))
/dump C_BattleNet.GetAccountInfoByGUID("Player-3391-0CF86A39")
local playerAccountGUID = string.format("BNetAccount-0-%012X", (BNGetNumFriends() + 1));
local isBattleNetGUID = C_AccountInfo.IsGUIDBattleNetAccountType(playerAccountGUID);
local isLocalPlayerGUID = C_AccountInfo.IsGUIDRelatedToLocalAccount(playerAccountGUID);
fprint (playerAccountGUID, isBattleNetGUID, isLocalPlayerGUID);
inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
/dump UnitChromieTimeID("player")
https://www.wowhead.com/ru/achievement=40873 Спаситель ящиков
https://www.wowhead.com/ru/achievement=40979 Ни один ящик не пропадет
https://www.wowhead.com/ru/achievement=41013 Улучшенное облачение
https://www.wowhead.com/ru/achievement=41033 Классный стилист
/fprint {Octo_ToDo_DB_Vars, Octo_ToDo_DB_Other}
https://www.wowhead.com/achievement=40870/azeroths-greatest-detective
----------------------------------------------------------------

local AddonName, MDT = ...
local framePools = {}
local nop = function() end
-- we should probably use our own templates for these, but this is a quick fix
----------------------------------------------------------------

local overrides = {
	["MapLinkPinTemplate"] = {
		["SuperTrack_OnShow"] = nop,
		["SuperTrack_OnHide"] = nop,
		["OnSuperTrackingChanged"] = nop,
		["GetSuperTrackData"] = nop,
	}
}
function MDT.CreateFramePool(frametype, parent, template)
	local pool = {
		active = {},
		inactive = {},
		Acquire = function(self)
			local frame = table.remove(self.inactive)
			if not frame then
				frame = CreateFrame(frametype, nil, parent, template)
				local override = overrides[template]
				if override then
					for k, v in next, (override) do
						frame[k] = v
					end
				end
			end
			table.insert(self.active, frame)
			return frame
		end,
		ReleaseAll = function(self)
			for i = #self.active, 1, -1 do
				local frame = table.remove(self.active)
				frame:Hide()
				table.insert(self.inactive, frame)
			end
		end,
	}
	framePools[template] = pool
	return pool
end
function MDT.GetFramePool(template)
	return framePools[template]
end
----------------------------------------------------------------

-- ПОЧИНКА
-- PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY
function()
	local invSlotId, current, maximum;
	for invSlotId = 1, 18 do
		current, maximum = GetInventoryItemDurability(invSlotId)
		if current and maximum then
			if (current/maximum) <= 0.3 then
				return true
			end
		end
	end
	return false
end

----------------------------------------------------------------

15 мин модная
45 мин ездомания
----------------------------------------------------------------

https://www.youtube.com/watch?v=tnBEA660lnA&list=PL0bvxKQh3tleOjU2yx_aQF-gQpLozW_da
https://www.youtube.com/watch?v=fZM3TdtjlRE&list=PLh3q5vBuFn719dZNohjTKMThO442Bz7MF

найто

----------------------------------------------------------------

public.isTestBuild = GetCurrentRegion() == 72 -- PTR/beta
----------------------------------------------------------------
function()
    local currentValue = UnitGetTotalAbsorbs("player")
    local maxValue = UnitHealthMax("player")
    return currentValue, maxValue, true
end


----------------------------------------------------------------
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

----------------------------------------------------------------
шерлок

----------------------------------------------------------------
Opie -> ALT+T -> 5 кнопок для профессий
Opie -> ALT+H -> все порталы + спеки
ACF - Список аддонов
----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------

----------------------------------------------------------------


