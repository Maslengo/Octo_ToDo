local GlobalAddonName, E = ...
Octo_ToDO_E = E
local _G = _G
_G["OctoTODO"] = OctoTODO
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local Octo_EventFrame = CreateFrame("FRAME", "Octo_EventFrame")
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local buildVersion, buildNumber, buildDate, interfaceVersion = GetBuildInfo()
local currentTier = tonumber(GetBuildInfo():match("(.-)%."))
local IsPublicBuild = IsPublicBuild()
local expansionQWEQWE = 13
local isBeta = interfaceVersion >= 120000
local GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData()) or 20
local IsAccountSecured = IsAccountSecured() or false
local IsRestrictedAccount = IsRestrictedAccount() or false
local IsTrialAccount = IsTrialAccount() or false
local IsVeteranTrialAccount = IsVeteranTrialAccount() or false
local BattleTag = select(2, BNGetInfo()) or "Trial Account"
local BTAG = tostringall(strsplit("#", BattleTag))
local GameVersion = GetCurrentRegion() == 72 and "PTR" or "Retail"
local BattleTagLocal = BTAG.." ("..GameVersion..")"
local curGUID = UnitGUID("PLAYER")
local ItemLevelGreen = 625
local ItemLevelOrange = 610
local ItemLevelRed = 580
local GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.func_LoadAddOn("Octo_ToDoTrashCan")
E.func_LoadAddOn("!BugGrabber")
E.func_LoadAddOn("BugSack")
E.func_LoadAddOn("MountsJournal")
E.func_LoadAddOn("HidingBar")
E.func_LoadAddOn("HidingBar_Options")
E.func_LoadAddOn("SpeedyAutoLoot")
E.func_LoadAddOn("TalentTreeTweaks")
E.func_LoadAddOn("Plater")
E.func_LoadAddOn("MacroManager")
E.func_LoadAddOn("MacroManagerData")
E.func_LoadAddOn("SilverDragon")
E.func_LoadAddOn("SilverDragon_History")
E.func_LoadAddOn("SilverDragon_Overlay")
E.func_LoadAddOn("SilverDragon_RangeExtender")
E.func_LoadAddOn("TomTom")
E.func_LoadAddOn("Pawn")
E.func_LoadAddOn("MySlot")
E.func_LoadAddOn("QuestsChanged")
E.func_LoadAddOn("AdvancedInterfaceOptions")
local OctoToDo_FIRST_CharFrame = nil
local OctpToDo_FIRST_inspectScantip = nil
local OctoToDo_FIRST_MainFrame = nil
local OctoToDo_FIRST_CloseButton = nil
local OctoToDo_FIRST_OptionsButton = nil
local OctoToDo_FIRST_AbandonButton = nil
local OctoToDo_FIRST_MplusButton = nil
local OctoToDo_FIRST_ItemsButton = nil
local OctoToDo_FIRST_MarkOfHonorButton = nil
local OctoToDo_FIRST_QuestFeastButton = nil
local OctoToDo_FIRST_EventsButton = nil
local OctoToDo_FIRST_ConsumableButton = nil
local OctoTable_func_otrisovka_FIRST = nil
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = E.func_GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
local classColorHexCurrent = E.func_rgb2hex(r, g, b)
if classFilename == "SHAMAN" then
	classColor = "0070de"
end
local font = "01 Octo"
local font2 = SystemFont_Outline_Small
local fontObject9 = CreateFont("OctoFont9")
fontObject9:CopyFontObject(font2)
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:CopyFontObject(font2)
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:CopyFontObject(font2)
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:CopyFontObject(font2)
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local Meta_Table_0 = {__index = function()
		return 0
	end
}
local Meta_Table_1 = {__index = function()
		return 1
	end
}
local Meta_Table_false = {__index = function()
		return false
	end
}
local Meta_Table_true = {__index = function()
		return true
	end
}
local Meta_Table_DONE = {__index = function()
		return E.DONE
	end
}
local Meta_Table_NONE = {__index = function()
		return E.NONE
	end
}
local Meta_Table_EmptyString = {__index = function()
		return ""
	end
}
local MustBeHiddenFrames_table = {
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "SplashFrame", frame = SplashFrame},
	{name = "MajorFactionsRenownToast", frame = MajorFactionsRenownToast},
	{name = "PTRIssueReporterAlertFrame", frame = PTRIssueReporterAlertFrame},
	{name = "RaidWarningFrame", frame = RaidWarningFrame},
	{name = "ZoneTextFrame", frame = ZoneTextFrame},
	{name = "SubZoneTextFrame", frame = SubZoneTextFrame},
	{name = "EventToastManagerFrame", frame = EventToastManagerFrame},
	{name = "PTR_IssueReporter", frame = PTR_IssueReporter},
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "RaidBossEmoteFrame", frame = RaidBossEmoteFrame},
	{name = "ZoneAbilityFrame.Style", frame = ZoneAbilityFrame.Style},
	{name = "ExtraActionButton1.style", frame = ExtraActionButton1.style},
	{name = "UIWidgetTopCenterContainerFrame", frame = UIWidgetTopCenterContainerFrame},
	{name = "PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator", frame = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator},
}
function Octo_EventFrame:MustBeHiddenFrames()
	for _, v in next, (MustBeHiddenFrames_table) do
		if v.frame and v.frame:IsShown() then
			v.frame:Hide()
		end
	end
end
function Octo_EventFrame:ConcatAtStart()
	E.func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
	for _, itemID in next, (E.OctoTable_itemID_ALL) do
		Octo_ToDo_DB_Config.ItemDB[itemID] = Octo_ToDo_DB_Config.ItemDB[itemID] or false
	end
	E.func_TableConcat(E.OctoTable_itemID_Config, E.OctoTable_itemID_ALL)
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Cosmetic) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Mount) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Other) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Pets) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_Toys) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, itemID in next, (E.OctoTable_itemID_ItemsUsable_ArmorTokens) do
		E.OctoTable_itemID_ItemsUsable[itemID] = 1
	end
	for _, currencyID in next, (E.OctoTable_currencyID_Hidden) do
		Octo_ToDo_DB_Config.CurrencyDB[currencyID] = Octo_ToDo_DB_Config.CurrencyDB[currencyID] or false
	end
	for _, reputationID in next, (E.OctoTable_reputationID_Hidden) do
		Octo_ToDo_DB_Config.ReputationDB[reputationID] = Octo_ToDo_DB_Config.ReputationDB[reputationID] or false
	end
	for _, reputationID in next, (E.OctoTable_reputation_ALL) do
		Octo_ToDo_DB_Config.ReputationDB[reputationID] = Octo_ToDo_DB_Config.ReputationDB[reputationID] or false
	end
	for _, questID in next, (E.OctoTable_QuestID) do
		Octo_ToDo_DB_Config.QuestsDB[questID] = Octo_ToDo_DB_Config.QuestsDB[questID] or false
	end
end
local function Central_Frame_Mouse_OnEnter(frame)
	local parent = OctoToDo_FIRST_MainFrame["FrameLine"..frame.index]
	parent:GetScript("OnEnter")(parent)
	if not frame.tooltip then
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in next, (frame.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(frame)
	local parent = OctoToDo_FIRST_MainFrame["FrameLine"..frame.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
function Octo_EventFrame:checkCharInfo()
	if Octo_ToDo_DB_Levels then
		for GUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
			local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName = GetPlayerInfoByGUID(GUID)
			if CharInfo.journalInstance == nil then
				CharInfo.journalInstance = {}
			end
			local ServerTime = GetServerTime()
			for instanceID, tbl in next, (CharInfo.journalInstance) do
				if instanceID then
					for difficultyID, w in next, (tbl) do
						for e, r in next, (w) do
							if e == "instanceReset" then
								if ServerTime >= r then
									CharInfo.journalInstance[instanceID] = {}
								end
							end
						end
					end
				end
			end
			CharInfo.MASLENGO = CharInfo.MASLENGO or {}
			CharInfo.UniversalQuest = nil
			CharInfo.MASLENGO.UniversalQuest = CharInfo.MASLENGO.UniversalQuest or {}
			CharInfo.MASLENGO.CurrencyID = CharInfo.MASLENGO.CurrencyID or {}
			CharInfo.MASLENGO.CurrencyID_Total = CharInfo.MASLENGO.CurrencyID_Total or {}
			CharInfo.MASLENGO.CurrencyID_totalEarned = CharInfo.MASLENGO.CurrencyID_totalEarned or {}
			CharInfo.MASLENGO.ItemsInBag = CharInfo.MASLENGO.ItemsInBag or {}
			CharInfo.MASLENGO.professions = CharInfo.MASLENGO.professions or {}
			CharInfo.MASLENGO.reputationID = CharInfo.MASLENGO.reputationID or {}
			CharInfo.MASLENGO.OctoTable_QuestID = CharInfo.MASLENGO.OctoTable_QuestID or {}
			if CharInfo.CurrencyID ~= nil then
				CharInfo.MASLENGO.CurrencyID = CharInfo.CurrencyID
				CharInfo.CurrencyID = nil
			end
			if CharInfo.CurrencyID_Total ~= nil then
				CharInfo.MASLENGO.CurrencyID_Total = CharInfo.CurrencyID_Total
				CharInfo.CurrencyID_Total = nil
			end
			if CharInfo.CurrencyID_totalEarned ~= nil then
				CharInfo.MASLENGO.CurrencyID_totalEarned = CharInfo.CurrencyID_totalEarned
				CharInfo.CurrencyID_totalEarned = nil
			end
			if CharInfo.ItemsInBag ~= nil then
				CharInfo.MASLENGO.ItemsInBag = CharInfo.ItemsInBag
				CharInfo.ItemsInBag = nil
			end
			if CharInfo.reputationID ~= nil then
				CharInfo.MASLENGO.reputationID = CharInfo.reputationID
				CharInfo.reputationID = nil
			end
			if CharInfo.OctoTable_QuestID ~= nil then
				CharInfo.MASLENGO.OctoTable_QuestID = CharInfo.OctoTable_QuestID
				CharInfo.OctoTable_QuestID = nil
			end
			if CharInfo.time == nil and CharInfo.tmstp_Daily ~= nil then
				CharInfo.time = CharInfo.tmstp_Daily
			end
			for i = 1, 5 do
				CharInfo.MASLENGO.professions[i] = CharInfo.MASLENGO.professions[i] or {}
				CharInfo.MASLENGO.professions[i].skillLine = CharInfo.MASLENGO.professions[i].skillLine or 0
				CharInfo.MASLENGO.professions[i].skillLevel = CharInfo.MASLENGO.professions[i].skillLevel or 0
				CharInfo.MASLENGO.professions[i].maxSkillLevel = CharInfo.MASLENGO.professions[i].maxSkillLevel or 0
			end
			CharInfo.LFGInstance = CharInfo.LFGInstance or {}
			CharInfo.MASLENGO.OctoTable_QuestID = CharInfo.MASLENGO.OctoTable_QuestID or {}
			CharInfo.GreatVault = CharInfo.GreatVault or {}
			for _, v in next, (E.OctoTable_UniversalQuest) do
				CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] or E.NONE
			end
			CharInfo.professions = nil
			CharInfo.Shadowland = nil
			if CharInfo.CovenantAndAnima == nil then
				CharInfo.CovenantAndAnima = {}
			end
			if CharInfo.CovenantAndAnima.curCovID == nil then
				CharInfo.CovenantAndAnima.curCovID = 0
			end
			for k = 1, 2 do
				for i = 1, 4 do
					CharInfo.CovenantAndAnima[i] = CharInfo.CovenantAndAnima[i] or {}
					CharInfo.CovenantAndAnima[i][k] = CharInfo.CovenantAndAnima[i][k] or 0
				end
			end
			CharInfo.PVP = CharInfo.PVP or {}
			CharInfo.avgItemLevel = CharInfo.avgItemLevel or 1
			CharInfo.avgItemLevelEquipped = CharInfo.avgItemLevelEquipped or 1
			CharInfo.avgItemLevelPvp = CharInfo.avgItemLevelPvp or 1
			CharInfo.className = CharInfo.className or localizedClass
			CharInfo.classFilename = CharInfo.classFilename or englishClass
			CharInfo.classId = CharInfo.classId or 1
			CharInfo.classColor = CharInfo.classColor or {r = 0.5, g = 0.5, b = 0.5}
			CharInfo.curServer = CharInfo.curServer or curServer
			CharInfo.guildName = CharInfo.guildName or ""
			CharInfo.guildRankName = CharInfo.guildRankName or ""
			CharInfo.guildRankIndex = CharInfo.guildRankIndex or 0
			CharInfo.curServerShort = CharInfo.curServerShort or E.func_CurServerShort(curServer)
			CharInfo.Faction = CharInfo.Faction or "Horde"
			CharInfo.BattleTag = CharInfo.BattleTag or BattleTag
			CharInfo.BattleTagLocal = CharInfo.BattleTagLocal or BattleTagLocal
			CharInfo.IsPublicBuild = CharInfo.IsPublicBuild or true
			CharInfo.Chromie_canEnter = CharInfo.Chromie_canEnter or false
			CharInfo.Chromie_UnitChromieTimeID = CharInfo.Chromie_UnitChromieTimeID or 0
			CharInfo.Chromie_name = CharInfo.Chromie_name or ""
			CharInfo.buildVersion = CharInfo.buildVersion or buildVersion
			CharInfo.GameLimitedMode_IsActive = CharInfo.GameLimitedMode_IsActive or GameLimitedMode_IsActive
			if CharInfo.levelCapped20 == nil then
				CharInfo.levelCapped20 = false
			end
			if CharInfo.PlayerCanEarnExperience == nil then
				CharInfo.PlayerCanEarnExperience = true
			end
			CharInfo.buildNumber = CharInfo.buildNumber or buildNumber
			CharInfo.buildDate = CharInfo.buildDate or buildDate
			CharInfo.interfaceVersion = CharInfo.interfaceVersion or interfaceVersion
			CharInfo.currentTier = CharInfo.currentTier or currentTier
			CharInfo.isBeta = CharInfo.isBeta or false
			CharInfo.IsAccountSecured = CharInfo.IsAccountSecured or false
			CharInfo.GetRestrictedAccountData_rLevel = CharInfo.GetRestrictedAccountData_rLevel or 20
			CharInfo.GetRestrictedAccountData_rMoney = CharInfo.GetRestrictedAccountData_rMoney or 10000000
			CharInfo.GetRestrictedAccountData_profCap = CharInfo.GetRestrictedAccountData_profCap or 0
			CharInfo.IsTrialAccount = CharInfo.IsTrialAccount or false
			CharInfo.IsVeteranTrialAccount = CharInfo.IsVeteranTrialAccount or false
			CharInfo.PlayerDurability = CharInfo.PlayerDurability or 100
			CharInfo.maxNumQuestsCanAccept = CharInfo.maxNumQuestsCanAccept or 0
			CharInfo.Name = CharInfo.Name or name
			CharInfo.numQuests = CharInfo.numQuests or 0
			CharInfo.RaceLocal = CharInfo.RaceLocal or localizedRace
			CharInfo.RaceEnglish = CharInfo.RaceEnglish or englishRace
			CharInfo.raceID = CharInfo.raceID or 0
			CharInfo.classColorHex = CharInfo.classColorHex or classColorHexCurrent
			CharInfo.currentXP = CharInfo.currentXP or 0
			CharInfo.UnitXPMax = CharInfo.UnitXPMax or 0
			CharInfo.UnitXPPercent = CharInfo.UnitXPPercent or 0
			CharInfo.realTotalTime = CharInfo.realTotalTime or 0
			CharInfo.realLevelTime = CharInfo.realLevelTime or 0
			CharInfo.Possible_Anima = CharInfo.Possible_Anima or 0
			CharInfo.Possible_CatalogedResearch = CharInfo.Possible_CatalogedResearch or 0
			CharInfo.numShownEntries = CharInfo.numShownEntries or 0
			CharInfo.loginDate = CharInfo.loginDate or date("%d.%m.%Y %H:%M:%S")
			CharInfo.loginDay = CharInfo.loginDay or date("%d.%m.%Y")
			CharInfo.loginHour = CharInfo.loginHour or date("%H:%M")
			CharInfo.time = CharInfo.time or time()
			CharInfo.UnitLevel = CharInfo.UnitLevel or 1
			CharInfo.Money = CharInfo.Money or 0
			CharInfo.totalSlots = CharInfo.totalSlots or 0
			CharInfo.usedSlots = CharInfo.usedSlots or 0
			CharInfo.MoneyOnLogin = CharInfo.MoneyOnLogin or 0
			CharInfo.BindLocation = CharInfo.BindLocation or 0
			CharInfo.CurrentLocation = CharInfo.CurrentLocation or 0
			CharInfo.WarMode = CharInfo.WarMode or false
			if CharInfo.needResetDaily == nil then
				CharInfo.needResetDaily = false
			end
			if CharInfo.needResetWeekly == nil then
				CharInfo.needResetWeekly = false
			end
			if CharInfo.needResetMonth == nil then
				CharInfo.needResetMonth = false
			end
			if CharInfo.HasAvailableRewards == nil then
				CharInfo.HasAvailableRewards = false
			end
			if CharInfo.hasMail == nil then
				CharInfo.hasMail = false
			end
			if CharInfo.isShownPLAYER == nil then
				CharInfo.isShownPLAYER = true
			end
			CharInfo.MoneyOnLogin = CharInfo.Money
			CharInfo.RIO_Score_TWW_S1 = CharInfo.RIO_Score_TWW_S1 or 0
			CharInfo.RIO_weeklyBest_TWW_S1 = CharInfo.RIO_weeklyBest_TWW_S1 or 0
			for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
				CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
				CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
				CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
				CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
				CharInfo.GreatVault[i].type = CharInfo.GreatVault[i].type or ""
			end
			if type(CharInfo.MASLENGO.CurrencyID) == "number" then
				CharInfo.MASLENGO.CurrencyID = {}
			end
			if type(CharInfo.MASLENGO.CurrencyID_Total) == "number" then
				CharInfo.MASLENGO.CurrencyID_Total = {}
			end
			if type(CharInfo.MASLENGO.CurrencyID_totalEarned) == "number" then
				CharInfo.MASLENGO.CurrencyID_totalEarned = {}
			end
			if type(CharInfo.MASLENGO.ItemsInBag) == "number" then
				CharInfo.MASLENGO.ItemsInBag = {}
			end
			setmetatable(CharInfo.MASLENGO.OctoTable_QuestID, Meta_Table_NONE)
			setmetatable(CharInfo.MASLENGO.CurrencyID, Meta_Table_0)
			setmetatable(CharInfo.MASLENGO.CurrencyID_Total, Meta_Table_0)
			setmetatable(CharInfo.MASLENGO.CurrencyID_totalEarned, Meta_Table_0)
			setmetatable(CharInfo.MASLENGO.ItemsInBag, Meta_Table_0)
			setmetatable(CharInfo.MASLENGO.reputationID, Meta_Table_0)
			if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
				for i = 1, #CharInfo.GreatVault do
					if CharInfo.GreatVault[i] and CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
						CharInfo.HasAvailableRewards = true
						CharInfo.GreatVault = {}
						break
					end
				end
			end
			if (CharInfo.tmstp_Weekly or 0) < GetServerTime() and CharInfo.MASLENGO.UniversalQuest.Octopussy_DF_Weekly_CommunityFeast_count == E.DONE then
				CharInfo.Octopussy_DF_Weekly_CommunityFeast_count = E.NONE
			end
			if (CharInfo.tmstp_Weekly or 0) < GetServerTime() then
				CharInfo.tmstp_Weekly = E.func_tmstpDayReset(7)
				CharInfo.needResetWeekly = true
				CharInfo.CurrentKey = 0
				CharInfo.CurrentKeyFULL = 0
				CharInfo.CurrentKeyLevel = 0
				CharInfo.journalInstance = {}
				CharInfo.RIO_weeklyBest_TWW_S1 = 0
				CharInfo.GreatVault = {}
				for i = 1, #CharInfo.GreatVault do
					if CharInfo.GreatVault[i] then
						CharInfo.GreatVault[i] = {}
						CharInfo.GreatVault[i].progress = 0
						CharInfo.GreatVault[i].threshold = 0
						CharInfo.GreatVault[i].hyperlink_STRING = 0
					end
				end
				for _, v in next, (E.OctoTable_UniversalQuest) do
					for q, w in next, (v) do
						if w == "Weekly" then
							CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Weekly"] = E.NONE
						end
					end
				end
			end
			if (CharInfo.tmstp_Daily or 0) < GetServerTime() then
				CharInfo.tmstp_Daily = E.func_tmstpDayReset(1)
				CharInfo.needResetDaily = true
				for _, v in next, (E.OctoTable_UniversalQuest) do
					for q, w in next, (v) do
						if w == "Daily" then
							CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Daily"] = E.NONE
						end
					end
				end
				CharInfo.LFGInstance = {}
			end
			for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
				CharInfo.LFGInstance[dungeonID] = CharInfo.LFGInstance[dungeonID] or {}
				CharInfo.LFGInstance[dungeonID].D_name = CharInfo.LFGInstance[dungeonID].D_name or name
				CharInfo.LFGInstance[dungeonID].donetoday = CharInfo.LFGInstance[dungeonID].donetoday or E.NONE
			end
			if (CharInfo.tmstp_Month or 0) < GetServerTime() then
				CharInfo.tmstp_Month = E.func_tmstpDayReset(30)
				CharInfo.needResetMonth = true
				for _, v in next, (E.OctoTable_UniversalQuest) do
					for q, w in next, (v) do
						if w == "Month" then
							CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Month"] = E.NONE
						end
					end
				end
			end
		end
	end
end
local function CreateFrameUsableItems_OnShow(frame)
	local hasToy = PlayerHasToy(frame.itemID)
	local hasItem = GetItemCount(frame.itemID, true, true, true) >= frame.count
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true and (hasToy == true or hasItem == true) then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if frame.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if frame.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if E.func_GetItemCooldown(frame.itemID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnEnter(frame)
	frame.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMLEFT", 0, 0)
	local itemLink = select(2, GetItemInfo(frame.itemID))
	if itemLink then
		GameTooltip:ClearLines()
		if E.func_GetItemCooldown(frame.itemID) ~= 0 then
			GameTooltip:AddDoubleLine(E.func_itemTexture(frame.itemID).." "..E.White_Color..E.func_itemName(frame.itemID).."|r", E.Red_Color..E.func_SecondsToClock(E.func_GetItemCooldown(frame.itemID)).."|r")
		else
			GameTooltip:AddLine(E.func_itemTexture(frame.itemID).." "..E.White_Color..E.func_itemName(frame.itemID).."|r")
		end
		if frame.itemID == 6948 then
			GameTooltip:AddLine(E.White_Color..GetBindLocation() or E.NONE.."|r")
		end
		GameTooltip:Show()
	end
	frame:SetBackdropBorderColor(r, g, b, 1)
	if E.func_GetItemCooldown(frame.itemID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnLeave(frame)
	local hasToy = PlayerHasToy(frame.itemID)
	local hasItem = GetItemCount(frame.itemID, true, true, true) >= frame.count
	local isKnown = IsSpellKnown(frame.spellID)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
	frame:SetBackdropBorderColor(0, 0, 0, 1)
	if isKnown == true and (hasToy == true or hasItem == true) then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if frame.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if frame.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if E.func_GetItemCooldown(frame.itemID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnEvent(frame, event, arg1, ...)
	if OctoToDo_FIRST_MainFramePIZZA:IsShown() then
		if (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
			local startTime, duration = C_Container.GetItemCooldown(frame.itemID)
			local hasToy = PlayerHasToy(frame.itemID)
			local hasItem = GetItemCount(frame.itemID, true, true, true) >= frame.count
			local isKnown = IsSpellKnown(frame.spellID)
			if isKnown == true and (hasToy == true or hasItem == true) then
				frame.icon:SetVertexColor(1, 1, 1, 1)
			else
				frame.icon:SetVertexColor(1, .5, .5, .3)
			end
			if frame.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
				frame.icon:SetVertexColor(1, .5, .5, .3)
			end
			if frame.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
				frame.icon:SetVertexColor(1, .5, .5, .3)
			end
		elseif event == "PLAYER_REGEN_DISABLED" then
			frame:SetParent(UIParent)
			frame:ClearAllPoints()
			frame:Hide()
		else
			frame:SetParent(OctoToDo_FIRST_MainFrame)
			frame:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", frame.Xpos, frame.Ypos+1)
			frame:Show()
		end
	end
end
local function CreateFrameUsableItems_OnMouseDown(frame)
	frame.icon:SetVertexColor(1, 1, 1, E.BGALPHA)
end
local function CreateFrameUsableItems_OnMouseUp(frame)
	frame.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameUsableItems(itemID, Texture, Xpos, Ypos, r, g, b, spellID)
	local Button = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.itemID = itemID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.count = 1
	Button.spellID = spellID or 431280
	Button:SetSize(E.curHeight, E.curHeight)
	Button:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({
			edgeFile = E.edgeFile,
			edgeSize = 1
	})
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:HookScript("OnShow", CreateFrameUsableItems_OnShow)
	Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "item")
	Button:SetAttribute("item", "item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
local function CreateFrameUsableSpells_OnEnter(frame)
	frame.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMLEFT", 0, 0)
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	frame:SetBackdropBorderColor(r, g, b, 1)
	local link = C_Spell.GetSpellLink(frame.spellID)
	if link then
		GameTooltip:ClearLines()
		if E.func_GetSpellCooldown(frame.spellID) ~= 0 then
			GameTooltip:AddDoubleLine(E.func_texturefromIcon(E.func_GetSpellIcon(frame.spellID)).." "..E.White_Color..E.func_GetSpellName(frame.spellID).."|r", E.Red_Color..E.func_SecondsToClock(E.func_GetSpellCooldown(frame.spellID)).."|r")
		else
			GameTooltip:AddLine(E.func_texturefromIcon(E.func_GetSpellIcon(frame.spellID)).." "..E.White_Color..E.func_GetSpellName(frame.spellID).."|r")
		end
		GameTooltip:Show()
	end
	if E.func_GetSpellCooldown(frame.spellID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnLeave(frame)
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	GameTooltip:ClearLines()
	GameTooltip:Hide()
	frame:SetBackdropBorderColor(0, 0, 0, 1)
	if E.func_GetSpellCooldown(frame.spellID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnShow(frame)
	local startTime, duration = C_Spell.GetSpellCooldown(frame.spellID)
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
	if E.func_GetSpellCooldown(frame.spellID) ~= 0 then
		frame.icon:SetVertexColor(1, .34, .44, 1)
		frame:SetBackdropBorderColor(1, .34, .44, 1)
	else
		frame:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnEvent(frame, event)
	if OctoToDo_FIRST_MainFramePIZZA:IsShown() then
		if (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
			local startTime, duration = C_Spell.GetSpellCooldown(frame.spellID)
			local isKnown = IsSpellKnown(frame.spellID)
			if isKnown == true then
				frame.icon:SetVertexColor(1, 1, 1, 1)
			else
				frame.icon:SetVertexColor(1, .5, .5, .3)
			end
		elseif event == "PLAYER_REGEN_DISABLED" then
			frame:SetParent(UIParent)
			frame:ClearAllPoints()
			frame:Hide()
		else
			frame:SetParent(OctoToDo_FIRST_MainFrame)
			frame:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", frame.Xpos, frame.Ypos+1)
			frame:Show()
		end
	end
end
local function CreateFrameUsableSpells_OnMouseDown(frame)
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
end
local function CreateFrameUsableSpells_OnMouseUp(frame)
	local isKnown = IsSpellKnown(frame.spellID)
	if isKnown == true then
		frame.icon:SetVertexColor(1, 1, 1, 1)
	else
		frame.icon:SetVertexColor(1, .5, .5, .3)
	end
end
local function CreateFrameUsableSpells(spellID, Texture, Xpos, Ypos, r, g, b)
	local Button = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.spellID = spellID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.curHeight, E.curHeight)
	Button:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({
			edgeFile = E.edgeFile,
			edgeSize = 1
	})
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent"PLAYER_REGEN_ENABLED"
	Button:RegisterEvent"PLAYER_REGEN_DISABLED"
	Button:RegisterEvent"TOYS_UPDATED"
	Button:RegisterEvent"SPELLS_CHANGED"
	Button:RegisterEvent"SPELL_UPDATE_CHARGES"
	Button:RegisterEvent"SPELL_UPDATE_COOLDOWN"
	Button:RegisterEvent"TRAINER_UPDATE"
	Button:HookScript("OnShow", CreateFrameUsableSpells_OnShow)
	Button:HookScript("OnEvent", CreateFrameUsableSpells_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableSpells_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableSpells_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableSpells_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableSpells_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "spell")
	Button:SetAttribute("spell", spellID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
function Octo_EventFrame:Collect_ALL_PlayerInfo()
	Octo_ToDoTrashCan = Octo_ToDoTrashCan or {}
	Octo_ToDoTrashCan.profileKeys = Octo_ToDoTrashCan.profileKeys or {}
	Octo_ToDoTrashCan.profileKeys[curCharName.." - ".. curServer] = Octo_ToDoTrashCan.profileKeys[curCharName.." - ".. curServer] or "OctoUI"
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local curServerShort = E.func_CurServerShort(curServer)
	local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
	local specId, specName, specDescription, specIcon, specRole, specPrimaryStat = GetSpecializationInfo(GetSpecialization())
	local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
	local SPEC_STAT_STRINGS = {
		[LE_UNIT_STAT_STRENGTH] = SPEC_FRAME_PRIMARY_STAT_STRENGTH,
		[LE_UNIT_STAT_AGILITY] = SPEC_FRAME_PRIMARY_STAT_AGILITY,
		[LE_UNIT_STAT_INTELLECT] = SPEC_FRAME_PRIMARY_STAT_INTELLECT,
	}
	if collect and not InCombatLockdown() then
		collect.curServerShort = curServerShort
		collect.Name = curCharName
		collect.curServer = curServer
		collect.className = className
		collect.classFilename = classFilename
		collect.classId = classId
		collect.GUID = curGUID
		collect.Faction = UnitFactionGroup("PLAYER")
		collect.specId = specId or 0
		collect.specName = specName or ""
		collect.specIcon = specIcon or 0
		collect.specRole = specRole or 0
		collect.specPrimaryStat = specPrimaryStat or 0
		collect.specPrimaryStatString = SPEC_FRAME_PRIMARY_STAT:format(SPEC_STAT_STRINGS[specPrimaryStat]) or ""
		collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
		collect.RaceLocal = RaceLocal
		collect.RaceEnglish = RaceEnglish
		collect.raceID = raceID
		collect.classColorHex = classColorHexCurrent
		collect.guildName = guildName
		collect.guildRankName = guildRankName
		collect.guildRankIndex = guildRankIndex
		collect.Chromie_inChromieTime = C_PlayerInfo.IsPlayerInChromieTime()
		collect.Chromie_canEnter = C_PlayerInfo.CanPlayerEnterChromieTime()
		collect.Chromie_UnitChromieTimeID = UnitChromieTimeID("player")
		collect.Chromie_name = E.NONE
		collect.GameLimitedMode_IsActive = GameLimitedMode_IsActive
		for i = 1, #expansionOptions do
			if expansionOptions[i].id == UnitChromieTimeID("player") then
				local expansionChromie = expansionOptions[i].name
				collect.Chromie_name = tostring(expansionChromie)
			end
		end
		collect.BattleTag = BattleTag
		collect.BattleTagLocal = BattleTagLocal
		collect.buildVersion = buildVersion
		collect.buildNumber = buildNumber
		collect.buildDate = buildDate
		collect.interfaceVersion = interfaceVersion
		collect.currentTier = currentTier
		collect.IsPublicBuild = IsPublicBuild
		collect.isBeta = isBeta
		collect.GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData())
		collect.GetRestrictedAccountData_rMoney = select(2, GetRestrictedAccountData())
		collect.GetRestrictedAccountData_profCap = select(3, GetRestrictedAccountData())
		collect.IsAccountSecured = IsAccountSecured
		collect.IsRestrictedAccount = IsRestrictedAccount
		collect.IsTrialAccount = IsTrialAccount
		collect.IsVeteranTrialAccount = IsVeteranTrialAccount
	end
end
function Octo_EventFrame:Collect_All_Covenant()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local curCovID = C_Covenants.GetActiveCovenantID() or 0
	if curCovID > 0 then
		local curCovName = E.OctoTable_Covenant[curCovID].name
		local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
		local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
		local curAnimaAmount = currencyInfo.quantity
		if collect then
			collect.CovenantAndAnima.curCovID = curCovID
			collect.CovenantAndAnima = collect.CovenantAndAnima or {}
			collect.CovenantAndAnima[curCovID][1] = curCovLevel
			collect.CovenantAndAnima[curCovID][2] = curAnimaAmount
		end
	end
end
function Octo_EventFrame:Collect_All_PlayerDurability()
	local collect = Octo_ToDo_DB_Levels[curGUID]
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
	if collect then
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
function Octo_EventFrame:Collect_Player_Level()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local UnitLevel = UnitLevel("PLAYER") or 0
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
	if collect then
		collect.UnitLevel = UnitLevel
		collect.currentXP = currentXP
		collect.UnitXPMax = UnitXPMax
		collect.UnitXPPercent = UnitXPPercent
		if UnitLevel == E.currentMaxLevel then
			collect.PlayerCanEarnExperience = false
		else
			if GameLimitedMode_IsActive == true then
				if UnitLevel >= GetRestrictedAccountData_rLevel then
					if MainStatusTrackingBarContainer and MainStatusTrackingBarContainer:IsShown() then
						tinsert(MustBeHiddenFrames_table, {name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer})
					end
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
function Octo_EventFrame:Collect_Played(totalTime, currentLevelTime)
	local collect = Octo_ToDo_DB_Levels[curGUID]
	if collect then
		collect.realTotalTime = totalTime
		collect.realLevelTime = currentLevelTime
	end
end
function Octo_EventFrame:Collect_WarMode()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local WarMode = C_PvP.IsWarModeDesired()
	if collect then
		collect.WarMode = WarMode
	end
end
function Octo_EventFrame:Collect_ALL_Mail()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local hasMail = HasNewMail()
	if collect and not InCombatLockdown() then
		collect.hasMail = hasMail
	end
end
function Octo_EventFrame:Collect_ALL_LoginTime()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	collect.loginDate = date("%d.%m.%Y %H:%M:%S")
	collect.loginDay = date("%d.%m.%Y")
	collect.loginHour = date("%H:%M")
	collect.needResetWeekly = false
	collect.needResetDaily = false
	collect.needResetMonth = false
	collect.time = time()
end
function Octo_EventFrame:Collect_All_Professions()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	if collect then
		collect.MASLENGO = collect.MASLENGO or {}
		collect.MASLENGO.professions = collect.MASLENGO.professions or {}
		for i, id in next, {GetProfessions()} do
			collect.MASLENGO.professions[i] = collect.MASLENGO.professions[i] or {}
			local _, _, skillLevel, maxSkillLevel, _, _, skillLine = GetProfessionInfo(id)
			collect.MASLENGO.professions[i].skillLine = skillLine
			collect.MASLENGO.professions[i].skillLevel = skillLevel
			collect.MASLENGO.professions[i].maxSkillLevel = maxSkillLevel
		end
	end
end
function Octo_EventFrame:Collect_ALL_GreatVault()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local mapChallengeModeIDs = C_ChallengeMode.GetMapTable()
	C_MythicPlus.RequestRewards()
	local currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel = C_MythicPlus.GetWeeklyChestRewardLevel() or 0
	C_MythicPlus.RequestMapInfo()
	for i = 1, #mapChallengeModeIDs do
		local _, level = C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeIDs[i])
		if level and level > currentWeekBestLevel then
			currentWeekBestLevel = level
		end
	end
	collect.RIO_Score_TWW_S1 = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
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
		local activity_name = name_activities[i]
		for k = 1, #activities do
			local activityInfo = activities[k]
			if activityInfo then
				local tip = activityInfo.type
				if collect and tip ~= nil then
					collect.GreatVault[tip] = collect.GreatVault[tip] or {}
					collect.GreatVault[tip].type = activity_name
					collect.GreatVault[tip].progress = activityInfo.progress
					collect.GreatVault[tip].threshold = activityInfo.threshold
					local hyperlink = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					hyperlink_STRING = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
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
function Octo_EventFrame:Collect_All_Currency_TEST2()
	OCTO_DB_currencies_test = OCTO_DB_currencies_test or {}
	local expanded = {}
	for index = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader and not info.isHeaderExpanded then
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
		if info.isHeader and expanded[info.name] then
			ExpandCurrencyList(index, false)
		end
	end
end
function Octo_EventFrame:Collect_All_Reputations_TEST2()
	OCTO_DB_reputations_test = OCTO_DB_reputations_test or {}
	Octo_ToDoTrashCan.Reputations = Octo_ToDoTrashCan.Reputations or {}
	local collapsed = {}
	local index = 1
	while index <= C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData and factionData.isHeader and factionData.isCollapsed then
			C_Reputation.ExpandFactionHeader(index)
			collapsed[factionData.name] = true
		end
		index = index + 1
	end
	local tblHeader
	local tblHeader2
	for index = 1, C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData then
			local reputationID = factionData.factionID
			local currentStanding = factionData.currentStanding
			local isHeaderWithRep = factionData.isHeaderWithRep
			if factionData.isHeader and currentStanding == 0 then
				OCTO_DB_reputations_test[reputationID] = OCTO_DB_reputations_test[reputationID] or {}
				tblHeader = OCTO_DB_reputations_test[reputationID]
				Octo_ToDoTrashCan.Reputations[reputationID] = Octo_ToDoTrashCan.Reputations[reputationID] or {}
				tblHeader2 = Octo_ToDoTrashCan.Reputations[reputationID]
			else
				tblHeader[reputationID] = tblHeader[reputationID] or false
				tblHeader2[reputationID] = tblHeader2[reputationID] or false
			end
		end
	end
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData and collapsed[factionData.name] then
			C_Reputation.CollapseFactionHeader(index)
		end
	end
end
function Octo_EventFrame:Collect_All_Currency()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	Octo_ToDo_DB_Config = Octo_ToDo_DB_Config or {}
	collect = collect or {}
	collect.MASLENGO = collect.MASLENGO or {}
	if not InCombatLockdown() then
		local Collapsed = {}
		local listSize, i = C_CurrencyInfo.GetCurrencyListSize(), 1
		local headerIndex
		while listSize >= i do
			local info = C_CurrencyInfo.GetCurrencyListInfo(i)
			if info.isHeader then
				C_CurrencyInfo.ExpandCurrencyList(i, true)
				Collapsed[info.name] = true
				listSize = C_CurrencyInfo.GetCurrencyListSize()
				headerIndex = i
			elseif info.name then
				local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
				local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
				local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
				local quantity = currencyInfo.quantity
				local name = info.name
				if currencyID then
					Octo_ToDo_DB_Config.CurrencyDB[currencyID] = Octo_ToDo_DB_Config.CurrencyDB[currencyID] or false
				end
			end
			i = i + 1
		end
	end
	for CurrencyID, v in next, (Octo_ToDo_DB_Config.CurrencyDB) do
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
				for GUID, tbl in next, (Octo_ToDo_DB_Levels) do
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
function Octo_EventFrame:Collect_All_Reputations()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	if collect and not InCombatLockdown() then
		local listSize, i = C_Reputation.GetNumFactions(), 1
		C_Reputation.ExpandAllFactionHeaders()
		while listSize >= i do
			local factionData = C_Reputation.GetFactionDataByIndex(i)
			local reputationID = factionData.factionID
			local description = factionData.description or ""
			if reputationID and description ~= "" then
				Octo_ToDo_DB_Config.ReputationDB[reputationID] = Octo_ToDo_DB_Config.ReputationDB[reputationID] or false
			end
			i = i + 1
		end
		for reputationID, v in next, (Octo_ToDo_DB_Config.ReputationDB) do
			local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
			if isAccountWide == false then
				collect.MASLENGO.reputationID[reputationID] = E.func_CheckReputationByRepID(reputationID) or 0
			else
				for GUID, tbl in next, (Octo_ToDo_DB_Levels) do
					tbl.MASLENGO.reputationID[reputationID] = E.func_CheckReputationByRepID(reputationID) or 0
				end
			end
		end
	end
end
function Octo_EventFrame:Collect_ALL_ItemsInBag()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local usedSlots = 0
	local totalSlots = 0
	local Possible_Anima = 0
	local Possible_CatalogedResearch = 0
	local Abbr_En_Name = E.NONE
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
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(hyperlink)
				if Octo_ToDo_DB_Vars.config.ItemsUsable then
					OctpToDo_FIRST_inspectScantip:ClearLines()
					OctpToDo_FIRST_inspectScantip:SetHyperlink(hyperlink)
					if OctpToDo_FIRST_inspectScantip:NumLines() > 0 then
						for i = 1, OctpToDo_FIRST_inspectScantip:NumLines() do
							local text = _G["OctoToDoScanningTooltipFIRSTTextLeft"..i]:GetText()
							local r, g, b, a = _G["OctoToDoScanningTooltipFIRSTTextLeft"..i]:GetTextColor()
							local QWE = E.func_coloredText(_G["OctoToDoScanningTooltipFIRSTTextLeft"..i])
							if QWE:find(E.func_OnlyFirstWord(ITEM_CLASSES_ALLOWED)) and QWE:find(USE_COLON) or QWE:find("Манускрипт наблюдений за драконами") or QWE:find("Drakewatcher Manuscript") then
								E.OctoTable_itemID_ItemsUsable[itemID] = 1
							end
							if QWE:find(ITEM_COSMETIC) or QWE:find(TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN) or QWE:find(TRANSMOGRIFY_STYLE_UNCOLLECTED) then
								E.OctoTable_itemID_ItemsUsable[itemID] = 1
							end
						end
					end
					OctpToDo_FIRST_inspectScantip:ClearLines()
					if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") or hyperlink:find("keystone:151086") then
						local dungeonID = select(3, strsplit(":", hyperlink))
						local lvl = select(4, strsplit(":", hyperlink))
						collect.CurrentKeyLevel = tonumber(lvl)
						collect.CurrentKeyFULL = C_ChallengeMode.GetMapUIInfo(dungeonID)
						for k, v in next, (E.OctoTable_KeystoneAbbr) do
							if v.mapChallengeModeID == tonumber(dungeonID) then
								collect.CurrentKey = lvl.." "..v.abbreviation
							end
						end
					end
				end
				for k, v in next, (E.OctoTable_itemID_Cataloged_Research) do
					if itemID == v.itemiD then
						Possible_CatalogedResearch = Possible_CatalogedResearch + v.count
					end
				end
				local isAnima = C_Item.IsAnimaItemByID(itemID)
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
				if itemType == "Рецепт" then
					E.OctoTable_itemID_ItemsUsable[itemID] = 1
				end
				if itemType == MISCELLANEOUS and itemSubType == MOUNTS and itemID ~= 37011 then
					E.OctoTable_itemID_ItemsUsable[itemID] = 1
				end
				if itemType == MISCELLANEOUS and itemSubType == "Питомцы" or itemSubType == "Pets" or itemSubType == "Companion Pets" then
					E.OctoTable_itemID_ItemsUsable[itemID] = 1
				end
			end
		end
	end
	Octo_ToDo_DB_Config = Octo_ToDo_DB_Config or {}
	Octo_ToDo_DB_Config.ItemDB = Octo_ToDo_DB_Config.ItemDB or {}
	if collect and not InCombatLockdown() then
		collect.MASLENGO = collect.MASLENGO or {}
		collect.MASLENGO.ItemsInBag = collect.MASLENGO.ItemsInBag or {}
		for _, itemID in next, (E.OctoTable_itemID_ALL) do
			local count = GetItemCount(itemID, true, true, true)
			collect.MASLENGO.ItemsInBag[itemID] = count
		end
		collect.Possible_Anima = Possible_Anima
		collect.Possible_CatalogedResearch = Possible_CatalogedResearch
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
		collect.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	end
end
function Octo_EventFrame:Collect_ALL_EncounterAndZoneLists()
	local clear = false
	if clear == true then
		Octo_ToDo_DB_Other.EncounterAndZoneLists = {}
	else
		Octo_ToDo_DB_Other.EncounterAndZoneLists = Octo_ToDo_DB_Other.EncounterAndZoneLists or {}
		for tier = 1, EJ_GetNumTiers() do
			EJ_SelectTier(tier)
			local tierName = EJ_GetTierInfo(tier)
			Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName] = Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName] or {}
			for _, inRaid in next, ({false, true}) do
				local instance_index = 1
				local instance_id = EJ_GetInstanceByIndex(instance_index, inRaid)
				local title = ("%s"):format(inRaid and RAIDS or DUNGEONS)
				Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title] = Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title] or {}
				while instance_id do
					EJ_SelectInstance(instance_id)
					local instance_name, _, _, _, _, icon, dungeonAreaMapID = EJ_GetInstanceInfo(instance_id)
					Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name] = Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name] or {}
					if dungeonAreaMapID and dungeonAreaMapID ~= 0 then
						local mapGroupId = C_Map.GetMapGroupID(dungeonAreaMapID)
						if mapGroupId then
							Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name].ZoneID = tostringall("g"..mapGroupId)
						else
							Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name].ZoneID = dungeonAreaMapID
						end
						Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name].instance_id = instance_id
						Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName][title][instance_name].icon = icon
					end
					instance_index = instance_index + 1
					instance_id = EJ_GetInstanceByIndex(instance_index, inRaid)
				end
			end
		end
	end
end
function Octo_EventFrame:Collect_ALL_Locations()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local mapID = C_Map.GetBestMapForUnit("player")
	if mapID then
		local BindLocation = GetBindLocation()
		local info = C_Map.GetMapInfo(mapID)
		if info and collect and not InCombatLockdown() then
			collect.BindLocation = BindLocation
			collect.CurrentLocation = info.name or "no CurrentLocation"
		end
	end
end
function Octo_EventFrame:Collect_All_Quests()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for questID, v in next, (Octo_ToDo_DB_Config.QuestsDB) do
		local vivod = E.func_CheckCompletedByQuestID(questID)
		collect.MASLENGO.OctoTable_QuestID[questID] = vivod
	end
	if collect then
		collect.numShownEntries = numShownEntries or 0
		collect.numQuests = E.func_CurrentNumQuests()
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept or 0
	end
end
function Octo_EventFrame:Collect_ALL_ItemLevel()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	if collect and not InCombatLockdown() then
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function Octo_EventFrame:Collect_ALL_UNIVERSALQuestUpdate()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	collect.MASLENGO.UniversalQuest = collect.MASLENGO.UniversalQuest or {}
	Octo_ToDoTrashCan.UniversalQuest = {}
	for i, v in next, (E.OctoTable_UniversalQuest) do
		for _, w in next, (v) do
			local count = 0
			local vivod = ""
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
			Octo_ToDoTrashCan.UniversalQuest[v.desc] = Octo_ToDoTrashCan.UniversalQuest[v.desc] or {}


			Octo_ToDoTrashCan.UniversalQuest[v.desc][i] = Octo_ToDoTrashCan.UniversalQuest[v.desc][i] or tostringall("CharInfo.MASLENGO.UniversalQuest.".."Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset)
			if collect then
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
function Octo_EventFrame:Collect_ALL_MoneyUpdate()
	Octo_ToDo_DB_Levels[UnitGUID("PLAYER")].Money = GetMoney() or 0
	Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] = C_Bank.FetchDepositedMoney(2)
end
function Octo_EventFrame:Collect_ALL_MoneyOnLogin()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.MoneyOnLogin = Money
	end
end
function Octo_EventFrame:Collect_All_journalInstance()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	if not InCombatLockdown() then
		if ((GetNumSavedInstances() + GetNumSavedWorldBosses() > 0) and not RaidInfoFrame:IsVisible()) then
			ToggleRaidFrame()
			RaidInfoFrame:Show()
		end
		if (not RaidFrame:IsVisible()) then
			ToggleRaidFrame()
		end
		if RaidFrame:IsVisible() then
			HideUIPanel(RaidFrame)
		end
		if FriendsFrame:IsVisible() then
			HideUIPanel(FriendsFrame)
		end
		if RaidInfoFrame:IsVisible() then
			HideUIPanel(RaidInfoFrame)
		end
		local numsaved = GetNumSavedInstances()
		local DiffAbbr = ""
		local instancesLastBoss = {}
		local ServerTime = GetServerTime()
		if collect.journalInstance == 0 then
			collect.journalInstance = {}
		end
		collect.journalInstance = collect.journalInstance or {}
		if numsaved > 0 then
			for i = 1, numsaved do
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
					vivod = color..defeatedBosses.."/"..totalBosses.."|r"
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
function Octo_EventFrame:function_setBackup()
	local backup = Octo_ToDo_DB_Other.CVar
	backup.calendarShowHolidays = GetCVarBool("calendarShowHolidays")
	backup.calendarShowDarkmoon = GetCVarBool("calendarShowDarkmoon")
	backup.calendarShowLockouts = GetCVarBool("calendarShowLockouts")
	backup.calendarShowWeeklyHolidays = GetCVarBool("calendarShowWeeklyHolidays")
	backup.calendarShowBattlegrounds = GetCVarBool("calendarShowBattlegrounds")
	if not backup.calendarShowHolidays then
		SetCVar("calendarShowHolidays", "1")
	end
	if not backup.calendarShowDarkmoon then
		SetCVar("calendarShowDarkmoon", "1")
	end
	if backup.calendarShowLockouts then
		SetCVar("calendarShowLockouts", "0")
	end
	if backup.calendarShowWeeklyHolidays then
		SetCVar("calendarShowWeeklyHolidays", "0")
	end
	if backup.calendarShowBattlegrounds then
		SetCVar("calendarShowBattlegrounds", "0")
	end
	Octo_ToDo_DB_Other.CVar.dateBackup = C_Calendar.GetMonthInfo()
	if CalendarFrame then
		CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end
function Octo_EventFrame:function_restoreBackup()
	local backup = Octo_ToDo_DB_Other.CVar
	if not backup.calendarShowHolidays then
		SetCVar("calendarShowHolidays", "0")
	end
	if not backup.calendarShowDarkmoon then
		SetCVar("calendarShowDarkmoon", "0")
	end
	if backup.calendarShowLockouts then
		SetCVar("calendarShowLockouts", "1")
	end
	if backup.calendarShowWeeklyHolidays then
		SetCVar("calendarShowWeeklyHolidays", "1")
	end
	if backup.calendarShowBattlegrounds then
		SetCVar("calendarShowBattlegrounds", "1")
	end
	if CalendarFrame then
		CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end
function Octo_EventFrame:Collect_All_Holiday()
	local collect = Octo_ToDo_DB_Other.Holiday
	if not E.IsAddOnLoaded("Blizzard_Calendar") then
		E.LoadAddOn("Blizzard_Calendar")
		ShowUIPanel(CalendarFrame, true)
		HideUIPanel(CalendarFrame)
	end
	self:function_setBackup()
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local minute = currentCalendarTime.minute
	local hour = currentCalendarTime.hour
	local weekday = currentCalendarTime.weekday
	local monthDay = currentCalendarTime.monthDay
	local month = 0
	local year = currentCalendarTime.year
	local numEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	collect.Active = {}
	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(month, monthDay, i)
		local id = event.eventID
		collect.Collect[id] = E.func_EventName(id)
		local startTime = event.startTime
		local endTime = event.endTime
		if startTime and endTime and id then
			local startTime_year = startTime.year
			local startTime_month = startTime.month
			local startTime_monthDay = startTime.monthDay
			local endTime_year = endTime.year
			local endTime_month = endTime.month
			local endTime_monthDay = endTime.monthDay
			if collect.Active[id] == nil then
				collect.Active[id] = {}
			end
			collect.Active[id].id = id
			collect.Active[id].title = E.func_EventName(id)
			collect.Active[id].startTime = startTime_monthDay.."/"..startTime_month.."/"..startTime_year
			collect.Active[id].endTime = endTime_monthDay.."/"..endTime_month.."/"..endTime_year
		end
	end
	self:function_restoreBackup()
end
function Octo_EventFrame:Collect_BfA_Azerite()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		if totalLevelXP and totalLevelXP ~= 0 then
			if collect and not InCombatLockdown() then
				collect.azeriteLVL = currentLevel
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E.func_CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
function Octo_EventFrame:Collect_BfA_Cloaklvl()
	local collect = Octo_ToDo_DB_Levels[curGUID]
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
			OctpToDo_FIRST_inspectScantip:SetInventoryItem("player", 15)
			if OctpToDo_FIRST_inspectScantip:NumLines() > 0 then
				for j = 2, OctpToDo_FIRST_inspectScantip:NumLines() do
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
			OctpToDo_FIRST_inspectScantip:ClearLines()
		end
	else
		collect.cloak_lvl = 0
		collect.cloak_res = 0
	end
end
function Octo_EventFrame:Collect_BfA_QuestsBounties()
	local collect = Octo_ToDo_DB_Levels[curGUID]
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
				collect["bounty_Legion"..i] = E.func_CheckCompletedByQuestID(d.questID)
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
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
				local faction_icon = "|T"..d.icon..":0|t "
				if collect and not InCombatLockdown() then
					collect["bounty_BfA"..i] = E.func_CheckCompletedByQuestID(d.questID)
					collect["bounty_BfA"..i.."_icon"] = faction_icon
					collect["bounty_BfA"..i.."_questID"] = d.questID
					collect["bounty_BfA"..i.."_end"] = time() + secondsLeft * 60
				end
			end
		end
	end
end
function Octo_EventFrame:Collect_BfA_Island()
	local collect = Octo_ToDo_DB_Levels[curGUID]
	local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	if questID then
		if collect and not InCombatLockdown() then
			collect.islandBfA = E.func_CheckCompletedByQuestID(questID)
		end
	end
end
function Octo_EventFrame:Octo_ToDo_FIRST_OnLoad()
	if not OctpToDo_FIRST_inspectScantip then
		OctpToDo_FIRST_inspectScantip = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_FIRST_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function Octo_EventFrame:O_otrisovka_FIRST()
	OctoTable_func_otrisovka_FIRST = {}
	tinsert(OctoTable_func_otrisovka_FIRST,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
			BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
			vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			if CharInfo.Faction == "Horde" then
				BG:SetColorTexture(.5, 0, 0, E.BGALPHA*2)
			else
				BG:SetColorTexture(0, 0, .5, E.BGALPHA*2)
			end
			if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.PlayerCanEarnExperience == true then
				CL:SetFontObject(OctoFont11)
				vivodCent = vivodCent.." "..E.Yellow_Color..CharInfo.UnitLevel.."|r"
			end
			if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer == false then
				CL:SetFontObject(OctoFont9)
				vivodCent = vivodCent.."|n"..CharInfo.curServer
			end
			local classColor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal then
				if CharInfo.guildRankIndex ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", "<"..E.Green_Color..CharInfo.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.guildRankName.."|r".."]"}
				else
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", " "}
				end
				if CharInfo.WarMode == true then
					tooltip[#tooltip+1] = {CharInfo.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or "", ""}
				end
				if CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.UnitXPPercent then
					tooltip[#tooltip+1] = {CharInfo.RaceLocal.." "..CharInfo.classColorHex..CharInfo.UnitLevel.."-го|r уровня "..CharInfo.classColorHex..CharInfo.UnitXPPercent.."%|r", " "}
				else
					tooltip[#tooltip+1] = {CharInfo.RaceLocal, " "}
				end
				if CharInfo.specName ~= 0 or CharInfo.specName ~= 0 then
					tooltip[#tooltip+1] = {E.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className, " "}
				end
				tooltip[#tooltip+1] = {" ", " "}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			if CharInfo.totalSlots ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(133634)..L["Bags"], CharInfo.classColorHex..(CharInfo.usedSlots.."/"..CharInfo.totalSlots).."|r"}
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tooltip[#tooltip+1] = {E.func_texturefromIcon(236664)..QUESTS_LABEL, CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"}
			end
			if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..(E.func_SecondsToClock(CharInfo.realTotalTime)).."|r")}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..(E.func_SecondsToClock(CharInfo.realLevelTime)).."|r")}
			end
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"hasMail", CharInfo.hasMail and E.Icon_MailBox..CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Chromie_canEnter", CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {"Chromie_UnitChromieTimeID", CharInfo.Chromie_UnitChromieTimeID.."|r"}
			tooltip[#tooltip+1] = {"Chromie_name", CharInfo.classColorHex..CharInfo.Chromie_name.."|r"}
			tooltip[#tooltip+1] = {"BattleTag", E.Blue_Color..CharInfo.BattleTag.."|r"}
			tooltip[#tooltip+1] = {"BattleTagLocal", E.Blue_Color..CharInfo.BattleTagLocal.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"GameLimitedMode_IsActive", CharInfo.GameLimitedMode_IsActive and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {"levelCapped20", CharInfo.levelCapped20 and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {"PlayerCanEarnExperience", CharInfo.PlayerCanEarnExperience and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"buildVersion", CharInfo.classColorHex..CharInfo.buildVersion.."|r"}
			tooltip[#tooltip+1] = {"buildNumber", CharInfo.classColorHex..CharInfo.buildNumber.."|r"}
			tooltip[#tooltip+1] = {"buildDate", CharInfo.classColorHex..CharInfo.buildDate.."|r"}
			tooltip[#tooltip+1] = {"interfaceVersion", CharInfo.classColorHex..CharInfo.interfaceVersion.."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"currentTier", CharInfo.classColorHex..CharInfo.currentTier.."|r"}
			tooltip[#tooltip+1] = {"IsPublicBuild", CharInfo.IsPublicBuild and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {"isBeta", CharInfo.isBeta and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"max LVL", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rLevel).."|r"}
			tooltip[#tooltip+1] = {"max Money", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rMoney).."|r"}
			tooltip[#tooltip+1] = {"max Prof", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_profCap).."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Authenticator", CharInfo.classColorHex..tostringall(CharInfo.IsAccountSecured).."|r"}
			tooltip[#tooltip+1] = {"УЗ имеет ограничения пробной УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsRestrictedAccount).."|r"}
			tooltip[#tooltip+1] = {"Использует ли игрок пробную УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsTrialAccount).."|r"}
			tooltip[#tooltip+1] = {"Нет игрового времени", CharInfo.classColorHex..tostringall(CharInfo.IsVeteranTrialAccount).."|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"PlayerDurability", CharInfo.PlayerDurability.."%"}
			if CharInfo.MASLENGO.ItemsInBag[122284] ~= 0 then
				tooltip[#tooltip+1] = {E.func_itemTexture(122284)..E.func_itemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
			end
			vivodLeft = E.Timers.Daily_Reset()
			return vivodCent, vivodLeft
		end
	)
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 1 then
		local expansionQWEQWE = 1
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 2 then
		local expansionQWEQWE = 2
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(23572)..E.func_itemName(23572)
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(30183)..E.func_itemName(30183)
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(32428)..E.func_itemName(32428)
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(34664)..E.func_itemName(34664)
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 3 then
		local expansionQWEQWE = 3
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(52019)..E.func_itemName(52019)
				if CharInfo.MASLENGO.ItemsInBag[52019] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52019]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(43102)..E.func_itemName(43102)
				if CharInfo.MASLENGO.ItemsInBag[43102] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[43102]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(45087)..E.func_itemName(45087)
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(47556)..E.func_itemName(47556)
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(49908)..E.func_itemName(49908)
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(1358))..E.func_achievementName(1358).." "..E.func_achievementvivod(1358)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_BoreanTundra_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_BoreanTundra_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(1359))..E.func_achievementName(1359).." "..E.func_achievementvivod(1359)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Dragonblight_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Dragonblight_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(1357))..E.func_achievementName(1357).." "..E.func_achievementvivod(1357)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_GrizzlyHills_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_GrizzlyHills_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(1356))..E.func_achievementName(1356).." "..E.func_achievementvivod(1356)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_HowlingFjord_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_HowlingFjord_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(40))..E.func_achievementName(40).." "..E.func_achievementvivod(40)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Icecrown_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Icecrown_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(39))..E.func_achievementName(39).." "..E.func_achievementvivod(39)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_SholazarBasin_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_SholazarBasin_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(38))..E.func_achievementName(38).." "..E.func_achievementvivod(38)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_TheStormPeaks_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_TheStormPeaks_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(E.func_achievementIcon(36))..E.func_achievementName(36).." "..E.func_achievementvivod(36)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_ZulDrak_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_ZulDrak_Once
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(13668)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Tournament_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Tournament_Once
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 4 then
		local expansionQWEQWE = 4
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(52078)..E.func_itemName(52078)
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(69237)..E.func_itemName(69237)
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(71998)..E.func_itemName(71998)
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 5 then
		local expansionQWEQWE = 5
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[697] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[697]
				end
				vivodLeft = E.func_currencyIcon(697)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[776] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[776]
				end
				vivodLeft = E.func_currencyIcon(776)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776)
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 6 then
		local expansionQWEQWE = 6
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1129] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1129]
				end
				vivodLeft = E.func_currencyIcon(1129)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[994] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[994]
				end
				vivodLeft = E.func_currencyIcon(994)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[823] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[823]
				end
				vivodLeft = E.func_currencyIcon(823)..E.func_currencyName(823)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1101] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1101]
				end
				vivodLeft = E.func_currencyIcon(1101)..E.func_currencyName(1101)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[824] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[824]
				end
				vivodLeft = E.func_currencyIcon(824)..E.func_currencyName(824)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Faction == "Alliance" then
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Alliance_Once ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Alliance_Once
					end
				else
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Horde_Once ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WarlordsofDraenor_Garrison_Horde_Once
					end
				end
				if vivodCent ~= "0/3" and vivodCent ~= "" then
					vivodCent = E.func_itemTexture(110560)..vivodCent
				end
				vivodLeft = GARRISON_LOCATION_TOOLTIP
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[38242]
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_itemTexture(122457)
				end
				vivodLeft = E.func_questName(38242).." (ап пета)"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[39246]
				end
				vivodLeft = E.func_questName(39246)
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 7 then
		local expansionQWEQWE = 7
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.Timers.Legion_Invasion().."Timer_Legion_Invasion")
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB"
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - Armies of Legionfall"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46246] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - Excavations"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46666] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - ToArgus"
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(43533)
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1273] then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1273]
				end
				vivodLeft = E.func_currencyIcon(1273)..E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				vivodLeft = E.func_currencyIcon(1508)..E.func_currencyName(1508)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1342]
				vivodLeft = E.func_currencyIcon(1342)..E.func_currencyName(1342)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1220]
				vivodLeft = E.func_currencyIcon(1220)..E.func_currencyName(1220)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1226]
				vivodLeft = E.func_currencyIcon(1226)..E.func_currencyName(1226)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1533]
				vivodLeft = E.func_currencyIcon(1533)..E.func_currencyName(1533)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1155]
				vivodLeft = E.func_currencyIcon(1155)..E.func_currencyName(1155)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				vivodLeft = E.func_itemTexture(124124)..E.func_itemName(124124)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				vivodLeft = "bounty_Legion1"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				vivodLeft = "bounty_Legion2"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				vivodLeft = "bounty_Legion3"
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 8 then
		local expansionQWEQWE = 8
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.Timers.BfA_Invasion().."Timer_BfA_Invasion (PVP)")
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Timers.BfA_Assault().."Timer_BfA_Assault (N'zoth)"
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
				end
				if CharInfo.MASLENGO.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174765]..E.func_itemTexture(174765)
				end
				if CharInfo.MASLENGO.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174761]..E.func_itemTexture(174761)
				end
				if CharInfo.MASLENGO.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174767]..E.func_itemTexture(174767)
				end
				if CharInfo.MASLENGO.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174766]..E.func_itemTexture(174766)
				end
				if CharInfo.MASLENGO.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174768]..E.func_itemTexture(174768)
				end
				if #tooltip > 0 then
					tooltip[#tooltip+1] = {" ", " "}
				end
				tooltip[#tooltip+1] = {E.func_itemTexture(174764)..CharInfo.MASLENGO.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174765]..E.func_itemTexture(174765)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174756)..CharInfo.MASLENGO.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174761]..E.func_itemTexture(174761)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174759)..CharInfo.MASLENGO.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174767]..E.func_itemTexture(174767)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174760)..CharInfo.MASLENGO.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174766]..E.func_itemTexture(174766)}
				tooltip[#tooltip+1] = {E.func_itemTexture(174758)..CharInfo.MASLENGO.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.MASLENGO.ItemsInBag[174768]..E.func_itemTexture(174768)}
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_miniVision_count
				end
				vivodLeft = E.Purple_Color.."Mini Vision".."|r"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB"
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB: Nazjatar"
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBAssault_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: Assault"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB: PVP"
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_Rares.."Rares: Darkshore"
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1560] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1560]
				end
				vivodLeft = E.func_currencyIcon(1560)..E.func_currencyName(1560)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1721] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1721]
				end
				vivodLeft = E.func_currencyIcon(1721)..E.func_currencyName(1721)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1803] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1803]
				end
				vivodLeft = E.func_currencyIcon(1803)..E.func_currencyName(1803)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1755] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_itemTexture(173363)
				end
				vivodLeft = E.func_currencyIcon(1755)..E.func_currencyName(1755)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1719] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1719]
				end
				vivodLeft = E.func_currencyIcon(1719)..E.func_currencyName(1719)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1710] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1710]
				end
				vivodLeft = E.func_currencyIcon(1710)..E.func_currencyName(1710)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1716] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1716]
				end
				vivodLeft = E.func_currencyIcon(1716)..E.func_currencyName(1716)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1718]
				vivodLeft = E.func_currencyIcon(1718)..E.func_currencyName(1718)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[158075] == 0 then
					vivodCent = E.Red_Color.."no neck|r"
				else
					vivodCent = E.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = E.Green_Color..CharInfo.azeriteLVL.."|r".."|n"..E.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				vivodLeft = E.func_itemTexture(158075)..E.func_itemName(158075)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[169223] == 0 then
					vivodCent = E.Red_Color.."no cloak|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[169223] ~= 0 then
					vivodCent = E.Orange_Color.."neeed to equip|r"
					if CharInfo.cloak_lvl ~= 0 then
						vivodCent = CharInfo.cloak_lvl.." lvl"
						if CharInfo.cloak_lvl == 15 then
							vivodCent = E.Green_Color..vivodCent.."|r"
						end
					end
					if CharInfo.cloak_res ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = vivodCent.."|n"..CharInfo.cloak_res
					end
				end
				vivodLeft = E.func_itemTexture(169223)..E.func_itemName(169223)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.islandBfA then
					vivodCent = CharInfo.islandBfA
				end
				vivodLeft = "Octo_EventFrame:Collect_BfA_Island"
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					vivodLeft = E.func_questName(questID)
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront1_count
				end
				vivodLeft = "Warfront: Stromgarde"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront2_count
				end
				vivodLeft = "Warfront: Darkshore"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count
				end
				vivodLeft = "Warfront: Heroic"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				vivodLeft = "bounty_BfA1"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				vivodLeft = "bounty_BfA2"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {E.func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				vivodLeft = "bounty_BfA3"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[166846] ~= 0 or CharInfo.MASLENGO.ItemsInBag[169610] ~= 0 or CharInfo.MASLENGO.ItemsInBag[166970] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168327] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168832] ~= 0 or CharInfo.MASLENGO.ItemsInBag[166971] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168946] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168215] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168216] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168217] ~= 0 then
					tooltip[#tooltip+1] = {E.func_itemTexture(166846)..E.func_itemName(166846), CharInfo.MASLENGO.ItemsInBag[166846]}
					tooltip[#tooltip+1] = {E.func_itemTexture(169610)..E.func_itemName(169610), CharInfo.MASLENGO.ItemsInBag[169610]}
					tooltip[#tooltip+1] = {E.func_itemTexture(166970)..E.func_itemName(166970), CharInfo.MASLENGO.ItemsInBag[166970]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168327)..E.func_itemName(168327), CharInfo.MASLENGO.ItemsInBag[168327]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168832)..E.func_itemName(168832), CharInfo.MASLENGO.ItemsInBag[168832]}
					tooltip[#tooltip+1] = {E.func_itemTexture(166971)..E.func_itemName(166971), CharInfo.MASLENGO.ItemsInBag[166971]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168946)..E.func_itemName(168946), CharInfo.MASLENGO.ItemsInBag[168946]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168215)..E.func_itemName(168215), CharInfo.MASLENGO.ItemsInBag[168215]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168216)..E.func_itemName(168216), CharInfo.MASLENGO.ItemsInBag[168216]}
					tooltip[#tooltip+1] = {E.func_itemTexture(168217)..E.func_itemName(168217), CharInfo.MASLENGO.ItemsInBag[168217]}
					vivodCent = "МЕХАГОН"
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
		local expansionQWEQWE = 9
		for k = 1, 2 do
			for i = 1, 4 do
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
						vivodLeft = E.func_texturefromIcon(E.OctoTable_Covenant[i].icon)..E.OctoTable_Covenant[i].color..E.OctoTable_Covenant[i].name.."|r"
						if k == 1 then
							vivodCent = CharInfo.CovenantAndAnima[i][k]
							vivodLeft = vivodLeft
						else
							vivodLeft = vivodLeft..E.func_currencyIcon(1813)
							vivodCent = CharInfo.CovenantAndAnima[i][k]
						end
						if CharInfo.CovenantAndAnima[i][k] == 0 then
							vivodCent = " "
						end
						vivodCent = E.OctoTable_Covenant[i].color..vivodCent.."|r"
						if i == CharInfo.CovenantAndAnima.curCovID then
							BG:SetColorTexture(E.OctoTable_Covenant[i].r, E.OctoTable_Covenant[i].g, E.OctoTable_Covenant[i].b, E.BGALPHA*2)
							if CharInfo.Possible_Anima ~= 0 and k == 2 then
								vivodCent = vivodCent .. E.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
							end
						else
							BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
						end
						return vivodCent, vivodLeft
					end
				)
			end
		end
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Maw: Covenant Assault "..E.Timers.SL_Maw_Assault()
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2009] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2009]
				end
				vivodLeft = E.func_currencyIcon(2009)..E.func_currencyName(2009)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1906] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1906]
				end
				vivodLeft = E.func_currencyIcon(1906)..E.func_currencyName(1906)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1828] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1828]
				end
				vivodLeft = E.func_currencyIcon(1828)..E.func_currencyName(1828)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1979] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1979]
				end
				vivodLeft = E.func_currencyIcon(1979)..E.func_currencyName(1979)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1931] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1931]
				end
				vivodLeft = E.func_currencyIcon(1931)..E.func_currencyName(1931)
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				vivodLeft = E.func_texturefromIcon(4074774)..E.func_questName(66042)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				vivodLeft = E.func_texturefromIcon(4066373)..E.func_questName(63949)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss"
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: "..E.func_questName(65143)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: "..E.func_questName(64531)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				vivodLeft = E.func_currencyIcon(1813)..E.func_questName(61981)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Кузня творения"
				tooltip[#tooltip+1] = {E.func_itemTexture(188957)..E.func_itemName(188957), CharInfo.MASLENGO.ItemsInBag[188957]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(187634)..E.func_itemName(187634), CharInfo.MASLENGO.ItemsInBag[187634]}
				tooltip[#tooltip+1] = {E.func_itemTexture(187636)..E.func_itemName(187636), CharInfo.MASLENGO.ItemsInBag[187636]}
				tooltip[#tooltip+1] = {E.func_itemTexture(187633)..E.func_itemName(187633), CharInfo.MASLENGO.ItemsInBag[187633]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189146)..E.func_itemName(189146), CharInfo.MASLENGO.ItemsInBag[189146]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189145)..E.func_itemName(189145), CharInfo.MASLENGO.ItemsInBag[189145]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189147)..E.func_itemName(189147), CharInfo.MASLENGO.ItemsInBag[189147]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189148)..E.func_itemName(189148), CharInfo.MASLENGO.ItemsInBag[189148]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189149)..E.func_itemName(189149), CharInfo.MASLENGO.ItemsInBag[189149]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189151)..E.func_itemName(189151), CharInfo.MASLENGO.ItemsInBag[189151]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189152)..E.func_itemName(189152), CharInfo.MASLENGO.ItemsInBag[189152]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189153)..E.func_itemName(189153), CharInfo.MASLENGO.ItemsInBag[189153]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189154)..E.func_itemName(189154), CharInfo.MASLENGO.ItemsInBag[189154]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189155)..E.func_itemName(189155), CharInfo.MASLENGO.ItemsInBag[189155]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189156)..E.func_itemName(189156), CharInfo.MASLENGO.ItemsInBag[189156]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_itemTexture(189157)..E.func_itemName(189157), CharInfo.MASLENGO.ItemsInBag[189157]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189158)..E.func_itemName(189158), CharInfo.MASLENGO.ItemsInBag[189158]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189159)..E.func_itemName(189159), CharInfo.MASLENGO.ItemsInBag[189159]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189160)..E.func_itemName(189160), CharInfo.MASLENGO.ItemsInBag[189160]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189161)..E.func_itemName(189161), CharInfo.MASLENGO.ItemsInBag[189161]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189162)..E.func_itemName(189162), CharInfo.MASLENGO.ItemsInBag[189162]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189163)..E.func_itemName(189163), CharInfo.MASLENGO.ItemsInBag[189163]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189164)..E.func_itemName(189164), CharInfo.MASLENGO.ItemsInBag[189164]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189165)..E.func_itemName(189165), CharInfo.MASLENGO.ItemsInBag[189165]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189166)..E.func_itemName(189166), CharInfo.MASLENGO.ItemsInBag[189166]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189167)..E.func_itemName(189167), CharInfo.MASLENGO.ItemsInBag[189167]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189168)..E.func_itemName(189168), CharInfo.MASLENGO.ItemsInBag[189168]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189169)..E.func_itemName(189169), CharInfo.MASLENGO.ItemsInBag[189169]}
				tooltip[#tooltip+1] = {E.func_itemTexture(189170)..E.func_itemName(189170), CharInfo.MASLENGO.ItemsInBag[189170]}
				local count = 0
				if CharInfo.MASLENGO.ItemsInBag[188957] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187634] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187636] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[187633] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189146] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189145] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189147] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189148] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189149] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189151] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189152] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189153] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189154] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189155] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189156] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189157] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189158] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189159] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189160] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189161] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189162] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189163] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189164] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189165] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189166] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189167] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189168] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189169] >= 1 then
					count = count + 1
				end
				if CharInfo.MASLENGO.ItemsInBag[189170] >= 1 then
					count = count + 1
				end
				vivodCent = count.."/".."29"
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
		local expansionQWEQWE = 10
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1603189)..L["Aiding the Accord"]
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= "" and CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(629056)..E.Timers.DF_CommunityFeast()..L["Community Feast"]
				if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
				end
				if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200652]..E.func_itemTexture(200652)
				end
				if CharInfo.MASLENGO.ItemsInBag[200095] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200095]..E.func_itemTexture(200095)
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(236469)..E.Timers.DF_ResearchersUnderFire()..E.func_questName(74906)
				if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.MASLENGO.OctoTable_QuestID[75630]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.MASLENGO.OctoTable_QuestID[75629]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.MASLENGO.OctoTable_QuestID[75628]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.MASLENGO.OctoTable_QuestID[75627]}
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(75665)
				if CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_texturefromIcon(134206)..E.Timers.DF_Flower()..E.func_questName(78319)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(78821)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(78444)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_questName(78381)
				if CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.func_texturefromIcon(628677)..E.Timers.DF_TimeRift()..L["TimeRift"])
				if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(209856)..E.func_itemName(209856)
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(207002)..E.func_itemName(207002)
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= 0 then
					vivodCent = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2594] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= 0 then
					vivodCent = vivodCent..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_itemTexture(208945)
				end
				vivodLeft = E.func_currencyIcon(2594)..E.func_currencyName(2594)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.func_texturefromIcon(134206)..E.Timers.DF_Dreamsurges()..L["Dreamsurges"])
				if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
				end
				if CharInfo.MASLENGO.ItemsInBag[209419] ~= 0 then
					tooltip[#tooltip+1] = {E.func_texturefromIcon(1044087)..E.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.MASLENGO.ItemsInBag[209419]}
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(210254)..E.WOW_Epic_Color..E.func_itemName_NOCOLOR(210254).."|r"
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= 0 then
					vivodCent = vivodCent..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(207026)..E.WOW_Common_Color..E.func_itemName_NOCOLOR(207026).."|r"
				if CharInfo.MASLENGO.ItemsInBag[207026] ~= 0 then
					vivodCent = E.WOW_Common_Color..CharInfo.MASLENGO.ItemsInBag[207026].."|r"
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2245] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2245]
				end
				vivodLeft = E.func_currencyIcon(2245)..E.func_currencyName(2245)
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(213089)..E.func_itemName(213089)
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(211516)..E.func_itemName(211516)
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_itemTexture(211515)..E.func_itemName(211515)
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 11 then
		local expansionQWEQWE = 11
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(4352494)..E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
					if CharInfo.UnitLevel == E.currentMaxLevel then
						if CharInfo.CurrentKeyFULL ~= 0 then
							tooltip[#tooltip+1] = {E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
							tooltip[#tooltip+1] = {" ", " "}
						end
					end
					local Enum_Activities_table = {}
					for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
						Enum_Activities_table[#Enum_Activities_table+1] = i
					end
					sort(Enum_Activities_table)
					for j = 1, #Enum_Activities_table do
						local i = Enum_Activities_table[j]
						if CharInfo.GreatVault[i] and CharInfo.GreatVault[i].type ~= "" then
							CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
							CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
							CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
							CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
							if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.GreatVault[i].progress ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
							end
						end
					end
					if CharInfo.RIO_Score_TWW_S1 ~= 0 then
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_Score_TWW_S1.."|r"}
						tooltip[#tooltip+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_weeklyBest_TWW_S1.."|r"}
					end
					if CharInfo.CurrentKey ~= 0 then
						vivodCent = E.func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKey.."|r"
					end
					if CharInfo.HasAvailableRewards then
						vivodCent = vivodCent..E.Blue_Color..">Vault<|r"
					end
					if CharInfo.Chromie_inChromieTime == true then
						vivodCent = vivodCent..E.Red_Color..CharInfo.Chromie_name.."|r"
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.BeledarCycle == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.Timers.TWW_BeledarCycle() .. E.func_questName(83240)
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.Icon_WorldBoss..L["World Boss"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = L["Weekly Dungeon Quest"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = "TWW_Delve_Weekly"
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(132863) .. L["Major Keyflames"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(135619) .. L["Minor Keyflames"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					vivodLeft = E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					vivodLeft = E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					vivodLeft = E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					vivodLeft = E.func_currencyIcon(currencyID)..color..E.func_currencyName(currencyID).."|r"
					local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
					if data then
						local maxQuantity = data.maxQuantity
						local totalEarned = data.totalEarned
						if CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							tooltip[#tooltip+1] = {TOTAL, color..CharInfo.MASLENGO.CurrencyID[currencyID].."|r"}
							tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID].."|r"}
						else
							tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
						end
						if CharInfo.MASLENGO.CurrencyID[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] and CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID] ~= 0 then
							vivodCent = CharInfo.MASLENGO.CurrencyID[currencyID]..E.LightGray_Color.." (+"..maxQuantity-CharInfo.MASLENGO.CurrencyID_totalEarned[currencyID]..")|r"
						end
					end
					return vivodCent, vivodLeft
				end
			)
		end
	end
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 12 then
		local expansionQWEQWE = 12
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Blue_Color.."ALL|r"
				for _, v in next, (E.OctoTable_UniversalQuest) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] == E.DONE then
						tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Green_Color.."Octopussy|r"
				end
				return vivodCent, vivodLeft
			end
		)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		E.func_TableRemoveDuplicates(list)
		sort(list)
		for i, value in next, (list) do
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							vivodLeft = i
							vivodCent = value
						end
					end
					return vivodCent, vivodLeft
				end
			)
		end
	end
	local expansionQWEQWE = 13
	if Octo_ToDo_DB_Vars.config.Timewalk == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(1166)..DUNGEONS
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(1166).."500 "..E.func_currencyName(1166)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(1166)..RAIDS
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(1166)..E.func_questName(43323)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(3100)..E.func_questName(84616)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Daily ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Daily
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(3100)..E.func_questName(82783)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.func_currencyIcon(3100)..E.func_texturefromIcon(1322720)..E.func_questName(57300)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Event == true then
		if Octo_ToDo_DB_Other.Holiday.Active[628] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(514016).."Cataclysm"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(514016)..L["Firelands"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if (Octo_ToDo_DB_Other.Holiday.Active[622] or Octo_ToDo_DB_Other.Holiday.Active[559]) then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(514016).."Burning Crusade"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(237385)..L["Black Temple"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1265] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1379226).."Legion"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[652] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1416740).."Mists of Pandaria"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[616] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(466283).."Wrath of the Lich King"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(237445)..L["Ulduar"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1063] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(133594).."Warlords of Draenor"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(463446)..E.func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1352] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(1542856)..DUNGEONS.." Dragonfly"
					if CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1400] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = Octo_ToDo_DB_Other.Holiday.Collect[1400]
					if CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(4638724)..E.func_currencyName(2588)
					if CharInfo.MASLENGO.CurrencyID[2588] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[2588]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[479] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(354435)..Octo_ToDo_DB_Other.Holiday.Collect[479]
					if CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= E.NONE and CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= "0/9" then
						vivodCent = CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[599] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(667491)..Octo_ToDo_DB_Other.Holiday.Collect[599]
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[72721]
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[613] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236683)..Octo_ToDo_DB_Other.Holiday.Collect[613]
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[72728]
					return vivodCent, vivodLeft
				end
			)
		end
	end
	if Octo_ToDo_DB_Vars.config.Holiday == true then
		if Octo_ToDo_DB_Other.Holiday.Active[341] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = "SummerFestival"
					if CharInfo.Octopussy_DF_Month_SummerFestival_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_SummerFestival_count.." ("..CharInfo.MASLENGO.ItemsInBag[23247]..E.func_itemTexture(23247)..")"
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[372] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.LFGInstance[287].D_name ~= E.NONE then
						vivodLeft = E.func_texturefromIcon(236701)..CharInfo.LFGInstance[287].D_name
					end
					if CharInfo.LFGInstance[287].donetoday ~= E.NONE then
						vivodCent = CharInfo.LFGInstance[287].donetoday
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236701)..E.func_texturefromIcon(133784)..E.func_itemName(37829)
					if CharInfo.MASLENGO.ItemsInBag[37829] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[37829]
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236701)..E.func_questName(77155)
					if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
						vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_count
					end
					if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.DONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
						tooltip[#tooltip+1] = {E.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2022 58.26 67.58", CharInfo.MASLENGO.OctoTable_QuestID[76531]}
						tooltip[#tooltip+1] = {"/way #2022 76.35 35.43", CharInfo.MASLENGO.OctoTable_QuestID[77095]}
						tooltip[#tooltip+1] = {"/way #2022 47.67 83.27", CharInfo.MASLENGO.OctoTable_QuestID[77744]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2023 59.77 38.73", CharInfo.MASLENGO.OctoTable_QuestID[77152]}
						tooltip[#tooltip+1] = {"/way #2023 28.61 60.45", CharInfo.MASLENGO.OctoTable_QuestID[77099]}
						tooltip[#tooltip+1] = {"/way #2023 85.81 35.34", CharInfo.MASLENGO.OctoTable_QuestID[77745]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2024 62.79 57.74", CharInfo.MASLENGO.OctoTable_QuestID[77746]}
						tooltip[#tooltip+1] = {"/way #2024 46.92 40.23", CharInfo.MASLENGO.OctoTable_QuestID[77096]}
						tooltip[#tooltip+1] = {"/way #2024 12.39 49.33", CharInfo.MASLENGO.OctoTable_QuestID[77097]}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {E.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
						tooltip[#tooltip+1] = {"/way #2025 50.1 42.71", CharInfo.MASLENGO.OctoTable_QuestID[77747]}
						tooltip[#tooltip+1] = {"/way #2025 52.2 81.5", CharInfo.MASLENGO.OctoTable_QuestID[77155]}
						tooltip[#tooltip+1] = {"/way #2112 47.87 47.74", CharInfo.MASLENGO.OctoTable_QuestID[77153]}
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236701)..E.func_questName(12492)
					if CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236701)..E.func_questName(76591)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236701)..E.func_questName(77208)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[324] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.LFGInstance[285].D_name ~= E.NONE then
						vivodLeft = E.func_texturefromIcon(133661)..CharInfo.LFGInstance[285].D_name
					end
					if CharInfo.LFGInstance[285].donetoday ~= E.NONE then
						vivodCent = CharInfo.LFGInstance[285].donetoday
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.MASLENGO.ItemsInBag[33226] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[33226]
					end
					vivodLeft = E.func_texturefromIcon(236546)..E.func_itemName(33226)
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[409] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(307568)..Octo_ToDo_DB_Other.Holiday.Collect[409]
					if CharInfo.Octopussy_DF_Once_DayoftheDead_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Once_DayoftheDead_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1397] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(136235)..E.func_questName(60215)
					if CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(136235)..E.func_questName(57300)
					if CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[404] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(236571)..Octo_ToDo_DB_Other.Holiday.Collect[404]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= E.NONE and CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count
							tooltip[#tooltip+1] = {E.func_questName(14053)..E.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14053]}
							tooltip[#tooltip+1] = {E.func_questName(14055)..E.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14055]}
							tooltip[#tooltip+1] = {E.func_questName(14048)..E.Gray_Color.." (Дун Морог)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14048]}
							tooltip[#tooltip+1] = {E.func_questName(14051)..E.Gray_Color.." (Дун Морог)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14051]}
							tooltip[#tooltip+1] = {E.func_questName(14054)..E.Gray_Color.." (Дарнас)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14054]}
						end
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= E.NONE and CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_HordePilgrimsBounty_count
							tooltip[#tooltip+1] = {E.func_questName(14059)..E.Gray_Color.." (Подгород)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14059]}
							tooltip[#tooltip+1] = {E.func_questName(14058)..E.Gray_Color.." (Подгород)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14058]}
							tooltip[#tooltip+1] = {E.func_questName(14061)..E.Gray_Color.." (Дуротар)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14061]}
							tooltip[#tooltip+1] = {E.func_questName(14062)..E.Gray_Color.." (Дуротар)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14062]}
							tooltip[#tooltip+1] = {E.func_questName(14060)..E.Gray_Color.." (Громовой Утес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14060]}
						end
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_itemTexture(44812)..E.func_itemName(44812)
					if CharInfo.MASLENGO.ItemsInBag[44812] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[44812]
					end
					return vivodCent, vivodLeft
				end
			)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[141] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(133202)..E.func_questName(7043)
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= E.NONE and CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {E.func_questName(7043), CharInfo.MASLENGO.OctoTable_QuestID[7043]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= E.NONE and CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {E.func_questName(6983), CharInfo.MASLENGO.OctoTable_QuestID[6983]}
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(133202)..E.func_questName(7045)
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count ~= E.NONE and CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count ~= "0/7" then
							vivodCent = CharInfo.Octopussy__Once_AllianceWinterVeil_ASmokywoodPasturesThankYou_count
						end
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count ~= E.NONE and CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count ~= "0/7" then
							vivodCent = CharInfo.Octopussy__Once_HordeWinterVeil_ASmokywoodPasturesThankYou_count
						end
					end
					return vivodCent, vivodLeft
				end
			)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.func_texturefromIcon(133202)..L["Gifts"]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= E.NONE and CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_AllianceWinterVeil_count
						end
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8744), CharInfo.MASLENGO.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8768), CharInfo.MASLENGO.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8769), CharInfo.MASLENGO.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8803), CharInfo.MASLENGO.OctoTable_QuestID[8803]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(78131), CharInfo.MASLENGO.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(78504), CharInfo.MASLENGO.OctoTable_QuestID[78504]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Once_HordeWinterVeil_count ~= E.NONE and CharInfo.Octopussy__Once_HordeWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_HordeWinterVeil_count
						end
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8768), CharInfo.MASLENGO.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8744), CharInfo.MASLENGO.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(78504), CharInfo.MASLENGO.OctoTable_QuestID[78504]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8769), CharInfo.MASLENGO.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(78131), CharInfo.MASLENGO.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {E.func_texturefromIcon(133202)..E.func_questName(8803), CharInfo.MASLENGO.OctoTable_QuestID[8803]}
					end
					return vivodCent, vivodLeft
				end
			)
		end
	end
	if Octo_ToDo_DB_Vars.config.Quests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = E.Gray_Color..QUESTS_LABEL.."|r"
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
					tooltip[#tooltip+1] = {E.func_Gradient("»".."Dragonflight".."«"), " "}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {E.Timers.DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {E.Timers.DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.2.5".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Gilneas Reclamation"]..")", CharInfo.Octopussy_DF_Once_TheGilneasReclamationStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Azerothian Archives"]..")", CharInfo.Octopussy_DF_Once_AzerothianArchivesStorylines_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.2.0".."«"), " "}
					tooltip[#tooltip+1] ={E.Timers.DF_Flower()..E.func_questName(78319), CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Emerald Dream"]..")", CharInfo.Octopussy_DF_Once_ALLEmeraldDreamStorylines_count}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.func_questName(78821), CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count}
					tooltip[#tooltip+1] ={E.func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={E.func_questName(78381), CharInfo.Octopussy_DF_Weekly_EmeraldDreamDreamsUnified_count}
					tooltip[#tooltip+1] ={L["Rares"], CharInfo.Octopussy_DF_Daily_EmeraldDreamRares_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.5".."«"), " "}
					tooltip[#tooltip+1] = {E.func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {E.Timers.DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zaralek Cavern"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_ResearchersUnderFire()..E.func_questName(74906), CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..E.func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {E.func_texturefromIcon(5062638)..E.func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {E.func_questName(75665), CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_texturefromIcon(4643981)..E.func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["The Forbidden Reach"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
				end
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»".."Shadowlands".."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Zereth Mortis"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_name, CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBZMAntros_name, CharInfo.Octopussy_SL_Weekly_WBZMAntros_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMGetLockStatus_name, CharInfo.Octopussy_SL_Daily_ZMGetLockStatus_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_name, CharInfo.Octopussy_SL_Daily_ZMPryingEyeDiscovery_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_name, CharInfo.Octopussy_SL_Daily_ZMPUZZLECACHES_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRares_name, CharInfo.Octopussy_SL_Daily_ZMRares_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_name, CharInfo.Octopussy_SL_Daily_ZMRaresDuneDominance_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMTREASURES_name, CharInfo.Octopussy_SL_Daily_ZMTREASURES_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_ZMworldQuests_name, CharInfo.Octopussy_SL_Daily_ZMworldQuests_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMConcordance_name, CharInfo.Octopussy_SL_Once_ZMConcordance_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_name, CharInfo.Octopussy_SL_Once_ZMUndulatingFoliage_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Korthia"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaCollection_name, CharInfo.Octopussy_SL_Daily_KorthiaCollection_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_name, CharInfo.Octopussy_SL_Daily_KorthiaKorthianAnimaVessel_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaMobs_name, CharInfo.Octopussy_SL_Daily_KorthiaMobs_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_name, CharInfo.Octopussy_SL_Daily_KorthiaRelicGorger_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_RIFTKorthiaStolenAnimaVessel_name, CharInfo.Octopussy_SL_Weekly_RIFTKorthiaStolenAnimaVessel_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaRiftboundCache_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaRiftboundCache_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaSpectralBoundChest_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaSpectralBoundChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_RIFTKorthiaZovaalsVault_name, CharInfo.Octopussy_SL_Daily_RIFTKorthiaZovaalsVault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_name, CharInfo.Octopussy_SL_Weekly_KorthiaLostResearch_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaRares_name, CharInfo.Octopussy_SL_Weekly_KorthiaRares_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_name, CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_name, CharInfo.Octopussy_SL_Weekly_KorthiaStolenKorthianSupplies_count}
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Maw"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then
						tooltip[#tooltip+1] = {" ", " "}
					end
					tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Class quests"].."«"), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
						if CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.NONE and CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.DONE then
							tooltip[#tooltip+1] = {E.func_questName(24547), CharInfo.MASLENGO.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						tooltip[#tooltip+1] = {L["Green Fire"], CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"] ~= 0 then
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Race quests"].."«"), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"] ~= 0 then
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {E.func_Gradient("»"..L["Allied Races Quests"] .."«"), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..vivodCent.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = QUESTS_LABEL.." OLD"
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Quests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivo, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local list = {}
				for QuestID, v in next, (Octo_ToDo_DB_Config.QuestsDB) do
					tinsert(list, QuestID)
				end
				sort(list, E.func_Reverse_order)
				for k, QuestID in next, (list) do
					if Octo_ToDo_DB_Vars.config.QuestsShowAllways == false and Octo_ToDo_DB_Config.QuestsDB[QuestID] == true and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= 0 and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= "" and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= E.NONE then
						tooltip[#tooltip+1] = {E.func_questName(QuestID)..E.Gray_Color, CharInfo.MASLENGO.OctoTable_QuestID[QuestID]}
					elseif Octo_ToDo_DB_Vars.config.QuestsShowAllways == true and Octo_ToDo_DB_Config.QuestsDB[QuestID] == true then
						if CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= 0 and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= "" then
							tooltip[#tooltip+1] = {E.func_questName(QuestID)..E.Gray_Color, CharInfo.MASLENGO.OctoTable_QuestID[QuestID]}
						else
							tooltip[#tooltip+1] = {E.Gray_Color..E.func_questName(QuestID), E.Gray_Color..CharInfo.MASLENGO.OctoTable_QuestID[QuestID].."|r"}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..QUESTS_LABEL.."|r"
				else
					vivodCent = ""
				end
				if CharInfo.maxNumQuestsCanAccept ~= 0 then
					vivodCent = CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"
				end
				vivodLeft = QUESTS_LABEL.." NEW"
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Dungeons == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r", w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (E.OctoTable_LFGDungeons) do
					if CharInfo.LFGInstance[dungeonID].donetoday ~= E.NONE then
						tooltip[#tooltip+1] = {CharInfo.LFGInstance[dungeonID].D_name, CharInfo.LFGInstance[dungeonID].donetoday}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..DUNGEONS.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = DUNGEONS
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Currency == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				for currencyHEADER, tbl in next, (OCTO_DB_currencies_test) do
					for CurrencyID, config in next, (tbl) do
						if Octo_ToDo_DB_Vars.config.CurrencyShowAllways == false and config == true and CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
							tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
						elseif Octo_ToDo_DB_Vars.config.CurrencyShowAllways == true and config == true then
							if CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
								tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
							else
								tooltip[#tooltip+1] = {E.func_currencyIcon(CurrencyID)..E.Gray_Color..E.func_currencyName_NOCOLOR(CurrencyID), E.Gray_Color..CharInfo.MASLENGO.CurrencyID_Total[CurrencyID].."|r"}
							end
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..CURRENCY.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = CURRENCY
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Reputations == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = E.Gray_Color..REPUTATION.."|r"
				for reputationHEADER, tbl in next, (OCTO_DB_reputations_test) do
					for reputationID, config in next, (tbl) do
						if config == true and CharInfo.MASLENGO.reputationID[reputationID] ~= 0 and CharInfo.MASLENGO.reputationID[reputationID] ~= "" then
							tooltip[#tooltip+1] = {E.func_reputationName(reputationID).."|r", CharInfo.MASLENGO.reputationID[reputationID]}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..REPUTATION.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = REPUTATION
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Items == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local list = {}
				for itemID, v in next, (Octo_ToDo_DB_Config.ItemDB) do
					tinsert(list, itemID)
				end
				sort(list, E.func_Reverse_order)
				for k, itemID in next, (list) do
					if Octo_ToDo_DB_Config.ItemDB[itemID] == true then
						if Octo_ToDo_DB_Vars.config.ItemsShowAllways == false and Octo_ToDo_DB_Config.ItemDB[itemID] == true and CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
							tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
						elseif Octo_ToDo_DB_Vars.config.ItemsShowAllways == true and Octo_ToDo_DB_Config.ItemDB[itemID] == true then
							if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
								tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
							else
								tooltip[#tooltip+1] = {E.func_itemTexture(itemID)..E.Gray_Color..E.func_itemName_NOCOLOR(itemID).."|r", E.Gray_Color..CharInfo.MASLENGO.ItemsInBag[itemID].."|r"}
							end
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..ITEMS.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = ITEMS
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Professions == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.professions[1].skillLine ~= 0 then
					vivodCent = vivodCent..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine)
					if CharInfo.MASLENGO.professions[2].skillLine ~= 0 then
						vivodCent = vivodCent.." "..E.func_ProfessionIcon(CharInfo.MASLENGO.professions[2].skillLine)
					end
				end
				for i = 1, 5 do
					if CharInfo.MASLENGO.professions[i].skillLine ~= 0 then
						tooltip[#tooltip+1] = {E.func_ProfessionIcon(CharInfo.MASLENGO.professions[i].skillLine)..E.func_ProfessionName(CharInfo.MASLENGO.professions[i].skillLine), CharInfo.MASLENGO.professions[i].skillLevel.."/"..CharInfo.MASLENGO.professions[i].maxSkillLevel}
					end
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.Gold == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Money then
					vivodCent = E.func_CompactNumberFormat(CharInfo.Money/10000)..E.Icon_Money
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Red_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Green_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					end
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.ItemLevel == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = STAT_AVERAGE_ITEM_LEVEL
				local color = E.Red_Color
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					if CharInfo.avgItemLevelEquipped >= ItemLevelGreen then
						color = E.Green_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelOrange then
						color = E.Yellow_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelRed then
						color = E.Orange_Color
					end
				end
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					vivodCent = color..CharInfo.avgItemLevelEquipped
					if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
						vivodCent = vivodCent.."/"..CharInfo.avgItemLevel.."|r"
					end
					if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				return vivodCent, vivodLeft
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.WasOnline == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", E.func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local color = "|cffFFFFFF"
				vivodLeft = L["Was online"]
				if CharInfo.loginHour and CharInfo.loginDay then
					if CharInfo.Name == UnitName("Player") then
						vivodCent = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
					else
						if CharInfo.needResetWeekly == true then
							color = E.Gray_Color
						elseif CharInfo.needResetDaily == true then
							color = E.Red_Color
						end
						vivodCent = color..E.FriendsFrame_GetLastOnline(CharInfo.time).."|r"
						tooltip[#tooltip+1] = {color..E.FriendsFrame_GetLastOnlineText(CharInfo.time, CharInfo.classColorHex).."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginDay.."|r"}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginHour.."|r"}
					end
				end
				return vivodCent, vivodLeft
			end
		)
	end
end
local function TotalMoneyCurServerOnShow()
	local TotalMoneyCurServer = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalMoneyCurServer = TotalMoneyCurServer + CharInfo.Money
		end
	end
	return classColorHexCurrent..E.func_CompactNumberFormat(TotalMoneyCurServer/10000).."|r"..E.Icon_Money
end
local function TotalMoneyAllServerOnShow()
	local TotalMoneyAllServer = 0
	local vivod = ""
	local AccountMoney = Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] or 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.Money ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
		end
	end
	if AccountMoney <= 9999 then
		vivod = classColorHexCurrent..E.func_CompactNumberFormat((TotalMoneyAllServer)/10000).."|r"..E.Icon_Money
	else
		vivod = classColorHexCurrent..E.func_CompactNumberFormat((TotalMoneyAllServer)/10000).."|r"..E.Icon_Money..E.LightGray_Color.." +"..E.func_CompactNumberFormat(AccountMoney/10000) .." (".. ACCOUNT_BANK_PANEL_TITLE.. ")".."|r"
	end
	return vivod
end
local function Token_PriceOnShow()
	local vivod = ""
	local TokenPrice = C_WowTokenPublic.GetCurrentMarketPrice()
	if TokenPrice == nil then
		C_WowTokenPublic.UpdateMarketPrice()
	else
		vivod = TOKEN_FILTER_LABEL..": "..classColorHexCurrent..E.func_CompactNumberFormat(TokenPrice/10000).."|r"..E.Icon_Money
	end
	return vivod
end
local function TotalTimeAllServerOnShow()
	local TotalTimeAllServer = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.realTotalTime ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalTimeAllServer = TotalTimeAllServer + CharInfo.realTotalTime
		end
	end
	return classColorHexCurrent..(E.func_SecondsToClock(TotalTimeAllServer)).."|r"
end
local function TotalTimeAllServer80OnShow()
	local TotalTimeAllServer70 = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if CharInfo.UnitLevel == E.currentMaxLevel then
			if CharInfo.realLevelTime ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
				TotalTimeAllServer70 = TotalTimeAllServer70 + CharInfo.realLevelTime
			end
		end
	end
	if TotalTimeAllServer70 ~= 0 then
		return classColorHexCurrent..(E.func_SecondsToClock(TotalTimeAllServer70)).."|r"
	else
		return ""
	end
end
local function Octo_ToDo_FIRST_CreateAltFrame()
	OctoToDo_FIRST_MainFrame = CreateFrame("BUTTON", "OctoToDo_FIRST_MainFramePIZZA", UIParent, "BackdropTemplate")
	OctoToDo_FIRST_MainFrame:Hide()
	Octo_ToDo_DB_Vars.config.FrameScale = Octo_ToDo_DB_Vars.config.FrameScale or 1
	OctoToDo_FIRST_MainFrame:SetScale(Octo_ToDo_DB_Vars.config.FrameScale)
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame)
	local ScrollBar = CreateFrame("EventFrame", nil, ScrollFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", 6, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", 6, 0)
	local scrollChild = CreateFrame("Frame", nil, ScrollFrame)
	ScrollFrame:SetScrollChild(scrollChild)
	ScrollFrame:SetAllPoints()
	scrollChild:SetSize(1, 1)
	scrollChild:SetPoint("TOPRIGHT")
	ScrollUtil.InitScrollFrameWithScrollBar(ScrollFrame, ScrollBar)
	local OnMouseWheel = ScrollFrame:GetScript("OnMouseWheel")
	ScrollFrame:SetScript("OnMouseWheel", function(self, ...)
			if ScrollBar:IsShown() then
				OnMouseWheel(self, ...)
			end
		end
	)
	OctoToDo_FIRST_MainFrame.scrollChild = scrollChild
	OctoToDo_FIRST_MainFrame.ScrollBar = ScrollBar
	OctoToDo_FIRST_MainFrame:SetClampedToScreen(false)
	OctoToDo_FIRST_MainFrame:SetFrameStrata("HIGH")
	OctoToDo_FIRST_MainFrame:SetPoint("TOP", 0, -(UIParent:GetHeight()/6))
	OctoToDo_FIRST_MainFrame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
	})
	OctoToDo_FIRST_MainFrame:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_FIRST_MainFrame:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_FIRST_MainFrame:EnableMouse(true)
	OctoToDo_FIRST_MainFrame:SetMovable(true)
	OctoToDo_FIRST_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_FIRST_MainFrame:SetScript("OnDragStart", function()
			OctoToDo_FIRST_MainFrame:SetAlpha(E.bgCa/2)
			OctoToDo_FIRST_MainFrame:StartMoving()
		end
	)
	OctoToDo_FIRST_MainFrame:SetScript("OnDragStop", function()
			OctoToDo_FIRST_MainFrame:SetAlpha(1)
			OctoToDo_FIRST_MainFrame:StopMovingOrSizing()
		end
	)
	OctoToDo_FIRST_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_FIRST_MainFrame:SetScript("OnClick", function(self) self:Hide()
		end
	)
	OctoToDo_FIRST_MainFrame:SetHeight(50)
	if Octo_ToDo_DB_Vars.config.ShowTotalMoney then
		if not Octo_Frame_TotalMoneyCurServer then
			Octo_Frame_TotalMoneyCurServer = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			Octo_Frame_TotalMoneyCurServer:SetSize(400, E.curHeight)
			Octo_Frame_TotalMoneyCurServer:EnableMouse(false)
			Octo_Frame_TotalMoneyCurServer:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "BOTTOMLEFT", 4, -2)
			Octo_Frame_TotalMoneyCurServer:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			Octo_Frame_TotalMoneyCurServer:SetBackdropBorderColor(1, 0, 0, 0)
			Octo_Frame_TotalMoneyCurServer:HookScript("OnShow", TotalMoneyCurServerOnShow)
			local text = Octo_Frame_TotalMoneyCurServer:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetAllPoints()
			text:SetFontObject(OctoFont11)
			text:SetJustifyV("MIDDLE")
			text:SetJustifyH("LEFT")
			text:SetTextColor(1, 1, 1, 1)
			Octo_Frame_TotalMoneyCurServer:HookScript("OnShow", function(self)
					text:SetText(E.func_CurServerShort(curServer)..": "..TotalMoneyCurServerOnShow())
				end
			)
		end
		if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
			if not Octo_Frame_TotalMoneyAllServer then
				Octo_Frame_TotalMoneyAllServer = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
				Octo_Frame_TotalMoneyAllServer:SetSize(400, E.curHeight)
				Octo_Frame_TotalMoneyAllServer:EnableMouse(false)
				Octo_Frame_TotalMoneyAllServer:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "BOTTOMLEFT", 4, -22)
				Octo_Frame_TotalMoneyAllServer:SetBackdrop({
						edgeFile = E.edgeFile,
						edgeSize = 1
				})
				Octo_Frame_TotalMoneyAllServer:SetBackdropBorderColor(1, 0, 0, 0)
				Octo_Frame_TotalMoneyAllServer:HookScript("OnShow", TotalMoneyAllServerOnShow)
				local text = Octo_Frame_TotalMoneyAllServer:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				text:SetAllPoints()
				text:SetFontObject(OctoFont11)
				text:SetJustifyV("MIDDLE")
				text:SetJustifyH("LEFT")
				text:SetTextColor(1, 1, 1, 1)
				Octo_Frame_TotalMoneyAllServer:HookScript("OnShow", function(self)
						text:SetText(L["Total"]..": "..TotalMoneyAllServerOnShow())
					end
				)
			end
		end
		if not Octo_Frame_Token_Price then
			Octo_Frame_Token_Price = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			Octo_Frame_Token_Price:SetSize(400, E.curHeight)
			Octo_Frame_Token_Price:EnableMouse(false)
			if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
				Octo_Frame_Token_Price:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "BOTTOMLEFT", 4, -44)
			else
				Octo_Frame_Token_Price:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame, "BOTTOMLEFT", 4, -22)
			end
			Octo_Frame_Token_Price:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			Octo_Frame_Token_Price:SetBackdropBorderColor(1, 0, 0, 0)
			Octo_Frame_Token_Price:HookScript("OnShow", Token_PriceOnShow)
			local text = Octo_Frame_Token_Price:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetAllPoints()
			text:SetFontObject(OctoFont11)
			text:SetJustifyV("MIDDLE")
			text:SetJustifyH("LEFT")
			text:SetTextColor(1, 1, 1, 1)
			Octo_Frame_Token_Price:HookScript("OnShow", function(self)
					text:SetText(Token_PriceOnShow())
					C_Timer.After(1, function()
							text:SetText(Token_PriceOnShow())
						end
					)
				end
			)
		end
	end
	if Octo_ToDo_DB_Vars.config.ShowTimeAll == true then
		if not Octo_Frame_TotalTimeAllServer then
			Octo_Frame_TotalTimeAllServer = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			Octo_Frame_TotalTimeAllServer:SetSize(400, E.curHeight)
			Octo_Frame_TotalTimeAllServer:EnableMouse(false)
			Octo_Frame_TotalTimeAllServer:SetPoint("TOPRIGHT", OctoToDo_FIRST_MainFrame, "BOTTOMRIGHT", -4, -2)
			Octo_Frame_TotalTimeAllServer:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			Octo_Frame_TotalTimeAllServer:SetBackdropBorderColor(1, 0, 0, 0)
			local text = Octo_Frame_TotalTimeAllServer:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetAllPoints()
			text:SetFontObject(OctoFont11)
			text:SetJustifyV("MIDDLE")
			text:SetJustifyH("RIGHT")
			text:SetTextColor(1, 1, 1, 1)
			Octo_Frame_TotalTimeAllServer:HookScript("OnShow", function(self)
					text:SetText(string.format(TIME_PLAYED_TOTAL, TotalTimeAllServerOnShow()))
				end
			)
		end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == true then
			if not Octo_Frame_TotalTimeAllServerMAXLEVEL then
				Octo_Frame_TotalTimeAllServerMAXLEVEL = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetSize(400, E.curHeight)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:EnableMouse(false)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetPoint("TOPRIGHT", OctoToDo_FIRST_MainFrame, "BOTTOMRIGHT", -4, -22)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetBackdrop({
						edgeFile = E.edgeFile,
						edgeSize = 1
				})
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetBackdropBorderColor(1, 0, 0, 0)
				local text = Octo_Frame_TotalTimeAllServerMAXLEVEL:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				text:SetAllPoints()
				text:SetFontObject(OctoFont11)
				text:SetJustifyV("MIDDLE")
				text:SetJustifyH("RIGHT")
				text:SetTextColor(1, 1, 1, 1)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:HookScript("OnShow", function(self)
						text:SetText(string.format("%s", TotalTimeAllServer80OnShow()))
					end
				)
			end
		end
	end
	if not OctoToDo_FIRST_CloseButton then
		OctoToDo_FIRST_CloseButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
		OctoToDo_FIRST_CloseButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_FIRST_CloseButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*0, 1)
		OctoToDo_FIRST_CloseButton:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1
		})
		OctoToDo_FIRST_CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_FIRST_CloseButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(classColorHexCurrent..CLOSE.."|r")
				GameTooltip:Show()
			end
		)
		OctoToDo_FIRST_CloseButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
		)
		OctoToDo_FIRST_CloseButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
			end
		)
		OctoToDo_FIRST_CloseButton:SetScript("OnClick", function()
				OctoToDo_FIRST_MainFrame:Hide()
			end
		)
		local t = OctoToDo_FIRST_CloseButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_FIRST_CloseButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		t:SetAllPoints(OctoToDo_FIRST_CloseButton)
		OctoToDo_FIRST_CloseButton:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
			end
		)
	end
	if not OctoToDo_FIRST_OptionsButton then
		OctoToDo_FIRST_OptionsButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
		OctoToDo_FIRST_OptionsButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_FIRST_OptionsButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*1, 1)
		OctoToDo_FIRST_OptionsButton:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1
		})
		OctoToDo_FIRST_OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_FIRST_OptionsButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
				GameTooltip:AddLine(classColorHexCurrent..OPTIONS.."|r")
				GameTooltip:Show()
			end
		)
		OctoToDo_FIRST_OptionsButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:Hide()
			end
		)
		OctoToDo_FIRST_OptionsButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
			end
		)
		OctoToDo_FIRST_OptionsButton:SetScript("OnClick", function()
				if OctoToDo_FIRST_MainFramePIZZA and OctoToDo_FIRST_MainFramePIZZA:IsShown() then
					OctoToDo_FIRST_MainFramePIZZA:Hide()
				end
				if SettingsPanel:IsVisible() and self:IsVisible() then
					HideUIPanel(SettingsPanel)
				else
					Settings.OpenToCategory(E.AddonTitle, true)
				end
			end
		)
		local t = OctoToDo_FIRST_OptionsButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_FIRST_OptionsButton.icon = t
		t:SetTexture(E.AddonTexture_1)
		t:SetAllPoints(OctoToDo_FIRST_OptionsButton)
	end
	local function AbandonQuests()
		local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
		local numQuests = E.func_CurrentNumQuests()
		for i = 1, numShownEntries do
			if numQuests ~= 0 then
				local info = C_QuestLog.GetInfo(i)
				if info then
					if (not info.isHeader and not info.isHidden) then
						DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Abandon: "])..E.func_questName(info.questID))
						C_QuestLog.SetSelectedQuest(info.questID)
						C_QuestLog.SetAbandonQuest()
						C_QuestLog.AbandonQuest()
					end
				end
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end
	if Octo_ToDo_DB_Vars.config.AdditionalButtons == true then
		if not OctoToDo_FIRST_AbandonButton then
			local numQuests = E.func_CurrentNumQuests()
			StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
				text = E.Red_Color.."!!! ACHTUNG !!!|r\n"..classColorHexCurrent.."Отменить все задания?|r",
				button1 = YES,
				button2 = NO,
				hideOnEscape = 1,
				whileDead = 1,
				OnAccept = function()
					C_Timer.After(1, AbandonQuests)
				end
				,
			}
			OctoToDo_FIRST_AbandonButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_AbandonButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_AbandonButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*2, 1)
			OctoToDo_FIRST_AbandonButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_AbandonButton:SetBackdropBorderColor(1, 0, 0, 0)
			OctoToDo_FIRST_AbandonButton:SetScript("OnEnter", function(self)
					numQuests = E.func_CurrentNumQuests()
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					if numQuests > 0 then
						GameTooltip:AddLine(classColorHexCurrent..L["Abandon All Quests"].."|r".." ("..E.func_CurrentNumQuests()..")")
						GameTooltip:AddLine(" ")
					end
					if numQuests == 0 then
						GameTooltip:AddLine(L["No quests"], r, g, b)
					end
					local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
					local list = {}
					for i = 1, numShownEntries do
						if numQuests ~= 0 then
							local info = C_QuestLog.GetInfo(i)
							if info then
								if info.questID ~= 0 then
									if (not info.isHeader and not info.isHidden) then
										tinsert(list, info.questID)
									else
									end
								end
							end
						end
					end
					sort(list, E.func_Reverse_order)
					for k, questID in next, (list) do
						GameTooltip:AddDoubleLine(E.func_questName(questID),E.func_CheckCompletedByQuestID(questID) , 1, 1, 1, 1, 1, 1)
					end
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_AbandonButton:SetScript("OnLeave", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_AbandonButton:SetScript("OnMouseDown", function(self)
					self.icon:SetVertexColor(1, 0, 0, .5)
				end
			)
			OctoToDo_FIRST_AbandonButton:SetScript("OnClick", function()
					if numQuests > 0 then
						StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
					end
				end
			)
			local t = OctoToDo_FIRST_AbandonButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_AbandonButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow72.tga")
			t:SetAllPoints(OctoToDo_FIRST_AbandonButton)
		end
		if not OctoToDo_FIRST_MplusButton then
			OctoToDo_FIRST_MplusButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_MplusButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_MplusButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*3, 1)
			OctoToDo_FIRST_MplusButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_MplusButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_MplusButton:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					local list = {}
					for dungeonID = 1, 1000 do
						local name = E.func_dungeonName(dungeonID)
						if name then
							tinsert(list, dungeonID)
						end
					end
					sort(list, E.func_Reverse_order)
					for count, dungeonID in next, (list) do
						local name = E.func_dungeonName(dungeonID)
						local timeLimit = E.func_dungeontimeLimit(dungeonID)
						local icon = E.func_dungeonIcon(dungeonID)
						i = i + 1
						local vivod_LEFT = E.func_texturefromIcon(icon) .. name
						local vivod_RIGHT = E.Gray_Color.."icon:|r"..E.Green_Color..icon.."|r "..E.Gray_Color.."time:|r"..E.Green_Color..E.func_SecondsToClock(timeLimit).."|r"
						GameTooltip:AddDoubleLine(vivod_LEFT, vivod_RIGHT, 1, 1, 1, 1, 1, 1)
					end
					if i == 0 then
						GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
						OctoToDo_FIRST_MplusButton:Hide()
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_MplusButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_MplusButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_MplusButton:SetScript("OnClick", function()
					fpde(list)
				end
			)
			local t = OctoToDo_FIRST_MplusButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_MplusButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
			t:SetAllPoints(OctoToDo_FIRST_MplusButton)
		end
		if not OctoToDo_FIRST_ItemsButton then
			OctoToDo_FIRST_ItemsButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_ItemsButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_ItemsButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*4, 1)
			OctoToDo_FIRST_ItemsButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_ItemsButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_ItemsButton:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for _, itemID in next, (E.OctoTable_itemID_Config) do
						for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
							if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 then
								i = i + 1
								GameTooltip:AddDoubleLine(E.func_itemTexture(itemID)..E.func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID].." "..CharInfo.classColorHex..CharInfo.Name.."|r "..CharInfo.curServerShort)
							end
						end
					end
					if i == 0 then
						GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_ItemsButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_ItemsButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_ItemsButton:SetScript("OnClick", function()
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						if curCharGUID == curGUID then
							fpde(CharInfo)
						end
					end
				end
			)
			local t = OctoToDo_FIRST_ItemsButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_ItemsButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow21.tga")
			t:SetAllPoints(OctoToDo_FIRST_ItemsButton)
		end
		if not OctoToDo_FIRST_MarkOfHonorButton then
			OctoToDo_FIRST_MarkOfHonorButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_MarkOfHonorButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_MarkOfHonorButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*5, 1)
			OctoToDo_FIRST_MarkOfHonorButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_MarkOfHonorButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
						if (CharInfo.MASLENGO.ItemsInBag[137642] ~= 0) then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(1322720)..CharInfo.MASLENGO.ItemsInBag[137642], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[202196] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(4909720)..CharInfo.MASLENGO.ItemsInBag[202196], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[86547] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(237230)..CharInfo.MASLENGO.ItemsInBag[86547], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[183616] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(133291)..CharInfo.MASLENGO.ItemsInBag[183616], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[166751] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(967526)..CharInfo.MASLENGO.ItemsInBag[166751], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[122457] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(667491)..CharInfo.MASLENGO.ItemsInBag[122457], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[190189] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.func_texturefromIcon(519378)..CharInfo.MASLENGO.ItemsInBag[190189], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[204464] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.func_texturefromIcon(5009042)..CharInfo.MASLENGO.ItemsInBag[204464], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[201325] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.func_texturefromIcon(4644002)..CharInfo.MASLENGO.ItemsInBag[201325], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[12811] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.func_texturefromIcon(134122)..CharInfo.MASLENGO.ItemsInBag[12811], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.func_itemTexture(200652)..CharInfo.MASLENGO.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[122284] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.WOW_Heirloom_Color..TOKEN_FILTER_LABEL.."|r"..E.func_texturefromIcon(1120721)..CharInfo.MASLENGO.ItemsInBag[122284], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
				end
			)
			local t = OctoToDo_FIRST_MarkOfHonorButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_MarkOfHonorButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow1.tga")
			t:SetAllPoints(OctoToDo_FIRST_MarkOfHonorButton)
		end
		if not OctoToDo_FIRST_QuestFeastButton then
			OctoToDo_FIRST_QuestFeastButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_QuestFeastButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_QuestFeastButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*6, 1)
			OctoToDo_FIRST_QuestFeastButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_QuestFeastButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
						if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.DONE and CharInfo.UnitLevel >= 60 then
							i = i +1
							GameTooltip:AddDoubleLine(CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r", CharInfo.Octopussy_DF_Weekly_CommunityFeast_count)
						end
						if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.func_itemTexture(200652)..CharInfo.MASLENGO.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
					end
					if i == 0 then
						GameTooltip:AddLine(E.Green_Color.."All done|r")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
				end
			)
			local t = OctoToDo_FIRST_QuestFeastButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_QuestFeastButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow2.tga")
			t:SetAllPoints(OctoToDo_FIRST_QuestFeastButton)
		end
		if not OctoToDo_FIRST_EventsButton then
			OctoToDo_FIRST_EventsButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_EventsButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_EventsButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*7, 1)
			OctoToDo_FIRST_EventsButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_EventsButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_EventsButton:SetScript("OnEnter", function(self)
					local countLines = 0
					self:SetBackdropBorderColor(0, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					local classFilename = UnitClassBase("PLAYER")
					GameTooltip:AddDoubleLine(classColorHexCurrent..(L["Current Date"]).."|r", classColorHexCurrent..(date("%d/%m/%Y").."|r"))
					GameTooltip:AddDoubleLine(" ", " ")
					for eventID, v in pairs(Octo_ToDo_DB_Other.Holiday.Active) do
						GameTooltip:AddDoubleLine(E.func_EventName(eventID), Octo_ToDo_DB_Other.Holiday.Active[eventID].startTime.." - "..Octo_ToDo_DB_Other.Holiday.Active[eventID].endTime)
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_EventsButton:SetScript("OnShow", function(self)
					self.icon:SetVertexColor(1, 0, 1, 1)
				end
			)
			OctoToDo_FIRST_EventsButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 0, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_EventsButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_EventsButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
					fpde(Octo_ToDo_DB_Other.Holiday.Active)
				end
			)
			local t = OctoToDo_FIRST_EventsButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_EventsButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow6.tga")
			t:SetAllPoints(OctoToDo_FIRST_EventsButton)
		end
		if not OctoToDo_FIRST_ConsumableButton then
			OctoToDo_FIRST_ConsumableButton = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_ConsumableButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_ConsumableButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*8, 1)
			OctoToDo_FIRST_ConsumableButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_ConsumableButton:SetBackdropBorderColor(r, g, b, 0)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for itemID, v in pairs(Octo_ToDo_DB_Other.Items.Consumable) do
						for k, CharInfo in pairs(Octo_ToDo_DB_Levels) do
							if CharInfo.curServer == GetRealmName() then
								if (CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0) then
									i = i + 1
									GameTooltip:AddDoubleLine(E.func_itemTexture(itemID)..E.func_itemName(itemID).." "..CharInfo.MASLENGO.ItemsInBag[itemID], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
								end
							end
						end
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
				end
			)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end
			)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
				end
			)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
				end
			)
			local t = OctoToDo_FIRST_ConsumableButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_ConsumableButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
			t:SetAllPoints(OctoToDo_FIRST_ConsumableButton)
		end
	end
	if not dd_FIRST then
		local dd_FIRST = CreateFrame("Button", E.AddonTitle..E.func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
		local multiply = (1/3)*2
		dd_FIRST:SetSize(E.curWidthTitle*multiply, E.curHeight*multiply)
		dd_FIRST:SetBackdrop({
				bgFile = E.bgFile,
				edgeFile = E.edgeFile,
				edgeSize = 1
		})
		dd_FIRST:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		dd_FIRST:SetBackdropBorderColor(0, 0, 0, 1)
		dd_FIRST.ExpandArrow = dd_FIRST:CreateTexture(nil, "ARTWORK")
		dd_FIRST.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
		dd_FIRST.ExpandArrow:SetSize(16*multiply, 16*multiply)
		dd_FIRST.ExpandArrow:SetPoint("RIGHT", -4, 0)
		dd_FIRST.text = dd_FIRST:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		dd_FIRST.text:SetAllPoints()
		dd_FIRST.text:SetFontObject(OctoFont11)
		dd_FIRST.text:SetJustifyV("MIDDLE")
		dd_FIRST.text:SetJustifyH("CENTER")
		dd_FIRST.text:SetTextColor(1, 1, 1, 1)
		dd_FIRST.text:SetText(classColorHexCurrent..L["Characters"].."|r")
		LibSFDropDown:SetMixin(dd_FIRST)
		dd_FIRST:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", 0, 1)
		dd_FIRST:ddSetDisplayMode(GlobalAddonName)
		dd_FIRST:ddSetOpenMenuUp(true)
		dd_FIRST:ddSetNoGlobalMouseEvent(true)
		dd_FIRST:ddHideWhenButtonHidden()
		dd_FIRST:RegisterForClicks("LeftButtonUp")
		dd_FIRST:SetScript("OnClick", function(self)
				self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
			end
		)
		local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
			Octo_ToDo_DB_Levels[menuButton.value].isShownPLAYER = checked
		end
		local function Octo_ToDoDeleteChar(curGUID)
			Octo_ToDo_DB_Levels[curGUID] = nil
			for X, Y in next, (OctoToDo_FIRST_MainFrame.AllCharFrames) do
				if Y == OctoToDo_FIRST_MainFrame[curGUID] then
					OctoToDo_FIRST_MainFrame.AllCharFrames[X].parent = nil
					OctoToDo_FIRST_MainFrame.AllCharFrames[X]:Hide()
					OctoToDo_FIRST_MainFrame.AllCharFrames[X] = nil
				end
			end
		end
		local function func_remove_GUID(menuButton)
			Octo_ToDoDeleteChar(menuButton.value)
			Octo_ToDo_DB_Levels[menuButton.value] = nil
		end
		dd_FIRST:ddSetInitFunc(function(self, level, value)
				local info, list = {}, {}
				local count = 0
				local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
				local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
				if level == 1 then
					local BnetList = {}
					local Octo_ToDo_BatlleNets = {}
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						if not BnetList[CharInfo.BattleTagLocal] then
							count = count + 1
							Octo_ToDo_BatlleNets[count] = CharInfo.BattleTagLocal
						end
						BnetList[CharInfo.BattleTagLocal] = true
					end
					sort(Octo_ToDo_BatlleNets)
					if count > 1 then
						for i, Bnets in ipairs(Octo_ToDo_BatlleNets) do
							local info = {}
							info.fontObject = OctoFont11
							info.hasArrow = true
							info.keepShownOnClick = true
							info.notCheckable = true
							local vivod = Bnets
							if Bnets == BattleTagLocal then
								vivod = classColorHexCurrent..Bnets.."|r"
							end
							if ShowOnlyCurrentBattleTag == true then
								if Bnets ~= BattleTagLocal then
									vivod = E.Gray_Color..vivod.."|r"
								end
							end
							info.text = vivod
							info.value = Bnets
							tinsert(list, info)
						end
					else
						local curCharGUID, CharInfo = next(Octo_ToDo_DB_Levels)
						value = CharInfo.BattleTagLocal
					end
				end
				self:ddAddButton({list = list, listMaxSize = 20}, level)
				if type(value) == "string" then
					local tbl_Players = {}
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
						if CharInfo.BattleTagLocal == value or not value then
							tbl_Players[CharInfo.curServer] = tbl_Players[CharInfo.curServer] or {}
							tbl_Players[CharInfo.curServer][curCharGUID] = tbl_Players[CharInfo.curServer][curCharGUID] or {}
							tbl_Players[CharInfo.curServer][curCharGUID] = CharInfo.classColorHex..CharInfo.Name.."|r".." "..CharInfo.UnitLevel
						end
					end
					for Server, v in next, (tbl_Players) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Server
						if ShowOnlyCurrentBattleTag and (value ~= BattleTagLocal or ShowOnlyCurrentServer and Server ~= curServer)
						or not ShowOnlyCurrentBattleTag and ShowOnlyCurrentServer and Server ~= curServer
						then
							vivod = E.Gray_Color..vivod.."|r"
						elseif Server == curServer then
							vivod = classColorHexCurrent..vivod.."|r"
						end
						info.text = vivod
						info.value = v
						tinsert(list, info)
					end
					self:ddAddButton({list = list, listMaxSize = 20}, level)
				elseif type(value) == "table" then
					local players_list = {}
					for GUID, names in next, (value) do
						tinsert(players_list, GUID)
					end
					sort(players_list, function(a, b)
							local infoA = Octo_ToDo_DB_Levels[a]
							local infoB = Octo_ToDo_DB_Levels[b]
							if infoA and infoB then
								return
								infoA.curServer > infoB.curServer or
								infoA.curServer == infoB.curServer and infoA.UnitLevel > infoB.UnitLevel or
								infoA.UnitLevel == infoB.UnitLevel and infoA.avgItemLevel > infoB.avgItemLevel or
								infoA.avgItemLevel == infoB.avgItemLevel and infoB.Name > infoA.Name
							end
						end
					)
					for _, GUID in next, (players_list) do
						local info = {}
						info.keepShownOnClick = true
						info.isNotRadio = true
						local vivod = Octo_ToDo_DB_Levels[GUID].classColorHex..Octo_ToDo_DB_Levels[GUID].Name.."|r"
						if Octo_ToDo_DB_Levels[GUID].UnitLevel ~= E.currentMaxLevel then
							vivod = vivod.." "..E.Yellow_Color..Octo_ToDo_DB_Levels[GUID].UnitLevel.."|r"
						end
						info.text = vivod
						info.value = GUID
						info.func = selectFunctionisShownPLAYER
						info.checked = Octo_ToDo_DB_Levels[GUID].isShownPLAYER
						info.remove = func_remove_GUID
						info.removeDoNotHide = true
						tinsert(list, info)
					end
					self:ddAddButton({list = list, listMaxSize = 20}, level)
				end
				if level == 1 then
					self:ddAddSeparator(level)
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current Server"]
					info.hasArrow = nil
					info.checked = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = checked
						self:main_frame_toggle()
						C_Timer.After(.1, function()
								self:main_frame_toggle()
							end
						)
					end
					self:ddAddButton(info, level)
					if count > 1 then
						info.fontObject = OctoFont11
						info.keepShownOnClick = false
						info.notCheckable = false
						info.isNotRadio = true
						info.text = L["Only Current BattleTag"]
						info.hasArrow = nil
						info.checked = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
						info.func = function(_, _, _, checked)
							Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag = checked
							self:main_frame_toggle()
							C_Timer.After(.1, function()
									self:main_frame_toggle()
								end
							)
						end
						self:ddAddButton(info, level)
					end
				end
			end
		)
	end
	if Octo_ToDo_DB_Vars.config.PortalsButtons == true then
		local Xpos = 0
		local Ypos = -21
		local prof1, prof2 = GetProfessions()
		local prof1 = prof1 and select(7, GetProfessionInfo(prof1))
		local prof2 = prof2 and select(7, GetProfessionInfo(prof2))
		local className, classFilename, classId = UnitClass("PLAYER")
		local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
		local Faction = UnitFactionGroup("PLAYER")
		local UnitLevel = UnitLevel("PLAYER")
		if UnitLevel >= 20 then
			CreateFrameUsableItems(128807, E.GetItemIcon(128807), Xpos*-15+Ypos*15, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(200707, E.GetItemIcon(200707), Xpos*-14+Ypos*14, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187339, E.GetItemIcon(187339), Xpos*-13+Ypos*13, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187875, E.GetItemIcon(187875), Xpos*-12+Ypos*12, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187896, E.GetItemIcon(187896), Xpos*-11+Ypos*11, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187897, E.GetItemIcon(187897), Xpos*-10+Ypos*10, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187869, E.GetItemIcon(187869), Xpos*-9+Ypos*9, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187895, E.GetItemIcon(187895), Xpos*-8+Ypos*8, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187899, E.GetItemIcon(187899), Xpos*-7+Ypos*7, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187900, E.GetItemIcon(187900), Xpos*-6+Ypos*6, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187898, E.GetItemIcon(187898), Xpos*-5+Ypos*5, Ypos*-1, 0, .43, .86)
			if Faction == "Horde" then
				CreateFrameUsableItems(150745, E.GetItemIcon(150745), Xpos*-4+Ypos*4, Ypos*-1, 0, .43, .86)
			else
				CreateFrameUsableItems(150746, E.GetItemIcon(150746), Xpos*-4+Ypos*4, Ypos*-1, 0, .43, .86)
			end
			if Faction == "Horde" then
				CreateFrameUsableItems(150744, E.GetItemIcon(150744), Xpos*-3+Ypos*3, Ypos*-1, 0, .43, .86)
			else
				CreateFrameUsableItems(150743, E.GetItemIcon(150743), Xpos*-3+Ypos*3, Ypos*-1, 0, .43, .86)
			end
		end
		CreateFrameUsableSpells(431280, E.func_GetSpellIcon(431280), Xpos*-1+Ypos*1, Ypos*-1, 0, .43, .86)
		CreateFrameUsableSpells(460905, E.func_GetSpellIcon(460905), Xpos*-2+Ypos*2, Ypos*-1, 0, .43, .86)
		if prof1 == 202 or prof2 == 202 then
			CreateFrameUsableItems(198156, E.GetItemIcon(198156), Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 366254)
			CreateFrameUsableItems(172924, E.GetItemIcon(172924), Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 310542)
			if Faction == "Horde" then
				CreateFrameUsableItems(168808, E.GetItemIcon(168808), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 265807)
				CreateFrameUsableItems(168807, E.GetItemIcon(168807), Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 265807)
			else
				CreateFrameUsableItems(168808, E.GetItemIcon(168808), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 264492)
				CreateFrameUsableItems(168807, E.GetItemIcon(168807), Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 264492)
			end
			CreateFrameUsableItems(151652, E.GetItemIcon(151652), Xpos*4+Ypos*1, Ypos*5, 0, .43, .86, 264490)
			CreateFrameUsableItems(112059, E.GetItemIcon(112059), Xpos*5+Ypos*1, Ypos*6, 0, .43, .86, 264487)
			CreateFrameUsableItems(87215, E.GetItemIcon(87215), Xpos*6+Ypos*1, Ypos*7, 0, .43, .86, 264485)
			CreateFrameUsableItems(48933, E.GetItemIcon(48933), Xpos*7+Ypos*1, Ypos*8, 0, .43, .86, 264481)
			CreateFrameUsableItems(110560, E.GetItemIcon(110560), Xpos*8+Ypos*1, Ypos*9, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, E.GetItemIcon(6948), Xpos*9+Ypos*1, Ypos*10, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, E.GetItemIcon(140192), Xpos*10+Ypos*1, Ypos*11, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, E.func_GetSpellIcon(193753), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, E.func_GetSpellIcon(50977), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
				CreateFrameUsableSpells(53428, E.func_GetSpellIcon(53428), Xpos*13+Ypos*1, Ypos*13, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, E.func_GetSpellIcon(556), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, E.func_GetSpellIcon(126892), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, E.func_GetSpellIcon(265225), Xpos*12+Ypos*1, Ypos*13, 0, .43, .86)
			end
		else
			CreateFrameUsableItems(110560, E.GetItemIcon(110560), Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, E.GetItemIcon(6948), Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, E.GetItemIcon(140192), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, E.func_GetSpellIcon(193753), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, E.func_GetSpellIcon(50977), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
				CreateFrameUsableSpells(53428, E.func_GetSpellIcon(53428), Xpos*5+Ypos*1, Ypos*5, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, E.func_GetSpellIcon(556), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, E.func_GetSpellIcon(126892), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, E.func_GetSpellIcon(265225), Xpos*4+Ypos*1, Ypos*5, 0, .43, .86)
			end
		end
		if UnitLevel >= 20 then
			if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == false then
				for k, v in next, (E.OctoTable_Portals_MoP) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_WoD) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*3, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_Legion) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*4, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_BfA) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*5, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_SL) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*6, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_DF) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*7, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_DF_S3) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
				end
				if Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				end
				for k, v in next, (E.OctoTable_Spells_Other) do
					CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*10, (Ypos*k), 0, .43, .86)
				end
				if classFilename == "MAGE" and Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_Mage_Solo_Horde) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
					for k, v in next, (E.OctoTable_Portals_Mage_Group_Horde) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*12, (Ypos*k), 0, .43, .86)
					end
				end
				if classFilename == "MAGE" and Faction == "Alliance" then
					for k, v in next, (E.OctoTable_Portals_Mage_Solo_Alliance) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
					for k, v in next, (E.OctoTable_Portals_Mage_Group_Alliance) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*12, (Ypos*k), 0, .43, .86)
					end
				end
			else
				if Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, E.func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
					end
				end
			end
		end
	end
	local function FrameLine_OnEnter(self)
		self.animation:SetFromAlpha(0)
		self.animation:SetToAlpha(1)
		self.group:Restart()
	end
	local function FrameLine_OnLeave(self)
		self.animation:SetFromAlpha(1)
		self.animation:SetToAlpha(0)
		self.group:Restart()
	end
	for i = 1, #OctoTable_func_otrisovka_FIRST do
		local fname, f
		fname = "FrameLine"..i
		OctoToDo_FIRST_MainFrame[fname] = CreateFrame("Frame", E.AddonTitle..E.func_GenerateUniqueID().."FrameLine"..i, OctoToDo_FIRST_MainFrame.scrollChild, "BackdropTemplate")
		f = OctoToDo_FIRST_MainFrame[fname]
		f:SetHeight(E.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame.scrollChild, "TOPLEFT", 0, -E.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.curHeight)
		f.BG:SetAllPoints()
		f.BG:SetColorTexture(r, g, b, E.BGALPHA*2)
		f.BG:SetAlpha(0)
		f.group = f:CreateAnimationGroup()
		f.group:SetToFinalAlpha(true)
		f.animation = f.group:CreateAnimation("Alpha")
		f.animation:SetSmoothing("IN_OUT")
		f.animation:SetDuration(E.AnimationDuration)
		f.animation:SetTarget(f.BG)
		fname = "TextLeft"..i
		OctoToDo_FIRST_MainFrame[fname] = OctoToDo_FIRST_MainFrame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = OctoToDo_FIRST_MainFrame[fname]
		f:SetSize(E.curWidthTitle, E.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_FIRST_MainFrame.scrollChild, "TOPLEFT", 6, -E.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	OctoToDo_FIRST_MainFrame:Hide()
end
local function resetPoolFunc(pool, f)
	f:Hide()
	f:ClearAllPoints()
end
local function resetPoolFunc_BG(pool, f)
	f:Hide()
	f.BG:Hide()
	f:ClearAllPoints()
end
local CharFrame_Pool
local function CharFrame_PoolOnHide(f)
	CharFrame_Pool:Release(f)
end
local function initCharFrame_PoolFunc(f)
	f.BG = f:CreateTexture(nil, "BACKGROUND")
	f.BG:Hide()
	f.BG:SetPoint("TOPLEFT", 0, -E.curHeight)
	f.BG:SetPoint("BOTTOMRIGHT", 0, 0)
	f.BG:SetColorTexture(r, g, b, 1)
	for i = 1, #OctoTable_func_otrisovka_FIRST do
		f["CenterLines"..i.."BG"] = f:CreateTexture(nil, "BACKGROUND")
		f["CenterLines"..i.."BG"]:SetColorTexture(0, 0, 0, 0)
	end
	f:Hide()
	f:SetScript("OnHide", CharFrame_PoolOnHide)
end
CharFrame_Pool = CreateFramePool("Frame", nil, "BackdropTemplate", resetPoolFunc_BG, false, initCharFrame_PoolFunc)
local CentralFrame_Pool
local function CentralFrame_PoolOnHide(f)
	CentralFrame_Pool:Release(f)
end
local function initCentralFrame_PoolFunc(f)
	f:SetSize(E.curWidthCentral, E.curHeight)
	f:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
	f:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
	f:SetMouseClickEnabled(false)
	f.CL = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	f.CL:SetAllPoints()
	f.CL:SetFontObject(OctoFont11)
	f.CL:SetJustifyV("MIDDLE")
	f.CL:SetJustifyH("CENTER")
	f.CL:SetTextColor(1, 1, 1, 1)
	f:Hide()
	f:SetScript("OnHide", CentralFrame_PoolOnHide)
end
CentralFrame_Pool = CreateFramePool("Frame", nil, "BackdropTemplate", resetPoolFunc, false, initCentralFrame_PoolFunc)
function Octo_ToDo_FIRST_AddDataToAltFrame()
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.config.LevelToShowMAX
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	OctoToDo_FIRST_MainFrame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == curServer)
				and (CharInfo.BattleTagLocal == BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.UnitLevel < b.UnitLevel or a.UnitLevel == b.UnitLevel
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				b.Name < a.Name
			end
		end
	)
	for GUID, CharInfo in next, (sorted) do
		local classColor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		local curCharGUID = CharInfo.GUID
		OctoToDo_FIRST_MainFrame[curCharGUID] = CharFrame_Pool:Acquire()
		OctoToDo_FIRST_CharFrame = OctoToDo_FIRST_MainFrame[curCharGUID]
		OctoToDo_FIRST_CharFrame:SetParent(OctoToDo_FIRST_MainFrame.scrollChild)
		OctoToDo_FIRST_CharFrame:Show()
		OctoToDo_FIRST_CharFrame:SetPoint("BOTTOM", 0, 0)
		for i = 1, #OctoTable_func_otrisovka_FIRST do
			CharInfo.GUID = curCharGUID
			local CF = CentralFrame_Pool:Acquire()
			CF:Show()
			CF:SetParent(OctoToDo_FIRST_CharFrame)
			OctoToDo_FIRST_CharFrame["CenterLines"..i] = CF
			OctoToDo_FIRST_CharFrame["CenterLines"..i.."BG"]:SetAllPoints(OctoToDo_FIRST_CharFrame["CenterLines"..i])
			CF.index = i
			CF:SetPoint("TOP", OctoToDo_FIRST_CharFrame, "TOP", 0, -E.curHeight*(i-1))
		end
		OctoToDo_FIRST_CharFrame:SetSize(E.curWidthCentral, E.curHeight)
		if #OctoToDo_FIRST_MainFrame.AllCharFrames == 0 then
			OctoToDo_FIRST_CharFrame:SetPoint("TOPRIGHT", 0, 0)
		else
			OctoToDo_FIRST_CharFrame:SetPoint("TOPRIGHT", OctoToDo_FIRST_MainFrame.AllCharFrames[#OctoToDo_FIRST_MainFrame.AllCharFrames], "TOPLEFT", 0, 0)
		end
		OctoToDo_FIRST_MainFrame.AllCharFrames[#OctoToDo_FIRST_MainFrame.AllCharFrames + 1] = OctoToDo_FIRST_CharFrame
		if curGUID == curCharGUID then
			OctoToDo_FIRST_CharFrame.BG:Show()
			OctoToDo_FIRST_CharFrame.BG:SetAlpha(E.BGALPHA*2)
		end
		for i = 1, #OctoTable_func_otrisovka_FIRST do
			local TEXTLEFT = OctoToDo_FIRST_MainFrame["TextLeft"..i]
			local TEXTCENT = OctoToDo_FIRST_CharFrame["CenterLines"..i]
			if TEXTLEFT and TEXTCENT then
				local BG = OctoToDo_FIRST_CharFrame["CenterLines"..i.."BG"]
				TEXTCENT.tooltip = {}
				local vivodCent = " "
				local vivodLeft = " "
				TEXTCENT.CL:SetFontObject(OctoFont11)
				vivodCent, vivodLeft = OctoTable_func_otrisovka_FIRST[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
				TEXTLEFT:SetText(vivodLeft or "leftText")
				TEXTCENT.CL:SetText(vivodCent or "centText")
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
		end
	end
	local curAltFrameWidth = #OctoToDo_FIRST_MainFrame.AllCharFrames * E.curWidthCentral/2
	local width = curAltFrameWidth*2+E.curWidthTitle
	local height = E.curHeight*(#OctoTable_func_otrisovka_FIRST)
	OctoToDo_FIRST_MainFrame.scrollChild:SetSize(width, height)
	if height > E.Addon_Height then
		height = E.Addon_Height
		OctoToDo_FIRST_MainFrame.ScrollBar:Show()
	else
		OctoToDo_FIRST_MainFrame.ScrollBar:Hide()
	end
	OctoToDo_FIRST_MainFrame:SetSize(width, height)
end
function Octo_EventFrame:main_frame_toggle()
	local button = LibDBIcon:GetMinimapButton(GlobalAddonName.."Octo_ToDo_FIRST_Minimap")
	if not OctoToDo_FIRST_MainFrame.promise then
		OctoToDo_FIRST_MainFrame.promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
		OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_ALL)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_MoP)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_WoD)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_Legion)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_BfA)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_SL)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_DF)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_DF_S3)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_TWW_S1_Horde)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_TWW_S1_Alliance)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Solo_Horde)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Group_Horde)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Solo_Alliance)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Group_Alliance)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_DRUID)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_DEATHKNIGHT)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_SHAMAN)
		OctoToDo_FIRST_MainFrame.promise:AddSpells(E.OctoTable_Portals_MONK)
		OctoToDo_FIRST_MainFrame.promise:AddQuests(E.OctoTable_QuestID)
		OctoToDo_FIRST_MainFrame.promise:AddQuests(E.OctoTable_QuestID_Promise)
	end
	if OctoToDo_FIRST_MainFrame:IsShown() then
		OctoToDo_FIRST_MainFrame:Hide()
	else
		button:Disable()
		OctoToDo_FIRST_MainFrame.promise:Then(function()
				button:Enable()
				Octo_EventFrame:Collect_ALL_PlayerInfo()
				Octo_EventFrame:Collect_ALL_GreatVault()
				Octo_EventFrame:Collect_ALL_ItemLevel()
				Octo_EventFrame:Collect_ALL_ItemsInBag()
				Octo_EventFrame:Collect_ALL_Locations()
				Octo_EventFrame:Collect_ALL_LoginTime()
				Octo_EventFrame:Collect_ALL_Mail()
				Octo_EventFrame:Collect_ALL_MoneyUpdate()
				Octo_EventFrame:Collect_All_Professions()
				Octo_EventFrame:Collect_All_Quests()
				Octo_EventFrame:Collect_ALL_UNIVERSALQuestUpdate()
				Octo_EventFrame:Collect_All_journalInstance()
				Octo_EventFrame:Collect_Player_Level()
				Octo_EventFrame:Collect_WarMode()
				Octo_EventFrame:Collect_All_Holiday()
				Octo_EventFrame:Collect_BfA_Azerite()
				Octo_EventFrame:Collect_BfA_Cloaklvl()
				Octo_EventFrame:Collect_BfA_QuestsBounties()
				Octo_EventFrame:Collect_BfA_Island()
				Octo_EventFrame:MustBeHiddenFrames()
				OctoToDo_FIRST_MainFrame:Show()
				Octo_ToDo_FIRST_AddDataToAltFrame()
			end
		)
	end
end
for index, event in ipairs(E.OctoTable_Events) do
	Octo_EventFrame:RegisterEvent(event)
end
Octo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...)
	end
)
function Octo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		self:Octo_ToDo_FIRST_OnLoad()
		if Octo_ToDoTrashCan == nil then
			Octo_ToDoTrashCan = {}
		end
		if Octo_ToDo_DB_Config == nil then
			Octo_ToDo_DB_Config = {}
		end
		if Octo_ToDo_DB_Levels == nil then
			Octo_ToDo_DB_Levels = {}
		end
		if Octo_ToDo_DB_Vars == nil then
			Octo_ToDo_DB_Vars = {}
		end
		if Octo_ToDo_DB_Other == nil then
			Octo_ToDo_DB_Other = {}
		end
		if Octo_ToDoTrashCan.Reputations == nil then
			Octo_ToDoTrashCan.Reputations = {}
		end
		if Octo_ToDo_DB_Config.CurrencyDB == nil then
			Octo_ToDo_DB_Config.CurrencyDB = {}
		end
		if Octo_ToDo_DB_Config.ItemDB == nil then
			Octo_ToDo_DB_Config.ItemDB = {}
		end
		if Octo_ToDo_DB_Config.QuestsDB == nil then
			Octo_ToDo_DB_Config.QuestsDB = {}
		end
		if Octo_ToDo_DB_Config.ReputationDB == nil then
			Octo_ToDo_DB_Config.ReputationDB = {}
		end
		if Octo_ToDo_DB_Other.AccountMoney == nil then
			Octo_ToDo_DB_Other.AccountMoney = {}
		end
		if Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] == nil then
			Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] = 0
		end
		if Octo_ToDo_DB_Other.CVar == nil then
			Octo_ToDo_DB_Other.CVar = {}
		end
		if Octo_ToDo_DB_Other.Holiday == nil then
			Octo_ToDo_DB_Other.Holiday = {}
		end
		if Octo_ToDo_DB_Other.Holiday.Active == nil then
			Octo_ToDo_DB_Other.Holiday.Active = {}
		end
		if Octo_ToDo_DB_Other.Holiday.Collect == nil then
			Octo_ToDo_DB_Other.Holiday.Collect = {}
		end
		if Octo_ToDo_DB_Other.Items == nil then
			Octo_ToDo_DB_Other.Items = {}
		end
		if Octo_ToDo_DB_Other.Items.Consumable == nil then
			Octo_ToDo_DB_Other.Items.Consumable = {}
		end
		if Octo_ToDo_DB_Other.LFGInstance == nil then
			Octo_ToDo_DB_Other.LFGInstance = {}
		end
		if Octo_ToDo_DB_Vars.config == nil then
			Octo_ToDo_DB_Vars.config = {}
		end
		if Octo_ToDo_DB_Vars.config.curWidthCentral == nil then
			Octo_ToDo_DB_Vars.config.curWidthCentral = 90
		end
		if Octo_ToDo_DB_Vars.config.curWidthCentral ~= nil then
			E.curWidthCentral = Octo_ToDo_DB_Vars.config.curWidthCentral
		end
		if Octo_ToDo_DB_Vars.config.Addon_Height == nil then
			Octo_ToDo_DB_Vars.config.Addon_Height = 600
		end
		if Octo_ToDo_DB_Vars.config.Addon_Height ~= nil then
			E.Addon_Height = Octo_ToDo_DB_Vars.config.Addon_Height
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST = true
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST ~= nil then
			E.Octo_debug_BUTTONS_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND = true
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND ~= nil then
			E.Octo_debug_BUTTONS_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST = true
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST ~= nil then
			E.Octo_debug_Event_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND = true
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND ~= nil then
			E.Octo_debug_Event_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST = false
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST ~= nil then
			E.Octo_debug_Function_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND == nil then
			Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND = false
		end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND ~= nil then
			E.Octo_debug_Function_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND
		end
		if Octo_ToDo_DB_Vars.config.curHeight == nil then
			Octo_ToDo_DB_Vars.config.curHeight = 20
		end
		if Octo_ToDo_DB_Vars.config.curHeight ~= nil then
			E.curHeight = Octo_ToDo_DB_Vars.config.curHeight
		end
		if Octo_ToDo_DB_Vars.config.curWidthTitle == nil then
			Octo_ToDo_DB_Vars.config.curWidthTitle = 200
		end
		if Octo_ToDo_DB_Vars.config.curWidthTitle ~= nil then
			E.curWidthTitle = Octo_ToDo_DB_Vars.config.curWidthTitle
		end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement == nil then
			Octo_ToDo_DB_Vars.config.curWidthTitleAchievement = 300
		end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement ~= nil then
			E.curWidthTitleAchievement = Octo_ToDo_DB_Vars.config.curWidthTitleAchievement
		end
		if Octo_ToDo_DB_Vars.config.Achievements == nil then
			Octo_ToDo_DB_Vars.config.Achievements = true
		end
		if Octo_ToDo_DB_Vars.config.AchievementShowCompleted == nil then
			Octo_ToDo_DB_Vars.config.AchievementShowCompleted = true
		end
		if Octo_ToDo_DB_Vars.config.AchievementToShow == nil then
			Octo_ToDo_DB_Vars.config.AchievementToShow = {[92] = true}
		end
		if Octo_ToDo_DB_Vars.config.AdditionalButtons == nil then
			Octo_ToDo_DB_Vars.config.AdditionalButtons = true
		end
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == nil then
			Octo_ToDo_DB_Vars.config.AidingtheAccord = true
		end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsCasual == nil then
			Octo_ToDo_DB_Vars.config.AnotherAddonsCasual = true
		end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG == nil then
			Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG = true
		end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsRAID == nil then
			Octo_ToDo_DB_Vars.config.AnotherAddonsRAID = true
		end
		if Octo_ToDo_DB_Vars.config.Auto_ChatClearing == nil then
			Octo_ToDo_DB_Vars.config.Auto_ChatClearing = false
		end
		if Octo_ToDo_DB_Vars.config.Load == nil then
			Octo_ToDo_DB_Vars.config.Load = {}
		end
		if Octo_ToDo_DB_Vars.config.LoadAddons == nil then
			Octo_ToDo_DB_Vars.config.LoadAddons = false
		end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler == nil then
			Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler = true
		end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip == nil then
			Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip = true
		end
		if Octo_ToDo_DB_Vars.config.Auto_Gossip == nil then
			Octo_ToDo_DB_Vars.config.Auto_Gossip = true
		end
		if Octo_ToDo_DB_Vars.config.Auto_Screenshot == nil then
			Octo_ToDo_DB_Vars.config.Auto_Screenshot = true
		end
		if Octo_ToDo_DB_Vars.config.AutoGossip == nil then
			Octo_ToDo_DB_Vars.config.AutoGossip = true
		end
		if Octo_ToDo_DB_Vars.config.AutoOpen == nil then
			Octo_ToDo_DB_Vars.config.AutoOpen = true
		end
		if Octo_ToDo_DB_Vars.config.AutoRepair == nil then
			Octo_ToDo_DB_Vars.config.AutoRepair = true
		end
		if Octo_ToDo_DB_Vars.config.AutoSellGrey == nil then
			Octo_ToDo_DB_Vars.config.AutoSellGrey = true
		end
		if Octo_ToDo_DB_Vars.config.AutoTurnQuests == nil then
			Octo_ToDo_DB_Vars.config.AutoTurnQuests = true
		end
		if Octo_ToDo_DB_Vars.config.BeledarCycle == nil then
			Octo_ToDo_DB_Vars.config.BeledarCycle = true
		end
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == nil then
			Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest = true
		end
		if Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame == nil then
			Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame = true
		end
		if Octo_ToDo_DB_Vars.config.CinematicCanceler == nil then
			Octo_ToDo_DB_Vars.config.CinematicCanceler = true
		end
		if Octo_ToDo_DB_Vars.config.Currency == nil then
			Octo_ToDo_DB_Vars.config.Currency = true
		end
		if Octo_ToDo_DB_Vars.config.CurrencyShowAllways == nil then
			Octo_ToDo_DB_Vars.config.CurrencyShowAllways = false
		end
		if Octo_ToDo_DB_Vars.config.CVar == nil then
			Octo_ToDo_DB_Vars.config.CVar = true
		end
		if Octo_ToDo_DB_Vars.config.Dungeons == nil then
			Octo_ToDo_DB_Vars.config.Dungeons = true
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds == nil then
			Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds = true
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Rares == nil then
			Octo_ToDo_DB_Vars.config.EmeraldDream_Rares = true
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks == nil then
			Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks = true
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline == nil then
			Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline = true
		end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_WB == nil then
			Octo_ToDo_DB_Vars.config.EmeraldDream_WB = true
		end
		if Octo_ToDo_DB_Vars.config.Event == nil then
			Octo_ToDo_DB_Vars.config.Event = true
		end
		if Octo_ToDo_DB_Vars.config.ExpansionToShow == nil then
			Octo_ToDo_DB_Vars.config.ExpansionToShow = E.func_CurrentExpansion()
		end
		if Octo_ToDo_DB_Vars.config.FieldOfView == nil then
			Octo_ToDo_DB_Vars.config.FieldOfView = false
		end
		if Octo_ToDo_DB_Vars.config.FoV_bottom == nil then
			Octo_ToDo_DB_Vars.config.FoV_bottom = 0
		end
		if Octo_ToDo_DB_Vars.config.FoV_left == nil then
			Octo_ToDo_DB_Vars.config.FoV_left = 0
		end
		if Octo_ToDo_DB_Vars.config.FoV_right == nil then
			Octo_ToDo_DB_Vars.config.FoV_right = 0
		end
		if Octo_ToDo_DB_Vars.config.FoV_top == nil then
			Octo_ToDo_DB_Vars.config.FoV_top = 0
		end
		if Octo_ToDo_DB_Vars.config.FrameScale == nil then
			Octo_ToDo_DB_Vars.config.FrameScale = 1
		end
		if Octo_ToDo_DB_Vars.config.GameMenuFrameScale == nil then
			Octo_ToDo_DB_Vars.config.GameMenuFrameScale = .8
		end
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == nil then
			Octo_ToDo_DB_Vars.config.GildedHarbingerCrest = true
		end
		if Octo_ToDo_DB_Vars.config.GlobalFadePersist == nil then
			Octo_ToDo_DB_Vars.config.GlobalFadePersist = true
		end
		if Octo_ToDo_DB_Vars.config.glowColor == nil then
			Octo_ToDo_DB_Vars.config.glowColor = 1
		end
		if Octo_ToDo_DB_Vars.config.glowType == nil then
			Octo_ToDo_DB_Vars.config.glowType = 1
		end
		if Octo_ToDo_DB_Vars.config.Gold == nil then
			Octo_ToDo_DB_Vars.config.Gold = true
		end
		if Octo_ToDo_DB_Vars.config.Professions == nil then
			Octo_ToDo_DB_Vars.config.Professions = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI == nil then
			Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Boss_Banner == nil then
			Octo_ToDo_DB_Vars.config.Hide_Boss_Banner = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Covenant == nil then
			Octo_ToDo_DB_Vars.config.Hide_Covenant = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Error_Messages == nil then
			Octo_ToDo_DB_Vars.config.Hide_Error_Messages = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance == nil then
			Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar == nil then
			Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame == nil then
			Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame == nil then
			Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame == nil then
			Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame = true
		end
		if Octo_ToDo_DB_Vars.config.Hide_Zone_Text == nil then
			Octo_ToDo_DB_Vars.config.Hide_Zone_Text = true
		end
		if Octo_ToDo_DB_Vars.config.Holiday == nil then
			Octo_ToDo_DB_Vars.config.Holiday = true
		end
		if Octo_ToDo_DB_Vars.config.InputDelete == nil then
			Octo_ToDo_DB_Vars.config.InputDelete = true
		end
		if Octo_ToDo_DB_Vars.config.ItemLevel == nil then
			Octo_ToDo_DB_Vars.config.ItemLevel = true
		end
		if Octo_ToDo_DB_Vars.config.itemLevelToShow == nil then
			Octo_ToDo_DB_Vars.config.itemLevelToShow = 1
		end
		if Octo_ToDo_DB_Vars.config.Items == nil then
			Octo_ToDo_DB_Vars.config.Items = true
		end
		if Octo_ToDo_DB_Vars.config.ItemsDelete == nil then
			Octo_ToDo_DB_Vars.config.ItemsDelete = false
		end
		if Octo_ToDo_DB_Vars.config.ItemsShowAllways == nil then
			Octo_ToDo_DB_Vars.config.ItemsShowAllways = false
		end
		if Octo_ToDo_DB_Vars.config.ItemsUsable == nil then
			Octo_ToDo_DB_Vars.config.ItemsUsable = false
		end
		if Octo_ToDo_DB_Vars.config.LastUpdate == nil then
			Octo_ToDo_DB_Vars.config.LastUpdate = true
		end
		if Octo_ToDo_DB_Vars.config.LevelToShow == nil then
			Octo_ToDo_DB_Vars.config.LevelToShow = 1
		end
		if Octo_ToDo_DB_Vars.config.LevelToShowMAX == nil then
			Octo_ToDo_DB_Vars.config.LevelToShowMAX = E.currentMaxLevel
		end
		if Octo_ToDo_DB_Vars.config.LootFrame == nil then
			Octo_ToDo_DB_Vars.config.LootFrame = true
		end
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == nil then
			Octo_ToDo_DB_Vars.config.MajorKeyflames = true
		end
		if Octo_ToDo_DB_Vars.config.Minecraft == nil then
			Octo_ToDo_DB_Vars.config.Minecraft = false
		end
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == nil then
			Octo_ToDo_DB_Vars.config.MinorKeyflames = true
		end
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == nil then
			Octo_ToDo_DB_Vars.config.MP_MythicKeystone = true
		end
		if Octo_ToDo_DB_Vars.config.PortalsButtons == nil then
			Octo_ToDo_DB_Vars.config.PortalsButtons = true
		end
		if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == nil then
			Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent = false
		end
		if Octo_ToDo_DB_Vars.config.prefix == nil then
			Octo_ToDo_DB_Vars.config.prefix = 1
		end
		if Octo_ToDo_DB_Vars.config.Quests == nil then
			Octo_ToDo_DB_Vars.config.Quests = true
		end
		if Octo_ToDo_DB_Vars.config.QuestsShowAllways == nil then
			Octo_ToDo_DB_Vars.config.QuestsShowAllways = false
		end
		if Octo_ToDo_DB_Vars.config.Reputations == nil then
			Octo_ToDo_DB_Vars.config.Reputations = true
		end
		if Octo_ToDo_DB_Vars.config.ReputationsShowAllways == nil then
			Octo_ToDo_DB_Vars.config.ReputationsShowAllways = false
		end
		if Octo_ToDo_DB_Vars.config.ResetAllChars == nil then
			Octo_ToDo_DB_Vars.config.ResetAllChars = true
		end
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == nil then
			Octo_ToDo_DB_Vars.config.RunedHarbingerCrest = true
		end
		if Octo_ToDo_DB_Vars.config.ShowIDS == nil then
			Octo_ToDo_DB_Vars.config.ShowIDS = true
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame = {}
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.Shown == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame.Shown = true
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.point == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame.point = "BOTTOM"
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.relativePoint == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame.relativePoint = "BOTTOM"
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.xOfs == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame.xOfs = 129
		end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.yOfs == nil then
			Octo_ToDo_DB_Vars.config.SpeedFrame.yOfs = 67
		end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag == nil then
			Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag = false
		end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == nil then
			Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm = true
		end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer == nil then
			Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = true
		end
		if Octo_ToDo_DB_Vars.config.ShowTime70 == nil then
			Octo_ToDo_DB_Vars.config.ShowTime70 = true
		end
		if Octo_ToDo_DB_Vars.config.ShowTimeAll == nil then
			Octo_ToDo_DB_Vars.config.ShowTimeAll = true
		end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == nil then
			Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL = true
		end
		if Octo_ToDo_DB_Vars.config.ShowTotalMoney == nil then
			Octo_ToDo_DB_Vars.config.ShowTotalMoney = true
		end
		if Octo_ToDo_DB_Vars.config.SORTING == nil then
			Octo_ToDo_DB_Vars.config.SORTING = true
		end
		if Octo_ToDo_DB_Vars.config.StaticPopup1Button1 == nil then
			Octo_ToDo_DB_Vars.config.StaticPopup1Button1 = true
		end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks == nil then
			Octo_ToDo_DB_Vars.config.TalentTreeTweaks = true
		end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha == nil then
			Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha = 1
		end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale == nil then
			Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale = 1
		end
		if Octo_ToDo_DB_Vars.config.Timewalk == nil then
			Octo_ToDo_DB_Vars.config.Timewalk = true
		end
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == nil then
			Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly = true
		end
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == nil then
			Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly = true
		end
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == nil then
			Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly = true
		end
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition == nil then
			Octo_ToDo_DB_Vars.config.UIErrorsFramePosition = true
		end
		if Octo_ToDo_DB_Vars.config.WasOnline == nil then
			Octo_ToDo_DB_Vars.config.WasOnline = true
		end
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == nil then
			Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest = true
		end
		for index, addonName in ipairs(E.OctoTable_LoadAddons) do
			Octo_ToDo_DB_Vars.config.Load[addonName] = Octo_ToDo_DB_Vars.config.Load[addonName] or false
			if not C_AddOns.DoesAddOnExist(addonName) then
				Octo_ToDo_DB_Vars.config.Load[addonName] = false
			end
		end
		if Octo_ToDo_DB_Vars.config.LoadAddons == true then
			for addname, value in pairs(Octo_ToDo_DB_Vars.config.Load) do
				if value == true then
					E.func_LoadAddOn(addname)
				end
			end
		end
		self:ConcatAtStart()
		self:O_otrisovka_FIRST()
		for i, func in next, (E.Modules) do
			func()
		end
		local MinimapName = GlobalAddonName.."Octo_ToDo_FIRST_Minimap"
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.AddonTexture_1,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							self:main_frame_toggle()
						end
						if OctoToDo_SECOND_MainFramePIZZA and OctoToDo_SECOND_MainFramePIZZA:IsShown() then
							OctoToDo_SECOND_MainFramePIZZA:Hide()
						end
					else
						if OctoToDo_FIRST_MainFramePIZZA and OctoToDo_FIRST_MainFramePIZZA:IsShown() then
							OctoToDo_FIRST_MainFramePIZZA:Hide()
						end
						if OctoToDo_SECOND_MainFramePIZZA and OctoToDo_SECOND_MainFramePIZZA:IsShown() then
							OctoToDo_SECOND_MainFramePIZZA:Hide()
						end
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(E.AddonTitle, true)
						end
					end
				end
				,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.func_Gradient(GlobalAddonName).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end
				,
				OnLeave = function()
					GameTooltip:Hide()
				end
				,
		})
		Octo_ToDo_DB_Vars.minimap_FIRST = Octo_ToDo_DB_Vars.minimap_FIRST or {}
		Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos = Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos or 244
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(E.AddonVersion)
		LibDBIcon:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_FIRST)
		LibDBIcon:Show(MinimapName)
		E.ADDON_LOADED(GlobalAddonName)
	end
end
function Octo_EventFrame:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
		if Octo_ToDo_DB_Vars.config.CVar then
			C_Timer.After(.1, function()
					E.LoadCVars()
				end
			)
		end
	end
end
function Octo_EventFrame:PLAYER_LOGIN()
	if not InCombatLockdown() then
		self:UnregisterEvent("PLAYER_LOGIN")
		self.PLAYER_LOGIN = nil
		C_WowTokenPublic.UpdateMarketPrice()
		Octo_ToDo_DB_Levels[curGUID] = Octo_ToDo_DB_Levels[curGUID] or {}
		self:checkCharInfo()
		self:Collect_ALL_PlayerInfo()
		self:Collect_All_Currency()
		self:Collect_All_Currency_TEST2()
		self:Collect_All_Reputations()
		self:Collect_All_Reputations_TEST2()
		self:Collect_ALL_GreatVault()
		self:Collect_ALL_ItemLevel()
		self:Collect_ALL_ItemsInBag()
		self:Collect_ALL_Locations()
		self:Collect_ALL_LoginTime()
		self:Collect_ALL_Mail()
		self:Collect_ALL_MoneyOnLogin()
		self:Collect_ALL_MoneyUpdate()
		self:Collect_All_Professions()
		self:Collect_All_Quests()
		self:Collect_All_Covenant()
		self:Collect_All_PlayerDurability()
		self:Collect_ALL_UNIVERSALQuestUpdate()
		self:Collect_All_journalInstance()
		self:Collect_Player_Level()
		self:Collect_WarMode()
		self:Collect_All_Holiday()
		self:Collect_BfA_Azerite()
		self:Collect_BfA_Cloaklvl()
		self:Collect_BfA_QuestsBounties()
		self:Collect_BfA_Island()
		RequestTimePlayed()
		Octo_ToDo_FIRST_CreateAltFrame()
		GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or 1)
		self:MustBeHiddenFrames()
	end
end
function Octo_EventFrame:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end
function Octo_EventFrame:SKILL_LINES_CHANGED()
	if not InCombatLockdown() then
		self:Collect_All_Professions()
	end
end
function Octo_EventFrame:PLAYER_XP_UPDATE()
	if not InCombatLockdown() then
		self:Collect_Player_Level()
	end
end
function Octo_EventFrame:QUEST_ACCEPTED()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_COMPLETE()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_FINISHED()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_LOG_UPDATE()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_REMOVED()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_TURNED_IN()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:QUEST_LOOT_RECEIVED()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_Quests()
				self:Collect_ALL_UNIVERSALQuestUpdate()
				self:Collect_BfA_Island()
				self:Collect_BfA_QuestsBounties()
			end
		)
	end
end
function Octo_EventFrame:PLAYER_MONEY()
	if not InCombatLockdown() then
		self:Collect_ALL_MoneyUpdate()
	end
end
function Octo_EventFrame:ACCOUNT_MONEY()
	if not InCombatLockdown() then
		self:Collect_ALL_MoneyUpdate()
	end
end
function Octo_EventFrame:CURRENCY_TRANSFER_LOG_UPDATE()
	if not InCombatLockdown() then
		self:Collect_All_Currency()
		self:Collect_All_Currency_TEST2()
	end
end
function Octo_EventFrame:PLAYER_EQUIPMENT_CHANGED()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemLevel()
	end
end
function Octo_EventFrame:PLAYER_LEAVING_WORLD()
	if not InCombatLockdown() then
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
		self.PLAYER_LEAVING_WORLD = nil
		self:Collect_ALL_GreatVault()
		self:Collect_ALL_LoginTime()
	end
end
function Octo_EventFrame:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if not InCombatLockdown() then
		self:Collect_BfA_Azerite()
		self:Collect_BfA_Cloaklvl()
	end
end
function Octo_EventFrame:COVENANT_CHOSEN()
	if not InCombatLockdown() then
		self:Collect_All_Covenant()
	end
end
function Octo_EventFrame:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	if not InCombatLockdown() then
		self:Collect_All_Covenant()
	end
end
function Octo_EventFrame:PLAYER_DEAD()
	if not InCombatLockdown() then
		self:Collect_All_PlayerDurability()
	end
end
function Octo_EventFrame:UPDATE_INVENTORY_DURABILITY()
	if not InCombatLockdown() then
		self:Collect_All_PlayerDurability()
	end
end
function Octo_EventFrame:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemsInBag()
	end
end
function Octo_EventFrame:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemsInBag()
	end
end
function Octo_EventFrame:ZONE_CHANGED_NEW_AREA()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemsInBag()
	end
end
function Octo_EventFrame:ITEM_COUNT_CHANGED()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemsInBag()
	end
end
function Octo_EventFrame:MAIL_SEND_SUCCESS()
	if not InCombatLockdown() then
		self:Collect_ALL_ItemsInBag()
	end
end
function Octo_EventFrame:PLAYER_SPECIALIZATION_CHANGED()
	if not InCombatLockdown() then
		self:Collect_ALL_PlayerInfo()
	end
end
function Octo_EventFrame:HEARTHSTONE_BOUND()
	if not InCombatLockdown() then
		self:Collect_ALL_Locations()
	end
end
function Octo_EventFrame:ZONE_CHANGED_NEW_AREA()
	if not InCombatLockdown() then
		self:Collect_ALL_Locations()
	end
end
function Octo_EventFrame:SPELLS_CHANGED()
	if not InCombatLockdown() then
		C_Timer.After(2, function()
				self:Collect_WarMode()
			end
		)
	end
end
function Octo_EventFrame:MAIL_INBOX_UPDATE()
	if not InCombatLockdown() then
		self:Collect_ALL_Mail()
	end
end
function Octo_EventFrame:MAIL_SHOW()
	if not InCombatLockdown() then
		self:Collect_ALL_Mail()
	end
end
function Octo_EventFrame:UPDATE_PENDING_MAIL()
	if not InCombatLockdown() then
		self:Collect_ALL_Mail()
	end
end
function Octo_EventFrame:PLAYER_REGEN_DISABLED()
	if OctoToDo_FIRST_MainFrame and OctoToDo_FIRST_MainFrame:IsShown() then
		OctoToDo_FIRST_MainFrame:Hide()
	end
end
function Octo_EventFrame:PLAYER_REGEN_ENABLED()
	if not InCombatLockdown() then
		C_Timer.After(5, function()
				if not InCombatLockdown() then
					self:Collect_All_Reputations()
					self:Collect_All_Reputations_TEST2()
					self:Collect_All_Currency()
					self:Collect_All_Currency_TEST2()
				end
			end
		)
	end
end
function Octo_EventFrame:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
function Octo_EventFrame:ENCOUNTER_END()
	if not InCombatLockdown() then
		C_Timer.After(1, function()
				self:Collect_All_journalInstance()
			end
		)
	end
end
function Octo_EventFrame:TIME_PLAYED_MSG(...)
	if not InCombatLockdown() then
		self:Collect_Played(...)
	end
end
function Octo_EventFrame:LFG_UPDATE_RANDOM_INFO()
	if not InCombatLockdown() then
		self:Collect_All_journalInstance()
	end
end
function Octo_EventFrame:LFG_COMPLETION_REWARD()
	if not InCombatLockdown() then
		self:Collect_All_journalInstance()
	end
end
function Octo_EventFrame:ENCOUNTER_LOOT_RECEIVED()
	if not InCombatLockdown() then
		self:Collect_All_journalInstance()
	end
end
function Octo_EventFrame:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if not InCombatLockdown() then
		self:Collect_All_journalInstance()
	end
end
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		self:main_frame_toggle()
	end
end
local editFrame, editBox = _G[GlobalAddonName.."EditFrame"], _G[GlobalAddonName.."EditFrame"].editFrame
SLASH_GSEARCH1, SLASH_GSEARCH2 = "/gsearch", "/gs"
SlashCmdList.GSEARCH = function(msg)
	DEFAULT_CHAT_FRAME:AddMessage (E.func_Gradient("GSEARCH: ") .. msg)
	local str = ""
	local list = {}
	for i, n in next, (_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..E.func_Gradient(i).. " - ".. n .."\n"
		end
	end
	editBox:SetText(str)
	editFrame:Show()
end
SlashCmdList["RELOAD"] = E.ReloadUI()
SLASH_RELOAD1 = "/rl"
SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function(msg)
	if not E.IsAddOnLoaded("Blizzard_DebugTools") then
		E.LoadAddOn("Blizzard_DebugTools")
	end
	local showHidden, showRegions, showAnchors = (msg == "true"), true, true
	FrameStackTooltip_Toggle(showHidden, showRegions, showAnchors)
end