local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonNotes = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Notes")
local AddonAuthor = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Author")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
local WOW_currentBuild = tonumber(GetBuildInfo():match("(.-)%."))
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
_G["OctoTODO"] = OctoTODO
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local AceLocale = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local CallbackHandler = LibStub("CallbackHandler-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibTranslit = LibStub("LibTranslit-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local ItemLevelGreen = 625
local ItemLevelOrange = 610
local ItemLevelRed = 580
if WOW_currentBuild == 1 then E.Octo_Globals.currentMaxLevel = 60 end
if WOW_currentBuild == 2 then E.Octo_Globals.currentMaxLevel = 70 end
if WOW_currentBuild == 3 then E.Octo_Globals.currentMaxLevel = 80 end
if WOW_currentBuild == 4 then E.Octo_Globals.currentMaxLevel = 85 end
if WOW_currentBuild == 5 then E.Octo_Globals.currentMaxLevel = 90 end
if WOW_currentBuild == 6 then E.Octo_Globals.currentMaxLevel = 100 end
if WOW_currentBuild == 7 then E.Octo_Globals.currentMaxLevel = 110 end
if WOW_currentBuild == 8 then E.Octo_Globals.currentMaxLevel = 120 end
if WOW_currentBuild == 9 then E.Octo_Globals.currentMaxLevel = 60 end
if WOW_currentBuild == 10 then E.Octo_Globals.currentMaxLevel = 70 end
if WOW_currentBuild == 11 then E.Octo_Globals.currentMaxLevel = 80 end
local curWidthTitle = E.Octo_Globals.curWidthTitle
E.Octo_Func.func_Octo_LoadAddOn("!BugGrabber")
E.Octo_Func.func_Octo_LoadAddOn("BugSack")
E.Octo_Func.func_Octo_LoadAddOn("MountsJournal")
E.Octo_Func.func_Octo_LoadAddOn("HidingBar")
E.Octo_Func.func_Octo_LoadAddOn("HidingBar_Options")
-- E.Octo_Func.func_Octo_LoadAddOn("QuestsChanged")
-- E.Octo_Func.func_Octo_LoadAddOn("TalentTreeTweaks")
-- E.Octo_Func.func_Octo_LoadAddOn("SpeedyAutoLoot")
-- E.Octo_Func.func_Octo_LoadAddOn("Plater")

local Button = nil
local CF = nil
local Octo_ToDo_FIRST_Frame_Char_Frame = nil
local Octo_ToDo_FIRST_Frame_EventFrame = nil
local inspectScantipFIRST = nil
local OctoToDo_MainFrame = nil
local OctoToDo_CloseButton = nil
local OctoToDo_OptionsButton = nil
local OctoToDo_AbandonButton = nil
local OctoToDo_MplusButton = nil
local OctoToDo_ItemsButton = nil
local className, classFilename, classId = UnitClass("PLAYER")
local classColor = E.Octo_Func.GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local classColorHexCurrent = E.Octo_Func.func_rgb2hex(r, g, b)
if classFilename == "SHAMAN" then
	classcolor = "0070de"
end
local Horde_Icon = E.Octo_Func.func_texturefromIcon(132485)
local Alliance_Icon = E.Octo_Func.func_texturefromIcon(132486)
local Kyrian_Icon = E.Octo_Func.func_texturefromIcon(3257748)
local Necrolord_Icon = E.Octo_Func.func_texturefromIcon(3257749)
local NightFae_Icon = E.Octo_Func.func_texturefromIcon(3257750)
local Venthyr_Icon = E.Octo_Func.func_texturefromIcon(3257751)
local WorldBoss_Icon = E.Octo_Func.func_texturefromIcon(3528312)
local Rares_Icon = E.Octo_Func.func_texturefromIcon(135903)
local Unknown_Icon = E.Octo_Func.func_texturefromIcon(134400)
local Token_Icon = E.Octo_Func.func_texturefromIcon(1120721)
local Money_Icon = E.Octo_Func.func_texturefromIcon(133784, 12)
local MailBox_Icon = E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga")
local font = "01 Octo"
local fontObject9 = CreateFont("OctoFont9")
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\"..font..".TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
local Meta_Table_DONE = {__index = function() return E.Octo_Globals.DONE end}
local Meta_Table_NONE = {__index = function() return E.Octo_Globals.NONE end}
local Meta_Table_Empty = {__index = function() return "" end}
local TrashFrames_table = {
	{name = "WeeklyRewardExpirationWarningDialog", frame = WeeklyRewardExpirationWarningDialog},
	{name = "SplashFrame", frame = SplashFrame},
	{name = "MajorFactionsRenownToast", frame = MajorFactionsRenownToast},
	{name = "PTRIssueReporterAlertFrame", frame = PTRIssueReporterAlertFrame},
}

local function Hide_trash_frames()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Hide_trash_frames".."|r")
	end
	for _, v in pairs(TrashFrames_table) do
		if v.frame and v.frame:IsShown() then
			ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Hide trash frames: ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..v.name)
			v.frame:Hide()
			v.frame:UnregisterAllEvents()
		end
	end
end

local function DEV_GUID()
	local curGUID = UnitGUID("PLAYER")
	local strGUID = tostringall(strsplit("-", utf8lower(utf8reverse(curGUID))))
	local vivod = E.Octo_Func.encryption(curGUID)
end

local function ConcatAtStart()
	E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_QuestID, E.Octo_Table.OctoTable_QuestID_Paragon)
	E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_Config)
	-- E.Octo_Func.TableConcat(Octo_ToDo_DB_Config.ReputationDB, E.Octo_Table.OctoTable_reputation_ALL)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Classic)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_TheBurningCrusade)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_WrathoftheLichKing)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Cataclysm)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_MistsofPandaria)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_WarlordsofDraenor)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Legion)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_BattleforAzeroth)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Shadowlands)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Dragonflight)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_TheWarWithin)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Hidden)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Archaeology)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_DungeonandRaid)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Miscellaneous)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_PlayervsPlayer)
	-- E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_currency_Virtual)
end

local function TryToOffMajor(majorFactionID, newRenownLevel, oldRenownLevel)
	local majorFactionID, newRenownLevel, oldRenownLevel = majorFactionID, newRenownLevel, oldRenownLevel
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TryToOffMajor".."|r")
	end
	if MajorFactionRenownToast then
		MajorFactionRenownToast:UnregisterAllEvents()
		MajorFactionRenownToast:Hide()
		ChatFrame1:AddMessage ("true MajorFactionRenownToast")
	else
		ChatFrame1:AddMessage ("Cannot Hide MajorFactionRenownToast")
	end
	if MajorFactionRenownFrame then
		MajorFactionRenownFrame:UnregisterAllEvents()
		MajorFactionRenownFrame:Hide()
		ChatFrame1:AddMessage ("true MajorFactionRenownFrame")
	else
		ChatFrame1:AddMessage ("Cannot Hide MajorFactionRenownFrame")
	end
	MajorFactionsRenownToastMixin:StopBanner()
end
local OctoTable_func_otrisovka_FIRST = {
}

local function Central_Frame_Mouse_OnEnter(self)
	local parent = OctoToDo_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in pairs(self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end

local function Central_Frame_Mouse_OnLeave(self)
	local parent = OctoToDo_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end

local function checkCharInfo(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."checkCharInfo".."|r")
	end
	self.journalInstance = self.journalInstance or {}
	local ServerTime = GetServerTime()
	for k, v in pairs(self.journalInstance) do
		if k then
			for q, w in pairs(v) do
				for e, r in pairs(w) do
					if e == "instanceReset" then
						if ServerTime >= r then
							self.journalInstance[k] = {}
						end
					end
				end
			end
		end
	end
	for _, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
		self["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = self["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] or E.Octo_Globals.NONE
	end
	self.LFGInstance = self.LFGInstance or {}
	self.professions = self.professions or {}
	self.avgItemLevel = self.avgItemLevel or 0
	self.avgItemLevelEquipped = self.avgItemLevelEquipped or 0
	self.avgItemLevelPvp = self.avgItemLevelPvp or 0
	self.className = self.className or 0
	self.classFilename = self.classFilename or 0
	self.classId = self.classId or 0
	self.classColor = self.classColor or {r = 0.5, g = 0.5, b = 0.5}
	self.CurrencyID = self.CurrencyID or {}
	self.CurrencyID_Total = self.CurrencyID_Total or {}
	self.CurrencyID_totalEarned = self.CurrencyID_totalEarned or {}
	self.curServer = self.curServer or "HZ"
	self.guildName = self.guildName or ""
	self.guildRankName = self.guildRankName or ""
	self.guildRankIndex = self.guildRankIndex or 0
	self.curServerShort = self.curServerShort or 0
	self.Faction = self.Faction or "Horde"
	self.ItemsInBag = self.ItemsInBag or {}
	self.maxNumQuestsCanAccept = self.maxNumQuestsCanAccept or 0
	self.Name = self.Name or 0
	self.numQuests = self.numQuests or 0
	self.RaceLocal = self.RaceLocal or 0
	self.RaceEnglish = self.RaceEnglish or 0
	self.raceID = self.raceID or 0
	self.currentXP = self.currentXP or 0
	self.UnitXPMax = self.UnitXPMax or 0
	self.UnitXPPercent = self.UnitXPPercent or 0
	self.realTotalTime = self.realTotalTime or 0
	self.realLevelTime = self.realLevelTime or 0
	self.numShownEntries = self.numShownEntries or 0
	self.loginDate = self.loginDate or 0
	self.loginDay = self.loginDay or 0
	self.loginHour = self.loginHour or 0
	self.OctoTable_QuestID = self.OctoTable_QuestID or {}
	self.reputationID = self.reputationID or {}
	self.UnitLevel = self.UnitLevel or 0
	self.Money = self.Money or 0
	self.MoneyOnLogin = self.MoneyOnLogin or 0
	self.BindLocation = self.BindLocation or 0
	self.CurrentLocation = self.CurrentLocation or 0
	self.WarMode = self.WarMode or false
	if self.needResetDaily == nil then self.needResetDaily = false end
	if self.needResetWeekly == nil then self.needResetWeekly = false end
	if self.needResetMonth == nil then self.needResetMonth = false end
	if self.HasAvailableRewards == nil then self.HasAvailableRewards = false end
	if self.hasMail == nil then self.hasMail = false end
	if self.isShownPLAYER == nil then self.isShownPLAYER = true end
	self.MoneyOnLogin = self.Money
	self.RIO_Score_TWW_S1 = self.RIO_Score_TWW_S1 or 0
	self.RIO_weeklyBest_TWW_S1 = self.RIO_weeklyBest_TWW_S1 or 0
	self.GreatVault = self.GreatVault or {}
	for name, i in next, Enum.WeeklyRewardChestThresholdType do
		self.GreatVault[i] = self.GreatVault[i] or {}
		self.GreatVault[i].progress = self.GreatVault[i].progress or 0
		self.GreatVault[i].threshold = self.GreatVault[i].threshold or 0
		self.GreatVault[i].hyperlink_STRING = self.GreatVault[i].hyperlink_STRING or 0
		self.GreatVault[i].type = self.GreatVault[i].type or ""
	end
	setmetatable(self, Meta_Table_0)
	setmetatable(self.CurrencyID_Total, Meta_Table_0)
	setmetatable(self.CurrencyID, Meta_Table_0)
	setmetatable(self.ItemsInBag, Meta_Table_0)
	setmetatable(self.OctoTable_QuestID, Meta_Table_NONE)
	setmetatable(self.reputationID, Meta_Table_0)
	if (self.tmstp_Weekly or 0) < GetServerTime() then
		for i = 1, #self.GreatVault do
			if self.GreatVault[i] and self.GreatVault[i].hyperlink_STRING ~= 0 then
				self.HasAvailableRewards = true
				self.GreatVault = {}
				break
			end
		end
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() and self.Octopussy_DF_Weekly_CommunityFeast_count == E.Octo_Globals.DONE then
		self.Octopussy_DF_Weekly_CommunityFeast_count = E.Octo_Globals.NONE
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() then
		self.tmstp_Weekly = E.Octo_Func.tmstpDayReset(7)
		self.needResetWeekly = true
		self.CurrentKey = 0
		self.CurrentKeyFULL = 0
		self.CurrentKeyLevel = 0
		self.journalInstance = {}
		self.RIO_weeklyBest_TWW_S1 = 0
		self.GreatVault = {}
		for i = 1, #self.GreatVault do
			if self.GreatVault[i] then
				self.GreatVault[i] = {}
				self.GreatVault[i].progress = 0
				self.GreatVault[i].threshold = 0
				self.GreatVault[i].hyperlink_STRING = 0
			end
		end
		for _, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				if w == "Weekly" then
					self["Octopussy_"..v.desc.."_"..v.name_save.."_".."Weekly"] = E.Octo_Globals.NONE
				end
			end
		end
	end
	if (self.tmstp_Daily or 0) < GetServerTime() then
		self.tmstp_Daily = E.Octo_Func.tmstpDayReset(1)
		self.needResetDaily = true
		for _, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				if w == "Daily" then
					self["Octopussy_"..v.desc.."_"..v.name_save.."_".."Daily"] = E.Octo_Globals.NONE
				end
			end
		end
		self.LFGInstance = {}
	end
	for dungeonID, name in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
		self.LFGInstance[dungeonID] = self.LFGInstance[dungeonID] or {}
		self.LFGInstance[dungeonID].D_name = self.LFGInstance[dungeonID].D_name or name
		self.LFGInstance[dungeonID].donetoday = self.LFGInstance[dungeonID].donetoday or E.Octo_Globals.NONE
	end
	if (self.tmstp_Month or 0) < GetServerTime() then
		self.tmstp_Month = E.Octo_Func.tmstpDayReset(30)
		self.needResetMonth = true
		for _, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				if w == "Month" then
					self["Octopussy_"..v.desc.."_"..v.name_save.."_".."Month"] = E.Octo_Globals.NONE
				end
			end
		end
	end
end

local function CreateFrameUsableItems_OnShow(self)
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) >= self.count
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true and (hasToy == true or hasItem == true) then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	if self.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	if self.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end

local function CreateFrameUsableItems_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 0)
	local itemLink = select(2, GetItemInfo(self.itemID))
	if itemLink then
		GameTooltip:ClearLines()
		GameTooltip:SetHyperlink(itemLink)
		GameTooltip:Show()
	end
	self:SetBackdropBorderColor(r, g, b, 1)
end

local function CreateFrameUsableItems_OnLeave(self)
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) >= self.count
	local isKnown = IsSpellKnown(self.spellID)
	GameTooltip:ClearLines()
	GameTooltip:Hide()
	self:SetBackdropBorderColor(0, 0, 0, 1)
	if isKnown == true and (hasToy == true or hasItem == true) then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	if self.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	if self.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end

local function CreateFrameUsableItems_OnEvent(self, event, arg1, ...)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableItems_OnEvent".."|r"..event)
	end
	if (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
		local startTime, duration = C_Container.GetItemCooldown(self.itemID)
		local hasToy = PlayerHasToy(self.itemID)
		local hasItem = GetItemCount(self.itemID, true, true, true) >= self.count
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == true and (hasToy == true or hasItem == true) then
			self.icon:SetVertexColor(1, 1, 1, 1)
		else
			self.icon:SetVertexColor(1, .5, .5, .3)
		end
		if self.itemID == 110560 and (C_QuestLog.IsQuestFlaggedCompleted(34378) == false and C_QuestLog.IsQuestFlaggedCompleted(34586) == false) then
			self.icon:SetVertexColor(1, .5, .5, .3)
		end
		if self.itemID == 140192 and (C_QuestLog.IsQuestFlaggedCompleted(44184) == false and C_QuestLog.IsQuestFlaggedCompleted(44663) == false) then
			self.icon:SetVertexColor(1, .5, .5, .3)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(OctoToDo_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end

local function CreateFrameUsableItems_OnMouseDown(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableItems_OnMouseDown".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, E.Octo_Globals.BGALPHA)
end

local function CreateFrameUsableItems_OnMouseUp(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableItems_OnMouseUp".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, 1)
end

local function CreateFrameUsableItems(itemID, Texture, Xpos, Ypos, r, g, b, spellID)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableItems".."|r")
	end
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.itemID = itemID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.count = 1
	Button.spellID = spellID or 431280
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	Button:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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

local function CreateFrameUsableSpells_OnEnter(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnEnter".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 0)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	self:SetBackdropBorderColor(r, g, b, 1)
	local link = C_Spell.GetSpellLink(self.spellID)
	if link then
		GameTooltip:ClearLines()
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

local function CreateFrameUsableSpells_OnLeave(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnLeave".."|r")
	end
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	GameTooltip:ClearLines()
	GameTooltip:Hide()
	self:SetBackdropBorderColor(0, 0, 0, 1)
end

local function CreateFrameUsableSpells_OnShow(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnEvent".."|r")
	end
	if (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
		local startTime, duration = C_Spell.GetSpellCooldown(self.spellID)
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == true then
			self.icon:SetVertexColor(1, 1, 1, 1)
		else
			self.icon:SetVertexColor(1, .5, .5, .3)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(OctoToDo_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end

local function CreateFrameUsableSpells_OnEvent(self, event)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnEvent".."|r")
	end
	if (event == "TOYS_UPDATED" or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
		local startTime, duration = C_Spell.GetSpellCooldown(self.spellID)
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == true then
			self.icon:SetVertexColor(1, 1, 1, 1)
		else
			self.icon:SetVertexColor(1, .5, .5, .3)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(OctoToDo_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end

local function CreateFrameUsableSpells_OnMouseDown(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnMouseDown".."|r")
	end
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end

local function CreateFrameUsableSpells_OnMouseUp(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells_OnMouseUp".."|r")
	end
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end

local function CreateFrameUsableSpells(spellID, Texture, Xpos, Ypos, r, g, b)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."CreateFrameUsableSpells".."|r")
	end
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.spellID = spellID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	Button:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1
	})
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
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

local function Octo_ToDoDeleteChar(curGUID)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Octo_ToDoDeleteChar".."|r")
	end
	Octo_ToDo_DB_Players[curGUID] = nil
	for X, Y in pairs(OctoToDo_MainFrame.AllCharFrames) do
		if Y == OctoToDo_MainFrame[curGUID] then
			OctoToDo_MainFrame.AllCharFrames[X].parent = nil
			OctoToDo_MainFrame.AllCharFrames[X]:Hide()
			OctoToDo_MainFrame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDo_FIRST_AddDataToAltFrame()
end

local function Collect_ALL_PlayerInfo()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_PlayerInfo()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
	local curServerShort = E.Octo_Func.func_CurServerShort(GetRealmName())
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
		collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
		collect.RaceLocal = RaceLocal
		collect.RaceEnglish = RaceEnglish
		collect.raceID = raceID
		collect.classColorHex = classColorHexCurrent
		collect.guildName = guildName
		collect.guildRankName = guildRankName
		collect.guildRankIndex = guildRankIndex
	end
	for k, v in pairs(E.Octo_Table.OctoTable_KeystoneAbbr) do
		local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(v.mapChallengeModeID)
		Octo_ToDo_DB_Other.TestInstances = Octo_ToDo_DB_Other.TestInstances or {}
		if name then
			Octo_ToDo_DB_Other.TestInstances[id] = Octo_ToDo_DB_Other.TestInstances[id] or {}
			Octo_ToDo_DB_Other.TestInstances[id].name = name or ""
			Octo_ToDo_DB_Other.TestInstances[id].timeLimit = timeLimit or 0
			Octo_ToDo_DB_Other.TestInstances[id].texture = texture or 0
			Octo_ToDo_DB_Other.TestInstances[id].backgroundTexture = backgroundTexture or 0
			Octo_ToDo_DB_Other.TestInstances[id].abbreviation = v.abbreviation or ""
		end
	end
end

local function Collect_ALL_mapChallengeModeID()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_mapChallengeModeID".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_mapChallengeModeID
	-- Octo_ToDo_DB_mapChallengeModeID = {}
	for i = 1, 1000 do
		local name, _, timeLimit, texture = C_ChallengeMode.GetMapUIInfo(i)
		if name then
			collect[i] = collect[i] or {}
			collect[i].name = name
			collect[i].timeLimit = timeLimit
			collect[i].minutes = E.Octo_Func.SecondsToClock(timeLimit)
			collect[i].texture = texture
		end
	end
end

local function Collect_Player_Level()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_Player_Level()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local UnitLevel = UnitLevel("PLAYER") or 0
	local currentXP = UnitXP("PLAYER") or 0
	local UnitXPMax = UnitXPMax("PLAYER") or 0
	local UnitXPPercent = math.ceil((currentXP/UnitXPMax)*100)
	if collect then
		collect.UnitLevel = UnitLevel
		collect.currentXP = currentXP
		collect.UnitXPMax = UnitXPMax
		collect.UnitXPPercent = UnitXPPercent
	end
end

local function Collect_Played(totalTime, currentLevelTime)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_Played()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	if collect then
		collect.realTotalTime = totalTime
		collect.realLevelTime = currentLevelTime
	end
end

local function Collect_WarMode()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_WarMode()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local WarMode = C_PvP.IsWarModeDesired()
	if collect then
		collect.WarMode = WarMode
	end
end

local function Collect_ALL_Mail()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_Mail()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local hasMail = HasNewMail()
	if collect and not InCombatLockdown() then
		collect.hasMail = hasMail
	end
end

local function Collect_ALL_LoginTime()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_LoginTime()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	collect.loginDate = date("%d.%m.%Y %H:%M:%S")
	collect.loginDay = date("%d.%m.%Y")
	collect.loginHour = date("%H:%M")
	collect.needResetWeekly = false
	collect.needResetDaily = false
	collect.needResetMonth = false
end

local function Collect_All_Professions()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_All_Professions()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	if collect then
		collect.professions = {}
		local ProfTable = {}
		local prof1, prof2, archaeology, fishing, cooking = GetProfessions()
		if prof1 then tinsert(ProfTable, prof1) end
		if prof2 then tinsert(ProfTable, prof2) end
		if archaeology then tinsert(ProfTable, archaeology) end
		if fishing then tinsert(ProfTable, fishing) end
		if cooking then tinsert(ProfTable, cooking) end
		for k, v in pairs(ProfTable) do
			local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(v)
			if skillLine then
				collect.professions[skillLine] = collect.professions[skillLine] or {}
				collect.professions[skillLine].name = name
				collect.professions[skillLine].icon = icon
				collect.professions[skillLine].skillLevel = skillLevel
				collect.professions[skillLine].maxSkillLevel = maxSkillLevel
				collect.professions[skillLine].numAbilities = numAbilities
				collect.professions[skillLine].spelloffset = spelloffset
				collect.professions[skillLine].skillLine = skillLine
				collect.professions[skillLine].skillModifier = skillModifier
				collect.professions[skillLine].specializationIndex = specializationIndex
				collect.professions[skillLine].specializationOffset = specializationOffset
			end
		end
		return
	end
end

local function Collect_ALL_GreatVault()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_GreatVault".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
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
				for name, i in pairs(Enum.WeeklyRewardChestThresholdType) do
					if i == k then
						self[k] = name
						break
					end
				end
				return self[k]
			end
	})
	for name, i in pairs(Enum.WeeklyRewardChestThresholdType) do
		local test
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
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[tip].hyperlink_STRING = test
						end
					end
				end
			end
		end
	end
end

local function Collect_All_Currency()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_All_Currency()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	Octo_ToDo_DB_Config = Octo_ToDo_DB_Config or {}
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
	for CurrencyID, v in pairs(Octo_ToDo_DB_Config.CurrencyDB) do
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(CurrencyID) or false
		local data = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
		if data then
		local quantity = data.quantity
		local maxQuantity = data.maxQuantity
		local totalEarned = data.totalEarned
			if isAccountWideCurrency == false then
				if collect and not InCombatLockdown() then
					if quantity then
						collect.CurrencyID[CurrencyID] = quantity
					end
					if totalEarned then
						collect.CurrencyID_totalEarned[CurrencyID] = totalEarned
					end
					if maxQuantity ~= 0 then
						if quantity ~= maxQuantity then
							collect.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
						else
							collect.CurrencyID_Total[CurrencyID] = E.Octo_Globals.Green_Color..quantity.."/"..maxQuantity.."|r"
						end
					else
						collect.CurrencyID_Total[CurrencyID] = quantity
					end
				end
			else
				for GUID, tbl in pairs(Octo_ToDo_DB_Players) do
					if tbl and not InCombatLockdown() then
						if quantity then
							tbl.CurrencyID[CurrencyID] = quantity
						end
						if totalEarned then
							tbl.CurrencyID_totalEarned[CurrencyID] = totalEarned
						end
						if maxQuantity ~= 0 then
							if quantity ~= maxQuantity then
								tbl.CurrencyID_Total[CurrencyID] = quantity.."/"..maxQuantity
							else
								tbl.CurrencyID_Total[CurrencyID] = E.Octo_Globals.Green_Color..quantity.."/"..maxQuantity.."|r"
							end
						else
							tbl.CurrencyID_Total[CurrencyID] = quantity
						end
					end
				end
			end
		else
			collect.CurrencyID[CurrencyID] = 0
			collect.CurrencyID_Total[CurrencyID] = 0
			collect.CurrencyID_totalEarned[CurrencyID] = 0
		end
	end
end

local function Collect_All_Reputations()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_All_Reputations()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
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
		-- for repID, v in pairs(E.Octo_Table.OctoTable_reputation_ALL) do
		-- 	tinsert(Octo_ToDo_DB_Config.ReputationDB[repID], true)
		-- end
		for reputationID, v in pairs(Octo_ToDo_DB_Config.ReputationDB) do
			local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
			if isAccountWide == false then
				collect.reputationID[reputationID] = E.Octo_Func.CheckReputationByRepID(reputationID) or 0
			else
				for GUID, tbl in pairs(Octo_ToDo_DB_Players) do
					tbl.reputationID[reputationID] = E.Octo_Func.CheckReputationByRepID(reputationID) or 0
				end
			end
		end
	end
end

local function Collect_ALL_ItemsInBag()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_ItemsInBag()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local Abbr_En_Name = E.Octo_Globals.NONE
	for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
		for slot = C_Container.GetContainerNumSlots(bag), 1, -1 do
			local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
			if containerInfo then
				local stackCount = containerInfo.stackCount
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				local hyperlink = containerInfo.hyperlink
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(hyperlink)
				if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") or hyperlink:find("keystone:151086") then
					local dungeonID = select(3, strsplit(":", hyperlink))
					local lvl = select(4, strsplit(":", hyperlink))
					collect.CurrentKeyLevel = tonumber(lvl)
					collect.CurrentKeyFULL = C_ChallengeMode.GetMapUIInfo(dungeonID)
					for k, v in ipairs(E.Octo_Table.OctoTable_KeystoneAbbr) do
						if v.mapChallengeModeID == tonumber(dungeonID) then
							collect.CurrentKey = lvl.." "..v.abbreviation
						end
					end
				end
			end
		end
	end
	Octo_ToDo_DB_Config = Octo_ToDo_DB_Config or {}
	Octo_ToDo_DB_Config.ItemDB = Octo_ToDo_DB_Config.ItemDB or {}
	if collect and not InCombatLockdown() then
		for _, itemID in ipairs(E.Octo_Table.OctoTable_itemID_ALL) do
			Octo_ToDo_DB_Config.ItemDB[itemID] = Octo_ToDo_DB_Config.ItemDB[itemID] or false
			local count = GetItemCount(itemID, true, true, true)
			collect.ItemsInBag[itemID] = count
		end
		collect.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	end
end

local function Collect_ALL_EncounterAndZoneLists()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_EncounterAndZoneLists()".."|r")
	end
	Octo_ToDo_DB_Other = Octo_ToDo_DB_Other or {}
	local clear = false
	if clear == true then
		Octo_ToDo_DB_Other.EncounterAndZoneLists = {}
	else
		Octo_ToDo_DB_Other.EncounterAndZoneLists = Octo_ToDo_DB_Other.EncounterAndZoneLists or {}
		for tier = 1, EJ_GetNumTiers() do
			EJ_SelectTier(tier)
			local tierName = EJ_GetTierInfo(tier)
			Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName] = Octo_ToDo_DB_Other.EncounterAndZoneLists[tierName] or {}
			for _, inRaid in ipairs({false, true}) do
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

local function Collect_ALL_Locations()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_Locations()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
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

local function Collect_All_Quests()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_All_Quests()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for k, questID in pairs(E.Octo_Table.OctoTable_QuestID) do
		local vivod = E.Octo_Func.CheckCompletedByQuestID(questID)
		-- if vivod ~= E.Octo_Globals.NONE then
			collect.OctoTable_QuestID[questID] = vivod
		-- end
	end
	if collect then
		collect.numShownEntries = numShownEntries or 0
		collect.numQuests = E.Octo_Func.CurrentNumQuests()
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept or 0
	end
end

local function Collect_ALL_ItemLevel()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_ItemLevel()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	if collect and not InCombatLockdown() then
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end

local function Collect_ALL_UNIVERSALQuestUpdate()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_UNIVERSALQuestUpdate()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	for _, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
		for _, w in pairs(v) do
			local count = 0
			local vivod = ""
			for _, questID in pairs(v.questID) do
				if v.max > 1 then
					if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
						count = count + 1
					end
					vivod = count
				else
					local IsComplete = E.Octo_Func.CheckCompletedByQuestID(questID)
					if IsComplete ~= E.Octo_Globals.NONE then
						vivod = IsComplete
					end
				end
			end
			if collect then
				if v.max == 1 then
					collect["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = vivod
				elseif v.max > 1 then
					if vivod == v.max and v.max > 1 then
						collect["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = E.Octo_Globals.DONE
					else
						collect["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = vivod.."/"..v.max
					end
				end
			end
		end
	end
end

local function Collect_ALL_MoneyUpdate()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_MoneyUpdate()".."|r")
	end
	Octo_ToDo_DB_Players[UnitGUID("PLAYER")].Money = GetMoney() or 0
	Octo_ToDo_DB_Other.AccountMoney = C_Bank.FetchDepositedMoney(2)
end

local function Collect_ALL_MoneyOnLogin()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_ALL_MoneyOnLogin()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.MoneyOnLogin = Money
	end
end

local function IsInArray(arr, subj)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."IsInArray".."|r")
	end
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end

local function Collect_All_journalInstance()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Collect_All_journalInstance()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_DB_Players[curGUID]
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
					local color = E.Octo_Globals.Red_Color
					if lastBossDefeated then color = E.Octo_Globals.Yellow_Color end
					if defeatedBosses == totalBosses then color = E.Octo_Globals.Green_Color end
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
					collect.journalInstance[instanceId][instanceDifficulty].Time = E.Octo_Func.SecondsToClock(instanceReset-ServerTime)
				end
			end
		end
		for i=1, GetNumRandomDungeons() do
			local dungeonID, name = GetLFGRandomDungeonInfo(i)
			if dungeonID then
				Octo_ToDo_DB_Other.LFGInstance[dungeonID] = name
			end
		end
		for i=1, GetNumRandomDungeons() do
			local dungeonID, name = GetLFGRandomDungeonInfo(i)
			local D_name = GetLFGDungeonInfo(dungeonID)
			local donetoday = GetLFGDungeonRewards(dungeonID)
			collect.LFGInstance[dungeonID] = collect.LFGInstance[dungeonID] or {}
			collect.LFGInstance[dungeonID].D_name = D_name
			if donetoday == true then
				collect.LFGInstance[dungeonID].donetoday = E.Octo_Globals.DONE
			else
				collect.LFGInstance[dungeonID].donetoday = E.Octo_Globals.NONE
			end
		end
	end
end

local function TEST_GROUP_ROSTER()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TEST_GROUP_ROSTER".."|r")
	end
end

local function Octo_ToDo_FIRST_OnLoad()
	if not Octo_ToDo_FIRST_Frame_EventFrame then
		Octo_ToDo_FIRST_Frame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_SKILL")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ITEM_COUNT_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAJOR_FACTION_RENOWN_LEVEL_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAJOR_FACTION_UNLOCKED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_LOOT_RECEIVED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ENCOUNTER_END")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("HEARTHSTONE_BOUND")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_INBOX_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_SEND_SUCCESS")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_SHOW")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_MONEY")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ACCOUNT_MONEY")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_COMPLETE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_FINISHED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_REMOVED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("READY_CHECK")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("SPELLS_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TOYS_UPDATED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TRAINER_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("UPDATE_PENDING_MAIL")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_XP_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TIME_PLAYED_MSG")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("SHOW_SUBSCRIPTION_INTERSTITIAL")
	Octo_ToDo_FIRST_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_FIRST_OnEvent(...)
	end)
	if not inspectScantipFIRST then
		inspectScantipFIRST = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		inspectScantipFIRST:SetOwner(UIParent, "ANCHOR_NONE")
	end
end

local function O_otrisovka_FIRST()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."O_otrisovka_FIRST".."|r")
	end
	-- ник персонажа
	tinsert(OctoTable_func_otrisovka_FIRST,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			CL:SetFontObject(OctoFont12)
			vivodCent = CharInfo.classColorHex..CharInfo.Name.."|r"
			if CharInfo.Faction == "Horde" then
				BG:SetColorTexture(.5, 0, 0, E.Octo_Globals.BGALPHA*2)
			else
				BG:SetColorTexture(0, 0, .5, E.Octo_Globals.BGALPHA*2)
			end
			if CharInfo.hasMail then
				BG:SetColorTexture(1, 1, 1, E.Octo_Globals.BGALPHA)
				vivodCent = vivodCent..MailBox_Icon
			else
				if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= E.Octo_Globals.currentMaxLevel then
					CL:SetFontObject(OctoFont10)
					vivodCent = vivodCent.." "..CharInfo.UnitLevel
				end
			end
			if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == false then
				CL:SetFontObject(OctoFont9)
				vivodCent = vivodCent.."|n"..CharInfo.curServer
			end
			if CharInfo.ItemsInBag[122284] ~= 0 then
				vivodCent = vivodCent..E.Octo_Func.func_itemTexture(122284)
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(122284)..E.Octo_Func.func_itemName(122284), CharInfo.ItemsInBag[122284]}
			end
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal then
				if CharInfo.guildRankIndex ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", "<"..E.Octo_Globals.Green_Color..CharInfo.guildName.."|r"..">".." ["..E.Octo_Globals.Green_Color..CharInfo.guildRankName.."|r".."]"}
				else
					tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", CharInfo.WarMode and E.Octo_Globals.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""}
					vivodCent = vivodCent..E.Octo_Globals.Green_Color.."-".."|r"
				end
				if CharInfo.WarMode and CharInfo.WarMode ~= false then
					tooltip[#tooltip+1] = {CharInfo.WarMode and E.Octo_Globals.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or "", ""}
				end
				if CharInfo.UnitLevel ~= E.Octo_Globals.currentMaxLevel and CharInfo.UnitXPPercent then
					tooltip[#tooltip+1] = {CharInfo.RaceLocal.." "..CharInfo.classColorHex..CharInfo.UnitLevel.."-го|r уровня "..CharInfo.classColorHex..CharInfo.UnitXPPercent.."%|r", " "}
				else
					tooltip[#tooltip+1] = {CharInfo.RaceLocal, " "}
				end
				if CharInfo.specName ~= 0 or CharInfo.specName ~= 0 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className, " "}
				end
				tooltip[#tooltip+1] = {" ", " "}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(236664)..QUESTS_LABEL, CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"}
			end
			if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..(E.Octo_Func.SecondsToClock(CharInfo.realTotalTime)).."|r")}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..(E.Octo_Func.SecondsToClock(CharInfo.realLevelTime)).."|r")}
			end
			vivodLeft = E.Octo_Timer.Daily_Reset()
			return vivodCent, vivodLeft
	end)
	-- ЭПОХАЛЬНЫЙ КЛЮЧ
	if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.WOW_Epic_Color..L["Mythic Keystone"].."|r"
				if CharInfo.CurrentKeyFULL ~= 0 then
					tooltip[#tooltip+1] = {E.Octo_Func.RIO_Color(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
					tooltip[#tooltip+1] = {" ", " "}
				end
				local Enum_Activities_table = {}
				for name, i in next, Enum.WeeklyRewardChestThresholdType do
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
							tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.Octo_Func.RIO_Color(CharInfo.RIO_Score_TWW_S1)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
						elseif CharInfo.GreatVault[i].progress ~= 0 then
							tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
						end
					end
				end
				if CharInfo.RIO_Score_TWW_S1 ~= 0 then
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"RIO Score:", E.Octo_Func.RIO_Color(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_Score_TWW_S1.."|r"}
					tooltip[#tooltip+1] = {"Weekly Best:", E.Octo_Func.RIO_Color(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_weeklyBest_TWW_S1.."|r"}
				end
				if CharInfo.CurrentKey ~= 0 then
					vivodCent = E.Octo_Func.RIO_Color(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKey.."|r"
				end
				if CharInfo.HasAvailableRewards then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color..">Vault<|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.BeledarCycle == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = L["Light/Dark Cycle"].." "..E.Octo_Timer.TWW_BeledarCycle()
				if CharInfo.OctoTable_QuestID[83240] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[83240]
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = WorldBoss_Icon..L["World Boss"]
				if CharInfo.Octopussy_TWW_WorldBoss_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_TWW_WorldBoss_Weekly
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = L["Weekly Dungeon Quest"]
				if CharInfo.Octopussy_TWW_DungeonQuest_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_TWW_DungeonQuest_Weekly
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Bonus Event Holiday Quests"
				if CharInfo.Octopussy_TWW_Delve_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_TWW_Delve_Weekly
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	--
	if Octo_ToDo_DB_Vars.config.MajorKeyflames == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_texturefromIcon(132863) .. L["Major Keyflames"]
				if CharInfo.Octopussy_TWW_MajorKeyflames_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_TWW_MajorKeyflames_Weekly
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.MinorKeyflames == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_texturefromIcon(135619) .. L["Minor Keyflames"]
				if CharInfo.Octopussy_TWW_MinorKeyflames_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_TWW_MinorKeyflames_Weekly
				end
				BG:SetColorTexture(E.Octo_Globals.QW_Color_r, E.Octo_Globals.QW_Color_g, E.Octo_Globals.QW_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local currencyID = 2917
				local color = E.Octo_Globals.WOW_Epic_Color
				vivodLeft = E.Octo_Func.func_currencyicon(currencyID)..color..E.Octo_Func.func_currencyName_NOCOLOR(currencyID).."|r"
				local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
				if data then
					local maxQuantity = data.maxQuantity
					local totalEarned = data.totalEarned
					if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
						tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
					else
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
					end
					if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
					end
				end
				BG:SetColorTexture(E.Octo_Globals.CREST_Color_r, E.Octo_Globals.CREST_Color_g, E.Octo_Globals.CREST_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local currencyID = 2916
				local color = E.Octo_Globals.WOW_Epic_Color
				vivodLeft = E.Octo_Func.func_currencyicon(currencyID)..color..E.Octo_Func.func_currencyName_NOCOLOR(currencyID).."|r"
				local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
				if data then
					local maxQuantity = data.maxQuantity
					local totalEarned = data.totalEarned
					if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
						tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
					else
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
					end
					if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
					end
				end
				BG:SetColorTexture(E.Octo_Globals.CREST_Color_r, E.Octo_Globals.CREST_Color_g, E.Octo_Globals.CREST_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local currencyID = 2915
				local color = E.Octo_Globals.WOW_Rare_Color
				vivodLeft = E.Octo_Func.func_currencyicon(currencyID)..color..E.Octo_Func.func_currencyName_NOCOLOR(currencyID).."|r"
				local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
				if data then
					local maxQuantity = data.maxQuantity
					local totalEarned = data.totalEarned
					if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
						tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
					else
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
					end
					if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
					end
				end
				BG:SetColorTexture(E.Octo_Globals.CREST_Color_r, E.Octo_Globals.CREST_Color_g, E.Octo_Globals.CREST_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	--
	if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local currencyID = 2914
				local color = E.Octo_Globals.WOW_Rare_Color
				vivodLeft = E.Octo_Func.func_currencyicon(currencyID)..color..E.Octo_Func.func_currencyName_NOCOLOR(currencyID).."|r"
				local data = C_CurrencyInfo.GetCurrencyInfo(currencyID)
				if data then
					local maxQuantity = data.maxQuantity
					local totalEarned = data.totalEarned
					if CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						tooltip[#tooltip+1] = {TOTAL, color..CharInfo.CurrencyID[currencyID].."|r"}
						tooltip[#tooltip+1] = {L["Season Maximum"], color..CharInfo.CurrencyID_totalEarned[currencyID].."/"..maxQuantity.."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID].."|r"}
					else
						tooltip[#tooltip+1] = {L["Can Earned"], color..maxQuantity.."|r"}
					end
					if CharInfo.CurrencyID[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] and CharInfo.CurrencyID_totalEarned[currencyID] ~= 0 then
						vivodCent = CharInfo.CurrencyID[currencyID]..E.Octo_Globals.LightGray_Color.." (+"..maxQuantity-CharInfo.CurrencyID_totalEarned[currencyID]..")|r"
					end
				end
				BG:SetColorTexture(E.Octo_Globals.CREST_Color_r, E.Octo_Globals.CREST_Color_g, E.Octo_Globals.CREST_Color_b, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	-- ТАЙМВОЛКИ
	if Octo_ToDo_DB_Vars.config.Timewalk == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(1166)..DUNGEONS
				if CharInfo.Octopussy_Timewalk_Dungeons_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Timewalk_Dungeons_Weekly
				end
				BG:SetColorTexture(70/255, 130/255, 179/255, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(1166).."500 "..E.Octo_Func.func_currencyName(1166)
				if CharInfo.Octopussy_Timewalk_500Currency_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Timewalk_500Currency_Weekly
				end
				BG:SetColorTexture(70/255, 130/255, 179/255, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(1166)..RAIDS
				if CharInfo.Octopussy_Timewalk_Raid_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Timewalk_Raid_Weekly
				end
				BG:SetColorTexture(70/255, 130/255, 179/255, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(1166)..E.Octo_Func.func_questName(57300)
				if CharInfo.Octopussy_Timewalk_SoldierofTime_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Timewalk_SoldierofTime_Weekly
				end
				BG:SetColorTexture(70/255, 130/255, 179/255, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(1166)..E.Octo_Func.func_questName(43323)
				if CharInfo.Octopussy_Timewalk_ATimetoReflect_Weekly ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Timewalk_ATimetoReflect_Weekly
				end
				BG:SetColorTexture(70/255, 130/255, 179/255, E.Octo_Globals.BGALPHA)
				return vivodCent, vivodLeft
		end)
	end
	-- ПОДЗЕМЕЛЬЯ
	-- for dungeonID, v in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
	-- 	if Octo_ToDo_DB_Other.LFGInstance[dungeonID] then
	-- 		tinsert(OctoTable_func_otrisovka_FIRST,
	-- 			function(CharInfo, tooltip, CL, BG)
	-- 				local vivodCent, vivodLeft = "", ""
	-- 				vivodLeft = CharInfo.LFGInstance[dungeonID].D_name
	-- 				if CharInfo.LFGInstance[dungeonID].donetoday ~= E.Octo_Globals.NONE then
	-- 					vivodCent = CharInfo.LFGInstance[dungeonID].donetoday
	-- 				end
	-- 				BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
	-- 				return vivodCent, vivodLeft
	-- 		end)
	-- 	end
	-- end
	if Octo_ToDo_DB_Vars.config.Dungeons == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local ServerTime = GetServerTime()
				for instanceID, v in pairs(CharInfo.journalInstance) do
					if v then
						for difficultyID, w in pairs (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(w.instanceReset-ServerTime).."|r", w.vivod}
							end
						end
					end
				end
				for dungeonID, v in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
					if Octo_ToDo_DB_Other.LFGInstance[dungeonID] then
						if CharInfo.LFGInstance[dungeonID].donetoday ~= E.Octo_Globals.NONE then
							tooltip[#tooltip+1] = {CharInfo.LFGInstance[dungeonID].D_name, CharInfo.LFGInstance[dungeonID].donetoday}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..DUNGEONS.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = DUNGEONS
				return vivodCent, vivodLeft
		end)
	end
	-- ВАЛЮТА
	if Octo_ToDo_DB_Vars.config.Currency == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local list = {}
				for CurrencyID, v in pairs(Octo_ToDo_DB_Config.CurrencyDB) do
					tinsert(list, CurrencyID)
				end
				sort(list, E.Octo_Func.reverse_order)
				for k, CurrencyID in pairs(list) do
					if Octo_ToDo_DB_Config.CurrencyDB[CurrencyID] == true and CharInfo.CurrencyID[CurrencyID] ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(CurrencyID)..E.Octo_Func.func_currencyName(CurrencyID)..E.Octo_Globals.Gray_Color.." id:"..CurrencyID.."|r", CharInfo.CurrencyID_Total[CurrencyID]}
						-- else
						--     tooltip[#tooltip+1] = {E.Octo_Globals.Gray_Color..E.Octo_Func.func_currencyicon(CurrencyID)..E.Octo_Func.func_currencyName_NOCOLOR(CurrencyID).."|r", E.Octo_Globals.Gray_Color..CharInfo.CurrencyID_Total[CurrencyID].."|r"}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..CURRENCY.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = CURRENCY
				return vivodCent, vivodLeft
		end)
	end
	-- РЕПУТАЦИЯ
	if Octo_ToDo_DB_Vars.config.Reputations == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Globals.Gray_Color..REPUTATION.."|r"
				for _, questID in pairs(E.Octo_Table.OctoTable_QuestID_Paragon) do
					if CharInfo.OctoTable_QuestID[questID] ~= (E.Octo_Globals.NONE or E.Octo_Globals.DONE) then
						tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Paragon"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_questName(questID), CharInfo.OctoTable_QuestID[questID]}
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
							vivodCent = E.Octo_Func.func_Gradient(L["Paragon"], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
						end
					end
				end
				local list = {}
				for reputationID, v in pairs(Octo_ToDo_DB_Config.ReputationDB) do
					tinsert(list, reputationID)
				end
				sort(list, E.Octo_Func.reverse_order)
				local j = 1
				for i, reputationID in ipairs(list) do
					if Octo_ToDo_DB_Config.ReputationDB[reputationID] == true and CharInfo.reputationID[reputationID] ~= 0 and CharInfo.reputationID[reputationID] ~= "" and E.Octo_Func.func_reputationName(reputationID) ~= "no name" then
						local color = j%2 == 0 and "|cffBBBBBB" or E.Octo_Globals.White_Color
						tooltip[#tooltip+1] = {color..E.Octo_Func.func_reputationName(reputationID).."|r"..E.Octo_Globals.Gray_Color.." id:"..(reputationID).."|r", CharInfo.reputationID[reputationID]}
						j = j + 1
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..REPUTATION.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = REPUTATION
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.Items == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local list = {}
				for itemID, v in pairs(Octo_ToDo_DB_Config.ItemDB) do
					tinsert(list, itemID)
				end
				sort(list, E.Octo_Func.reverse_order)
				for _, id in pairs(E.Octo_Table.OctoTable_itemID_Config) do
					for k, itemID in pairs(list) do
						if id == itemID then
							if Octo_ToDo_DB_Config.ItemDB[itemID] == true and CharInfo.ItemsInBag[itemID] ~= 0 and CharInfo.ItemsInBag[itemID] ~= "" then
								tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(itemID)..E.Octo_Func.func_itemName(itemID), CharInfo.ItemsInBag[itemID]}
								-- else
								--     tooltip[#tooltip+1] = {E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemTexture(itemID)..E.Octo_Func.func_itemName_NOCOLOR (itemID).."|r", E.Octo_Globals.Gray_Color.. CharInfo.ItemsInBag[itemID] .."|r"}
							end
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..ITEMS.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = ITEMS
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.Professions == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(E.Octo_Func.func_texturefromIcon(CharInfo.professions[k].icon))..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
						if CharInfo.professions[k].icon then
							vivodCent = vivodCent..E.Octo_Func.func_texturefromIcon(CharInfo.professions[k].icon).."|r".." "
						end
					end
				end
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine_Other) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(E.Octo_Func.func_texturefromIcon(CharInfo.professions[k].icon))..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.Gold == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Money then
					vivodCent = E.Octo_Func.CompactNumberFormat(CharInfo.Money/10000)..Money_Icon
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Octo_Globals.Red_Color..E.Octo_Func.CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..Money_Icon}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Octo_Globals.Green_Color..E.Octo_Func.CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..Money_Icon}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.ItemLevel == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Item Level"
				local color = E.Octo_Globals.Red_Color
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					if CharInfo.avgItemLevelEquipped >= ItemLevelGreen then
						color = E.Octo_Globals.Green_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelOrange then
						color = E.Octo_Globals.Yellow_Color
					elseif CharInfo.avgItemLevelEquipped >= ItemLevelRed then
						color = E.Octo_Globals.Orange_Color
					end
				end
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					vivodCent = color..CharInfo.avgItemLevelEquipped
					if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
						vivodCent = vivodCent.."/"..CharInfo.avgItemLevel.."|r"
					end
					if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
						vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
						tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDo_DB_Vars.config.LastUpdate == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local color = "|cffFFFFFF"
				vivodLeft = "Last Update"
				if CharInfo.loginHour ~= 0 and CharInfo.loginDay ~= 0 then
					if CharInfo.needResetWeekly == true then
						color = E.Octo_Globals.Gray_Color
					elseif CharInfo.needResetDaily == true then
						color = E.Octo_Globals.Red_Color
					end
					vivodCent = color..CharInfo.loginDay.."|r"
					tooltip[#tooltip+1] = {L["Was online"].."|r", " "}
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"Время:".."|r", color..CharInfo.loginHour.."|r"}
					tooltip[#tooltip+1] = {"Дата:".."|r", color..CharInfo.loginDay.."|r"}
				end
				return vivodCent, vivodLeft
		end)
	end
end

local function TotalMoneyCurServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TotalMoneyCurServerOnShow".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local TotalMoneyCurServer = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then
			TotalMoneyCurServer = TotalMoneyCurServer + CharInfo.Money
		end
	end
	return classColorHexCurrent..E.Octo_Func.CompactNumberFormat(TotalMoneyCurServer/10000).."|r"..Money_Icon
end

local function TotalMoneyAllServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TotalMoneyAllServerOnShow".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local TotalMoneyAllServer = 0
	local vivod = ""
	local AccountMoney = Octo_ToDo_DB_Other.AccountMoney or 0
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
		TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
	end
	if AccountMoney <= 9999 then
		vivod = classColorHexCurrent..E.Octo_Func.CompactNumberFormat((TotalMoneyAllServer)/10000).."|r"..Money_Icon
	else
		vivod = classColorHexCurrent..E.Octo_Func.CompactNumberFormat((TotalMoneyAllServer+AccountMoney)/10000).."|r"..Money_Icon..E.Octo_Globals.LightGray_Color.." "..ACCOUNT_BANK_PANEL_TITLE.." (".. E.Octo_Func.CompactNumberFormat(AccountMoney/10000) .. ")".."|r"
	end -- REPUTATION_SORT_TYPE_ACCOUNT
	return vivod
end

local function Token_PriceOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Token_PriceOnShow".."|r")
	end
	local vivod = ""
	local TokenPrice = C_WowTokenPublic.GetCurrentMarketPrice()
	if TokenPrice == nil then
		C_WowTokenPublic.UpdateMarketPrice()
	else
		vivod = TOKEN_FILTER_LABEL..": "..classColorHexCurrent..E.Octo_Func.CompactNumberFormat(TokenPrice/10000).."|r"..Money_Icon
	end
	return vivod
end

local function TotalTimeAllServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TotalTimeAllServerOnShow".."|r")
	end
	local TotalTimeAllServer = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
		TotalTimeAllServer = TotalTimeAllServer + CharInfo.realTotalTime
	end
	return classColorHexCurrent..(E.Octo_Func.SecondsToClock(TotalTimeAllServer)).."|r"
end

local function TotalTimeAllServer80OnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."TotalTimeAllServer80OnShow".."|r")
	end
	local TotalTimeAllServer70 = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
		if CharInfo.UnitLevel == E.Octo_Globals.currentMaxLevel then
			TotalTimeAllServer70 = TotalTimeAllServer70 + CharInfo.realLevelTime
		end
	end
	if TotalTimeAllServer70 ~= 0 then
		return classColorHexCurrent..(E.Octo_Func.SecondsToClock(TotalTimeAllServer70)).."|r"
	else
		return ""
	end
end

local function Octo_ToDo_FIRST_CreateAltFrame()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Octo_ToDo_FIRST_CreateAltFrame".."|r")
	end
	if not OctoToDo_MainFrame then
		OctoToDo_MainFrame = CreateFrame("BUTTON", "OctoToDo_MainFramePIZDA", UIParent, "BackdropTemplate")
		OctoToDo_MainFrame:Hide()
		Octo_ToDo_DB_Vars.config.FrameScale = Octo_ToDo_DB_Vars.config.FrameScale or 1
		OctoToDo_MainFrame:SetScale(Octo_ToDo_DB_Vars.config.FrameScale)
		local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame)
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
		end)
		OctoToDo_MainFrame.scrollChild = scrollChild
		OctoToDo_MainFrame.ScrollBar = ScrollBar
	end
	OctoToDo_MainFrame:SetClampedToScreen(false)
	OctoToDo_MainFrame:SetFrameStrata("HIGH")
	OctoToDo_MainFrame:SetPoint("CENTER")
	OctoToDo_MainFrame:SetBackdrop({
			bgFile = bgFile,
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	OctoToDo_MainFrame:SetBackdropColor(E.Octo_Globals.bgCr, E.Octo_Globals.bgCg, E.Octo_Globals.bgCb, E.Octo_Globals.bgCa)
	OctoToDo_MainFrame:SetBackdropBorderColor(0, 0, 0, 1)
	OctoToDo_MainFrame:SetScript("OnShow", function()
			Octo_ToDo_FIRST_AddDataToAltFrame()
	end)
	OctoToDo_MainFrame:EnableMouse(true)
	OctoToDo_MainFrame:SetMovable(true)
	OctoToDo_MainFrame:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame:SetScript("OnDragStart", OctoToDo_MainFrame.StartMoving)
	OctoToDo_MainFrame:SetScript("OnDragStop", function() OctoToDo_MainFrame:StopMovingOrSizing() end)
	OctoToDo_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_MainFrame:SetHeight(50)
	if Octo_ToDo_DB_Vars.config.ShowTotalMoney then
		if not Octo_Frame_TotalMoneyCurServer then
			Octo_Frame_TotalMoneyCurServer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
			Octo_Frame_TotalMoneyCurServer:SetSize(400, E.Octo_Globals.curHeight)
			Octo_Frame_TotalMoneyCurServer:EnableMouse(false)
			Octo_Frame_TotalMoneyCurServer:SetPoint("TOPLEFT", OctoToDo_MainFrame, "BOTTOMLEFT", 4, -2)
			Octo_Frame_TotalMoneyCurServer:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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
					text:SetText(E.Octo_Func.func_CurServerShort(curServer)..": "..TotalMoneyCurServerOnShow())
			end)
		end
		if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
			if not Octo_Frame_TotalMoneyAllServer then
				Octo_Frame_TotalMoneyAllServer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
				Octo_Frame_TotalMoneyAllServer:SetSize(400, E.Octo_Globals.curHeight)
				Octo_Frame_TotalMoneyAllServer:EnableMouse(false)
				Octo_Frame_TotalMoneyAllServer:SetPoint("TOPLEFT", OctoToDo_MainFrame, "BOTTOMLEFT", 4, -22)
				Octo_Frame_TotalMoneyAllServer:SetBackdrop({
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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
				end)
			end
		end
		if not Octo_Frame_Token_Price then
			Octo_Frame_Token_Price = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
			Octo_Frame_Token_Price:SetSize(400, E.Octo_Globals.curHeight)
			Octo_Frame_Token_Price:EnableMouse(false)
			if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
				Octo_Frame_Token_Price:SetPoint("TOPLEFT", OctoToDo_MainFrame, "BOTTOMLEFT", 4, -44)
			else
				Octo_Frame_Token_Price:SetPoint("TOPLEFT", OctoToDo_MainFrame, "BOTTOMLEFT", 4, -22)
			end
			Octo_Frame_Token_Price:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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
					end)
			end)
		end
	end
	if Octo_ToDo_DB_Vars.config.ShowTimeAll == true then
		if not Octo_Frame_TotalTimeAllServer then
			Octo_Frame_TotalTimeAllServer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
			Octo_Frame_TotalTimeAllServer:SetSize(400, E.Octo_Globals.curHeight)
			Octo_Frame_TotalTimeAllServer:EnableMouse(false)
			Octo_Frame_TotalTimeAllServer:SetPoint("TOPRIGHT", OctoToDo_MainFrame, "BOTTOMRIGHT", -4, -2)
			Octo_Frame_TotalTimeAllServer:SetBackdrop({
					edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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
			end)
		end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == true then
			if not Octo_Frame_TotalTimeAllServerMAXLEVEL then
				Octo_Frame_TotalTimeAllServerMAXLEVEL = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetSize(400, E.Octo_Globals.curHeight)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:EnableMouse(false)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetPoint("TOPRIGHT", OctoToDo_MainFrame, "BOTTOMRIGHT", -4, -22)
				Octo_Frame_TotalTimeAllServerMAXLEVEL:SetBackdrop({
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
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
				end)
			end
		end
	end
	----------------------------------------------------------------
	if not OctoToDo_CloseButton then
		OctoToDo_CloseButton = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
		OctoToDo_CloseButton:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoToDo_CloseButton:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*0, 1)
		OctoToDo_CloseButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_CloseButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				GameTooltip:AddLine(classColorHexCurrent..CLOSE.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_CloseButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_CloseButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_CloseButton:SetScript("OnClick", function()
				OctoToDo_MainFrame:Hide()
		end)
		local t = OctoToDo_CloseButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_CloseButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		t:SetAllPoints(OctoToDo_CloseButton)
		OctoToDo_CloseButton:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
		end)
	end
	----------------------------------------------------------------
	if not OctoToDo_OptionsButton then
		OctoToDo_OptionsButton = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
		OctoToDo_OptionsButton:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoToDo_OptionsButton:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*1, 1)
		OctoToDo_OptionsButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_OptionsButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:AddLine(classColorHexCurrent..OPTIONS.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_OptionsButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:Hide()
		end)
		OctoToDo_OptionsButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_OptionsButton:SetScript("OnClick", function()
				if OctoToDo_MainFramePIZDA and OctoToDo_MainFramePIZDA:IsShown() then
					OctoToDo_MainFramePIZDA:Hide()
				end
				if SettingsPanel:IsVisible() and self:IsVisible() then
					HideUIPanel(SettingsPanel)
				else
					Settings.OpenToCategory(AddonTitle, true)
				end
		end)
		local t = OctoToDo_OptionsButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_OptionsButton.icon = t
		t:SetTexture(E.Octo_Globals.AddonTexture_FIRST)
		t:SetAllPoints(OctoToDo_OptionsButton)
	end
	----------------------------------------------------------------

	local function AbandonQuests()
		local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
		local numQuests = E.Octo_Func.CurrentNumQuests()
		for i = 1, numShownEntries do
			if numQuests ~= 0 then
				local info = C_QuestLog.GetInfo(i)
				if info then
						if (not info.isHeader and not info.isHidden) then
							ChatFrame1:AddMessage(E.Octo_Func.func_Gradient(L["Abandon: "], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..E.Octo_Func.func_questName(info.questID))
							C_QuestLog.SetSelectedQuest(info.questID)
							C_QuestLog.SetAbandonQuest()
							C_QuestLog.AbandonQuest()
						end
				end
			end
		end
		ChatFrame1:AddMessage(E.Octo_Func.func_Gradient(L["Total"], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).." "..E.Octo_Globals.Green_Color..numQuests.."|r")
	end
	if not OctoToDo_AbandonButton then
		local numQuests = E.Octo_Func.CurrentNumQuests()
		StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
			text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n"..classColorHexCurrent.."Отменить все задания?|r",
			button1 = YES,
			button2 = NO,
			hideOnEscape = 1,
			whileDead = 1,
			OnAccept = function()
				C_Timer.After(1, AbandonQuests)
			end,
		}
		OctoToDo_AbandonButton = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
		OctoToDo_AbandonButton:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoToDo_AbandonButton:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*2, 1)
		OctoToDo_AbandonButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_AbandonButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_AbandonButton:SetScript("OnEnter", function(self)
				numQuests = E.Octo_Func.CurrentNumQuests()
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				if numQuests > 0 then
					GameTooltip:AddLine(classColorHexCurrent..L["Abandon All Quests"].."|r".." ("..E.Octo_Func.CurrentNumQuests()..")")
					GameTooltip:AddLine(" ")
				end
				if numQuests == 0 then
					GameTooltip:AddLine(L["No quests"], r, g, b)
				end
				local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
				local list = {}
				for i = 1, numShownEntries do
					if numQuests ~= 0 then
						local info = C_QuestLog.GetInfo(i) -- questLogIndex
						if info then
							if info.questID ~= 0 then
								if (not info.isHeader and not info.isHidden) then
									-- print (info.questID, E.Octo_Globals.Green_Color..E.Octo_Func.func_questName(info.questID).."|r")
									tinsert(list, info.questID)
								else
									-- print (info.questID, E.Octo_Globals.Red_Color..E.Octo_Func.func_questName(info.questID).."|r")
								end
							end
						end
					end
				end
				sort(list, E.Octo_Func.reverse_order)
				for k, questID in pairs(list) do
					GameTooltip:AddDoubleLine(E.Octo_Func.func_questName(questID)..E.Octo_Globals.Gray_Color.." id:"..questID.."|r",E.Octo_Func.CheckCompletedByQuestID(questID) , 1, 1, 1, 1, 1, 1)
				end
				GameTooltip:Show()
		end)
		OctoToDo_AbandonButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_AbandonButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_AbandonButton:SetScript("OnClick", function()
				if numQuests > 0 then
					StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
				end
		end)
		local t = OctoToDo_AbandonButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_AbandonButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow72.tga")
		t:SetAllPoints(OctoToDo_AbandonButton)
	end
	----------------------------------------------------------------
	if not OctoToDo_MplusButton then
		OctoToDo_MplusButton = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
		OctoToDo_MplusButton:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoToDo_MplusButton:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*3, 1)
		OctoToDo_MplusButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_MplusButton:SetBackdropBorderColor(r, g, b, 0)
		OctoToDo_MplusButton:SetScript("OnEnter", function(self)
				local i = 0
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(" ", " ")
				local list = {}
				for dungeonID, v in pairs(Octo_ToDo_DB_mapChallengeModeID) do
					tinsert(list, dungeonID)
				end
				sort(list, E.Octo_Func.reverse_order)
				for count, dungeonID in pairs(list) do
					local name, _, timeLimit, texture = C_ChallengeMode.GetMapUIInfo(dungeonID)
						i = i + 1
						GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(texture) .. name.." "..E.Octo_Globals.Gray_Color.." id:"..dungeonID.."|r",  E.Octo_Globals.Gray_Color.."texture:|r"..E.Octo_Globals.Green_Color..texture.."|r "..E.Octo_Globals.Gray_Color.."time:|r"..E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(timeLimit).."|r", 1, 1, 1, 1, 1, 1)
				end
				if i == 0 then
					GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
					OctoToDo_MplusButton:Hide()
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoToDo_MplusButton:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(r, g, b, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_MplusButton:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(r, g, b, .5)
		end)
		OctoToDo_MplusButton:SetScript("OnClick", function()
				-- OctoToDo_MainFrame:Hide()
					fpde(Octo_ToDo_DB_mapChallengeModeID)
		end)
		local t = OctoToDo_MplusButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_MplusButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
		t:SetAllPoints(OctoToDo_MplusButton)
	end
	----------------------------------------------------------------
	if not OctoToDo_ItemsButton then
		OctoToDo_ItemsButton = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "BackDropTemplate")
		OctoToDo_ItemsButton:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		OctoToDo_ItemsButton:SetPoint("BOTTOMRIGHT", OctoToDo_MainFrame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*4, 1)
		OctoToDo_ItemsButton:SetBackdrop({
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		OctoToDo_ItemsButton:SetBackdropBorderColor(r, g, b, 0)
		OctoToDo_ItemsButton:SetScript("OnEnter", function(self)
				local i = 0
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(" ", " ")
				for _, itemID in pairs (E.Octo_Table.OctoTable_itemID_Config) do
					for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
						if CharInfo.ItemsInBag[itemID] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(itemID)..E.Octo_Func.func_itemName(itemID), CharInfo.ItemsInBag[itemID].."  "..CharInfo.classColorHex..CharInfo.Name.."|r")
						end
					end
				end
				if i == 0 then
					GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
					-- OctoToDo_ItemsButton:Hide()
				end
				GameTooltip:AddDoubleLine(" ", " ")
				GameTooltip:Show()
		end)
		OctoToDo_ItemsButton:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(r, g, b, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_ItemsButton:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(r, g, b, .5)
		end)
		OctoToDo_ItemsButton:SetScript("OnClick", function()
				-- OctoToDo_MainFrame:Hide()
				local curGUID = UnitGUID("PLAYER")
				for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
					if curCharGUID == curGUID then
						fpde(CharInfo)
					end
				end
		end)
		local t = OctoToDo_ItemsButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_ItemsButton.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow21.tga")
		t:SetAllPoints(OctoToDo_ItemsButton)
	end
	----------------------------------------------------------------
	if not dd_FIRST then
		local dd_FIRST = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), OctoToDo_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
		local multiply = (1/3)*2
		dd_FIRST:SetSize(E.Octo_Globals.curWidthTitle*multiply, E.Octo_Globals.curHeight*multiply)
		dd_FIRST:SetBackdrop({
				bgFile = bgFile,
				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
				edgeSize = 1
		})
		dd_FIRST:SetBackdropColor(E.Octo_Globals.bgCr, E.Octo_Globals.bgCg, E.Octo_Globals.bgCb, E.Octo_Globals.bgCa)
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
		dd_FIRST:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame, "TOPLEFT", 0, 1)
		dd_FIRST:ddSetDisplayMode(GlobalAddonName)
		dd_FIRST:ddSetOpenMenuUp(true)
		dd_FIRST:ddSetNoGlobalMouseEvent(true)
		dd_FIRST:ddHideWhenButtonHidden()
		dd_FIRST:RegisterForClicks("LeftButtonUp")
		dd_FIRST:SetScript("OnClick", function(self)
				self:ddToggle(1, nil, self, self:GetWidth()+1, -self:GetHeight())
		end)

		local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
			Octo_ToDo_DB_Players[menuButton.value].isShownPLAYER = checked
		end

		local function func_remove_GUID(menuButton)
			Octo_ToDoDeleteChar(menuButton.value)
			Octo_ToDo_DB_Players[menuButton.value] = nil
		end
		dd_FIRST:ddSetInitFunc(function(self, level, value)
				local info = {}
				Octo_ToDo_DB_Players_LIST = Octo_ToDo_DB_Players_LIST or {}
				if level == 1 then
					Octo_ToDo_DB_Players_LIST = {}
					for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
						Octo_ToDo_DB_Players_LIST[CharInfo.curServer] = Octo_ToDo_DB_Players_LIST[CharInfo.curServer] or {}
						Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] = Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] or {}
						Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] = CharInfo.classColorHex..CharInfo.Name.."|r".." "..CharInfo.UnitLevel
					end
					for Server, v in pairs(Octo_ToDo_DB_Players_LIST) do
						info.fontObject = OctoFont11
						info.hasArrow = Server
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Server
						if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == true then
							if Server ~= GetRealmName() then
								vivod = E.Octo_Globals.Gray_Color..vivod.."|r"
							end
						end
						info.text = vivod
						info.value = v
						self:ddAddButton(info, level)
					end
					self:ddAddSeparator(level)
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current Realm"]
					info.hasArrow = nil
					info.checked = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm = checked
					end
					self:ddAddButton(info, level)
				elseif level == 2 then
					local players_list = {}
					for GUID, names in pairs(value) do
						tinsert(players_list, GUID)
					end
					sort(players_list, function(a, b)
							local infoA = Octo_ToDo_DB_Players[a]
							local infoB = Octo_ToDo_DB_Players[b]
							if infoA and infoB then
								return
								infoA.curServer > infoB.curServer or
								infoA.curServer == infoB.curServer and infoA.UnitLevel > infoB.UnitLevel or
								infoA.UnitLevel == infoB.UnitLevel and infoA.avgItemLevel > infoB.avgItemLevel or
								infoA.avgItemLevel == infoB.avgItemLevel and infoB.Name > infoA.Name
							end
					end)
					for _, GUID in ipairs(players_list) do
						info.keepShownOnClick = true
						info.isNotRadio = true
						local vivod = Octo_ToDo_DB_Players[GUID].classColorHex..Octo_ToDo_DB_Players[GUID].Name.."|r"
						if Octo_ToDo_DB_Players[GUID].UnitLevel ~= 70 then
							vivod = vivod.." "..Octo_ToDo_DB_Players[GUID].UnitLevel
						end
						info.text = vivod
						info.value = GUID
						info.func = selectFunctionisShownPLAYER
						info.checked = Octo_ToDo_DB_Players[GUID].isShownPLAYER
						info.remove = func_remove_GUID
						self:ddAddButton(info, level)
					end
				end
		end)
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
-- https://wowhead.com/ru/item=187896
-- https://wowhead.com/ru/item=187897
-- https://wowhead.com/ru/item=187869
-- https://wowhead.com/ru/item=187895
-- https://wowhead.com/ru/item=187899
-- https://wowhead.com/ru/item=187900
-- https://wowhead.com/ru/item=187898
-- https://wowhead.com/ru/item=187875
-- https://wowhead.com/ru/item=150746 -- ally east
-- https://wowhead.com/ru/item=150743 -- ally surv
-- https://wowhead.com/ru/item=150745 -- Horde
-- https://wowhead.com/ru/item=150744 -- Horde
		if UnitLevel < 20 then
			CreateFrameUsableItems(187875, 237385, Xpos*-11+Ypos*1, Ypos*-11, 0, .43, .86)
			CreateFrameUsableItems(187896, 237382, Xpos*-10+Ypos*1, Ypos*-10, 0, .43, .86)
			CreateFrameUsableItems(187897, 237388, Xpos*-9+Ypos*1, Ypos*-9, 0, .43, .86)
			CreateFrameUsableItems(187869, 237383, Xpos*-8+Ypos*1, Ypos*-8, 0, .43, .86)
			CreateFrameUsableItems(187895, 237384, Xpos*-7+Ypos*1, Ypos*-7, 0, .43, .86)
			CreateFrameUsableItems(187899, 237386, Xpos*-6+Ypos*1, Ypos*-6, 0, .43, .86)
			CreateFrameUsableItems(187900, 1064187, Xpos*-5+Ypos*1, Ypos*-5, 0, .43, .86)
			CreateFrameUsableItems(187898, 237387, Xpos*-4+Ypos*1, Ypos*-4, 0, .43, .86)
			if Faction == "Horde" then
				CreateFrameUsableItems(150745, 237388, Xpos*-3+Ypos*1, Ypos*-3, 0, .43, .86) -- Horde East
			else
				CreateFrameUsableItems(150746, 237388, Xpos*-3+Ypos*1, Ypos*-3, 0, .43, .86) -- ally East
			end
			if Faction == "Horde" then
				CreateFrameUsableItems(150744, 237388, Xpos*-2+Ypos*1, Ypos*-2, 0, .43, .86) -- Horde Kalimd
			else
				CreateFrameUsableItems(150743, 237388, Xpos*-2+Ypos*1, Ypos*-2, 0, .43, .86) -- ally Kalimd
			end
			CreateFrameUsableSpells(431280, C_Spell.GetSpellInfo(431280).iconID, Xpos*-1+Ypos*1, Ypos*-1, 0, .43, .86)
		end
		if prof1 == 202 or prof2 == 202 then
			CreateFrameUsableItems(198156, 4548860, Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 366254)
			CreateFrameUsableItems(172924, 3610528, Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 310542)
			if Faction == "Horde" then
				CreateFrameUsableItems(168808, 2000840, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 265807)
				CreateFrameUsableItems(168807, 2000841, Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 265807)
			else
				CreateFrameUsableItems(168808, 2000840, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 264492)
				CreateFrameUsableItems(168807, 2000841, Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 264492)
			end
			CreateFrameUsableItems(151652, 237560, Xpos*4+Ypos*1, Ypos*5, 0, .43, .86, 264490)
			CreateFrameUsableItems(112059, 892831, Xpos*5+Ypos*1, Ypos*6, 0, .43, .86, 264487)
			CreateFrameUsableItems(87215, 651094, Xpos*6+Ypos*1, Ypos*7, 0, .43, .86, 264485)
			CreateFrameUsableItems(48933, 135778, Xpos*7+Ypos*1, Ypos*8, 0, .43, .86, 264481)
			CreateFrameUsableItems(110560, 1041860, Xpos*8+Ypos*1, Ypos*9, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, 134414, Xpos*9+Ypos*1, Ypos*10, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, 1444943, Xpos*10+Ypos*1, Ypos*11, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, C_Spell.GetSpellInfo(193753).iconID, Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, C_Spell.GetSpellInfo(50977).iconID, Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, C_Spell.GetSpellInfo(556).iconID, Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, C_Spell.GetSpellInfo(126892).iconID, Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, C_Spell.GetSpellInfo(265225).iconID, Xpos*12+Ypos*1, Ypos*13, 0, .43, .86)
			end
		else
			CreateFrameUsableItems(110560, 1041860, Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, 134414, Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, 1444943, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, C_Spell.GetSpellInfo(193753).iconID, Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, C_Spell.GetSpellInfo(50977).iconID, Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, C_Spell.GetSpellInfo(556).iconID, Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, C_Spell.GetSpellInfo(126892).iconID, Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, C_Spell.GetSpellInfo(265225).iconID, Xpos*4+Ypos*1, Ypos*5, 0, .43, .86)
			end
		end
		if UnitLevel >= 20 then
			if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == false then
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_MoP) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_WoD) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*3, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_Legion) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*4, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_BfA) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*5, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_SL) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*6, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_DF) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*7, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_DF_S3) do
					CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
				end
				if Faction == "Horde" then
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				end
				if classFilename == "MAGE" and Faction == "Horde" then
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*10, (Ypos*k), 0, .43, .86)
					end
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Horde) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
				end
				if classFilename == "MAGE" and Faction == "Alliance" then
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*10, (Ypos*k), 0, .43, .86)
					end
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
				end
			else
				if Faction == "Horde" then
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in pairs(E.Octo_Table.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, C_Spell.GetSpellInfo(v).iconID, Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
					end
				end
			end
		end
	end

	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, E.Octo_Globals.BGALPHA*2)
	end

	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 1, #OctoTable_func_otrisovka_FIRST do
		local fname, f
		fname = "FrameLine"..i
		OctoToDo_MainFrame[fname] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."FrameLine"..i, OctoToDo_MainFrame.scrollChild, "BackdropTemplate")
		f = OctoToDo_MainFrame[fname]
		f:SetHeight(E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_MainFrame.scrollChild, "TOPLEFT", 0, -E.Octo_Globals.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.Octo_Globals.curHeight)
		f.BG:SetAllPoints()
		fname = "TextLeft"..i
		OctoToDo_MainFrame[fname] = OctoToDo_MainFrame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = OctoToDo_MainFrame[fname]
		f:SetSize(E.Octo_Globals.curWidthTitle, E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", OctoToDo_MainFrame.scrollChild, "TOPLEFT", 6, -E.Octo_Globals.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDo_FIRST_AddDataToAltFrame()
	OctoToDo_MainFrame:Hide()
end
function Octo_ToDo_FIRST_AddDataToAltFrame()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Blue_Color.."Octo_ToDo_FIRST_AddDataToAltFrame".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.config.LevelToShowMAX
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	OctoToDo_MainFrame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in pairs(Octo_ToDo_DB_Players) do
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName()))
			and (CharInfo.isShownPLAYER == true)
			and (CharInfo.avgItemLevel >= itemLevelToShow)
			and (CharInfo.UnitLevel >= LevelToShow)
			and (CharInfo.UnitLevel <= LevelToShowMAX))
		or (ShowOnlyCurrentRealm == false
			and (CharInfo.isShownPLAYER == true)
			and (CharInfo.avgItemLevel >= itemLevelToShow)
			and (CharInfo.UnitLevel >= LevelToShow)
			and (CharInfo.UnitLevel <= LevelToShowMAX))
		or (curGUID == CharInfo.GUID) then
			sorted[#sorted+1] = CharInfo
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
	end)
	for i, CharInfo in pairs(sorted) do
		local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		local curCharGUID = CharInfo.GUID
		if not OctoToDo_MainFrame[curCharGUID] then
			OctoToDo_MainFrame[curCharGUID] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."OctoToDo_MainFrame[curCharGUID]", OctoToDo_MainFrame.scrollChild, "BackdropTemplate")
			Octo_ToDo_FIRST_Frame_Char_Frame = OctoToDo_MainFrame[curCharGUID]
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("BOTTOM", 0, 0)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG = Octo_ToDo_FIRST_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:Hide()
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetPoint("TOPLEFT", 0, -E.Octo_Globals.curHeight)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetColorTexture(r, g, b, 1)
			for i = 1, #OctoTable_func_otrisovka_FIRST do
				CharInfo.GUID = curCharGUID
				local CF = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, Octo_ToDo_FIRST_Frame_Char_Frame)
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i] = CF
				CF.index = i
				CF:SetSize(E.Octo_Globals.curWidthCentral, E.Octo_Globals.curHeight)
				CF:SetPoint("TOP", Octo_ToDo_FIRST_Frame_Char_Frame, "TOP", 0, -E.Octo_Globals.curHeight*(i-1))
				CF:SetScript("OnEnter", Central_Frame_Mouse_OnEnter)
				CF:SetScript("OnLeave", Central_Frame_Mouse_OnLeave)
				CF:SetMouseClickEnabled(false)
				local CL = CF:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				CL:SetAllPoints()
				CL:SetFontObject(OctoFont11)
				CL:SetJustifyV("MIDDLE")
				CL:SetJustifyH("CENTER")
				CL:SetTextColor(1, 1, 1, 1)
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i.."BG"] = Octo_ToDo_FIRST_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i.."BG"]:SetAllPoints(Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i])
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i.."BG"]:SetColorTexture(0, 0, 0, 0)
				CF.CL = CL
			end
		else
			Octo_ToDo_FIRST_Frame_Char_Frame = OctoToDo_MainFrame[curCharGUID]
		end
		Octo_ToDo_FIRST_Frame_Char_Frame:SetSize(E.Octo_Globals.curWidthCentral, E.Octo_Globals.curHeight)
		if #OctoToDo_MainFrame.AllCharFrames == 0 then
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
		else
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("TOPRIGHT", OctoToDo_MainFrame.AllCharFrames[#OctoToDo_MainFrame.AllCharFrames], "TOPLEFT", 0, 0)
		end
		OctoToDo_MainFrame.AllCharFrames[#OctoToDo_MainFrame.AllCharFrames + 1] = Octo_ToDo_FIRST_Frame_Char_Frame
		if curGUID == curCharGUID then
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:Show()
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetAlpha(E.Octo_Globals.BGALPHA*2)
		end
		for i = 1, #OctoTable_func_otrisovka_FIRST do
			local TEXTLEFT = OctoToDo_MainFrame["TextLeft"..i]
			local TEXTCENT = Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i]
			if TEXTLEFT and TEXTCENT then
				local BG = Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i.."BG"]
				TEXTCENT.tooltip = {}
				local vivodCent = " "
				local vivodLeft = " "
				vivodCent, vivodLeft = OctoTable_func_otrisovka_FIRST[i](CharInfo, TEXTCENT.tooltip, TEXTCENT.CL, BG)
				TEXTLEFT:SetText(vivodLeft or "leftText")
				TEXTCENT.CL:SetText(vivodCent or "centText")
				if #TEXTCENT.tooltip == 0 or #TEXTCENT.tooltip[1] == 0 then
					TEXTCENT.tooltip = nil
				end
			end
		end
	end
	local curAltFrameWidth = #OctoToDo_MainFrame.AllCharFrames * E.Octo_Globals.curWidthCentral/2
	local width = curAltFrameWidth*2+E.Octo_Globals.curWidthTitle
	local height = E.Octo_Globals.curHeight*(#OctoTable_func_otrisovka_FIRST)
	OctoToDo_MainFrame.scrollChild:SetSize(width, height)
	if height > E.Octo_Globals.Addon_Height then
		height = E.Octo_Globals.Addon_Height
		OctoToDo_MainFrame.ScrollBar:Show()
	else
		OctoToDo_MainFrame.ScrollBar:Hide()
	end
	OctoToDo_MainFrame:SetSize(width, height)
end

local function main_frame_toggle()
	local button = LibDBIcon:GetMinimapButton(GlobalAddonName.."Octo_ToDo_FIRST_Minimap")
	if not OctoToDo_MainFrame.promise then
		OctoToDo_MainFrame.promise = LibThingsLoad:Items(E.Octo_Table.OctoTable_Empty)
		OctoToDo_MainFrame.promise:AddItems(E.Octo_Table.OctoTable_itemID_ALL)
		OctoToDo_MainFrame.promise:AddItems(E.Octo_Table.OctoTable_itemID_Config)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_MoP)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_WoD)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Legion)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_BfA)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_SL)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DF)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DF_S3)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_TWW_S1_Horde)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_TWW_S1_Alliance)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Group_Horde)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DRUID)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_DEATHKNIGHT)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_SHAMAN)
		OctoToDo_MainFrame.promise:AddSpells(E.Octo_Table.OctoTable_Portals_MONK)
		OctoToDo_MainFrame.promise:AddQuests(E.Octo_Table.OctoTable_QuestID)
		OctoToDo_MainFrame.promise:AddQuests(E.Octo_Table.OctoTable_QuestID_Paragon)
	end
	if OctoToDo_MainFrame:IsShown() then
		OctoToDo_MainFrame:Hide()
	else
		button:Disable()
		OctoToDo_MainFrame.promise:Then(function()
				button:Enable()
				OctoToDo_MainFrame:Show()
				Collect_ALL_PlayerInfo()
				Collect_All_Currency()
				Collect_ALL_GreatVault()
				Collect_ALL_ItemLevel()
				Collect_ALL_ItemsInBag()
				Collect_ALL_Locations()
				Collect_ALL_LoginTime()
				Collect_ALL_Mail()
				Collect_ALL_MoneyUpdate()
				Collect_All_Professions()
				Collect_All_Quests()
				Collect_All_Reputations()
				Collect_ALL_UNIVERSALQuestUpdate()
				Collect_All_journalInstance()
				Collect_Player_Level()
				Collect_WarMode()
				Octo_ToDo_FIRST_AddDataToAltFrame()
				Hide_trash_frames()
		end)
	end
end
function Octo_ToDo_FIRST_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") and not InCombatLockdown() then
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_ToDo_DB_Other.CVar == nil then Octo_ToDo_DB_Other.CVar = {} end
		if Octo_ToDo_DB_Other.AccountMoney == nil then Octo_ToDo_DB_Other.AccountMoney = 0 end
		if Octo_ToDo_DB_Other.LFGInstance == nil then Octo_ToDo_DB_Other.LFGInstance = {} end
		if Octo_ToDo_DB_mapChallengeModeID == nil then Octo_ToDo_DB_mapChallengeModeID = {} end
		if Octo_ToDo_DB_Players_LIST == nil then Octo_ToDo_DB_Players_LIST = {} end
		if Octo_ToDo_Movies == nil then Octo_ToDo_Movies = {} end
		if Octo_ToDo_DB_Config == nil then Octo_ToDo_DB_Config = {} end
		if Octo_ToDo_DB_Config.CurrencyDB == nil then Octo_ToDo_DB_Config.CurrencyDB = {} end
		if Octo_ToDo_DB_Config.ReputationDB == nil then Octo_ToDo_DB_Config.ReputationDB = {} end
		if Octo_ToDo_DB_Config.ItemDB == nil then Octo_ToDo_DB_Config.ItemDB = {} end
		if Octo_ToDo_DB_Players == nil then Octo_ToDo_DB_Players = {} end
		if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
		if Octo_ToDo_DB_Vars.config == nil then Octo_ToDo_DB_Vars.config = {} end
		if Octo_ToDo_DB_Vars.config.CVar == nil then Octo_ToDo_DB_Vars.config.CVar = false end
		if Octo_ToDo_DB_Vars.config.Minecraft == nil then Octo_ToDo_DB_Vars.config.Minecraft = false end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm = true end
		if Octo_ToDo_DB_Vars.config.AutoSellGrey == nil then Octo_ToDo_DB_Vars.config.AutoSellGrey = true end
		if Octo_ToDo_DB_Vars.config.AutoRepair == nil then Octo_ToDo_DB_Vars.config.AutoRepair = true end
		if Octo_ToDo_DB_Vars.config.Auto_InputDelete == nil then Octo_ToDo_DB_Vars.config.Auto_InputDelete = true end
		if Octo_ToDo_DB_Vars.config.AutoOpen == nil then Octo_ToDo_DB_Vars.config.AutoOpen = true end
		if Octo_ToDo_DB_Vars.config.Auto_Gossip == nil then Octo_ToDo_DB_Vars.config.Auto_Gossip = true end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler = false end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip = false end
		if Octo_ToDo_DB_Vars.config.AutoTurnQuests == nil then Octo_ToDo_DB_Vars.config.AutoTurnQuests = true end
		if Octo_ToDo_DB_Vars.config.Auto_ChatClearing == nil then Octo_ToDo_DB_Vars.config.Auto_ChatClearing = false end
		if Octo_ToDo_DB_Vars.config.Hide_Boss_Banner == nil then Octo_ToDo_DB_Vars.config.Hide_Boss_Banner = true end
		if Octo_ToDo_DB_Vars.config.Hide_Covenant == nil then Octo_ToDo_DB_Vars.config.Hide_Covenant = true end
		if Octo_ToDo_DB_Vars.config.Hide_Error_Messages == nil then Octo_ToDo_DB_Vars.config.Hide_Error_Messages = true end
		if Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance == nil then Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance = true end
		if Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Zone_Text == nil then Octo_ToDo_DB_Vars.config.Hide_Zone_Text = true end
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition == nil then Octo_ToDo_DB_Vars.config.UIErrorsFramePosition = true end
		if Octo_ToDo_DB_Vars.config.Auto_Screenshot == nil then Octo_ToDo_DB_Vars.config.Auto_Screenshot = false end
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == nil then Octo_ToDo_DB_Vars.config.MP_MythicKeystone = true end
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.GildedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.RunedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.BeledarCycle == nil then Octo_ToDo_DB_Vars.config.BeledarCycle = false end
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly = true end
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == nil then Octo_ToDo_DB_Vars.config.MajorKeyflames = false end
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == nil then Octo_ToDo_DB_Vars.config.MinorKeyflames = false end
		if Octo_ToDo_DB_Vars.config.FrameScale == nil then Octo_ToDo_DB_Vars.config.FrameScale = 1 end
		if Octo_ToDo_DB_Vars.config.GameMenuFrameScale == nil then Octo_ToDo_DB_Vars.config.GameMenuFrameScale = .8 end
		if Octo_ToDo_DB_Vars.config.TimeRift == nil then Octo_ToDo_DB_Vars.config.TimeRift = false end
		if Octo_ToDo_DB_Vars.config.DilatedTimePod == nil then Octo_ToDo_DB_Vars.config.DilatedTimePod = false end
		if Octo_ToDo_DB_Vars.config.EncapsulatedDestiny == nil then Octo_ToDo_DB_Vars.config.EncapsulatedDestiny = false end
		if Octo_ToDo_DB_Vars.config.Dreamsurges == nil then Octo_ToDo_DB_Vars.config.Dreamsurges = false end
		if Octo_ToDo_DB_Vars.config.AntiqueBronzeBullion == nil then Octo_ToDo_DB_Vars.config.AntiqueBronzeBullion = false end
		if Octo_ToDo_DB_Vars.config.SparkofAwakening == nil then Octo_ToDo_DB_Vars.config.SparkofAwakening = false end
		if Octo_ToDo_DB_Vars.config.SplinteredSparkofAwakening == nil then Octo_ToDo_DB_Vars.config.SplinteredSparkofAwakening = false end
		if Octo_ToDo_DB_Vars.config.Dungeons == nil then Octo_ToDo_DB_Vars.config.Dungeons = true end
		if Octo_ToDo_DB_Vars.config.Timewalk == nil then Octo_ToDo_DB_Vars.config.Timewalk = false end
		if Octo_ToDo_DB_Vars.config.Currency == nil then Octo_ToDo_DB_Vars.config.Currency = true end
		if Octo_ToDo_DB_Vars.config.Reputations == nil then Octo_ToDo_DB_Vars.config.Reputations = true end
		if Octo_ToDo_DB_Vars.config.Items == nil then Octo_ToDo_DB_Vars.config.Items = true end
		if Octo_ToDo_DB_Vars.config.Professions == nil then Octo_ToDo_DB_Vars.config.Professions = true end
		if Octo_ToDo_DB_Vars.config.Gold == nil then Octo_ToDo_DB_Vars.config.Gold = true end
		if Octo_ToDo_DB_Vars.config.ItemLevel == nil then Octo_ToDo_DB_Vars.config.ItemLevel = true end
		if Octo_ToDo_DB_Vars.config.LastUpdate == nil then Octo_ToDo_DB_Vars.config.LastUpdate = false end
		if Octo_ToDo_DB_Vars.config.LevelToShow == nil then Octo_ToDo_DB_Vars.config.LevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.LevelToShowMAX == nil then Octo_ToDo_DB_Vars.config.LevelToShowMAX = 120 end
		if Octo_ToDo_DB_Vars.config.itemLevelToShow == nil then Octo_ToDo_DB_Vars.config.itemLevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.AchievementToShow == nil then Octo_ToDo_DB_Vars.config.AchievementToShow = 92 end
		if Octo_ToDo_DB_Vars.config.ShowTotalMoney == nil then Octo_ToDo_DB_Vars.config.ShowTotalMoney = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeAll == nil then Octo_ToDo_DB_Vars.config.ShowTimeAll = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == nil then Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL = true end
		if Octo_ToDo_DB_Vars.config.ResetAllChars == nil then Octo_ToDo_DB_Vars.config.ResetAllChars = false end
		if Octo_ToDo_DB_Vars.config.PortalsButtons == nil then Octo_ToDo_DB_Vars.config.PortalsButtons = true end
		if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == nil then Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent = true end
		if Octo_ToDo_DB_Vars.config.curHeight == nil then Octo_ToDo_DB_Vars.config.curHeight = 20 end
		if Octo_ToDo_DB_Vars.config.curHeight ~= nil then E.Octo_Globals.curHeight = Octo_ToDo_DB_Vars.config.curHeight end
		if Octo_ToDo_DB_Vars.config.Addon_Height == nil then Octo_ToDo_DB_Vars.config.Addon_Height = 600 end
		if Octo_ToDo_DB_Vars.config.Addon_Height ~= nil then E.Octo_Globals.Addon_Height = Octo_ToDo_DB_Vars.config.Addon_Height end
		if Octo_ToDo_DB_Vars.config.curWidthCentral == nil then Octo_ToDo_DB_Vars.config.curWidthCentral = 110 end
		if Octo_ToDo_DB_Vars.config.curWidthCentral ~= nil then E.Octo_Globals.curWidthCentral = Octo_ToDo_DB_Vars.config.curWidthCentral end
		if Octo_ToDo_DB_Vars.config.curWidthTitle == nil then Octo_ToDo_DB_Vars.config.curWidthTitle = 200 end
		if Octo_ToDo_DB_Vars.config.curWidthTitle ~= nil then E.Octo_Globals.curWidthTitle = Octo_ToDo_DB_Vars.config.curWidthTitle end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST = false end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST ~= nil then E.Octo_Globals.Octo_debug_Function_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST end
		if Octo_ToDo_DB_Vars.config.prefix == nil then Octo_ToDo_DB_Vars.config.prefix = 1 end
		ConcatAtStart()
		O_otrisovka_FIRST()
		for i, func in ipairs(E.Octo_Globals.modules) do
			func()
		end
		local MinimapName = GlobalAddonName.."Octo_ToDo_FIRST_Minimap"
		local ldb_icon = LibDataBroker:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = E.Octo_Globals.AddonTexture_FIRST,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							for i = 1, #E.Octo_Table.OctoTable_itemID_ALL do
								C_Item.RequestLoadItemDataByID(E.Octo_Table.OctoTable_itemID_ALL[i])
							end
							main_frame_toggle()
						end
					else
						if OctoToDo_MainFramePIZDA and OctoToDo_MainFramePIZDA:IsShown() then
							OctoToDo_MainFramePIZDA:Hide()
						end
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(AddonTitle, true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, E.Octo_Func.func_Gradient(GlobalAddonName, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_FIRST = Octo_ToDo_DB_Vars.minimap_FIRST or {}
		Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos = Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos or 244
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(AddonVersion)
		LibDBIcon:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_FIRST)
		LibDBIcon:Show(MinimapName)
	end
	if (event == "PLAYER_LOGIN") and not InCombatLockdown() then
		C_WowTokenPublic.UpdateMarketPrice()
		local curGUID = UnitGUID("PLAYER")
		Octo_ToDo_DB_Players[curGUID] = Octo_ToDo_DB_Players[curGUID] or {}
		for k, CharInfo in pairs(Octo_ToDo_DB_Players) do
			checkCharInfo(CharInfo)
		end
		Collect_ALL_PlayerInfo()
		Collect_All_Currency()
		Collect_ALL_GreatVault()
		Collect_ALL_ItemLevel()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_ALL_LoginTime()
		Collect_ALL_Mail()
		Collect_ALL_MoneyOnLogin()
		Collect_ALL_MoneyUpdate()
		Collect_All_Professions()
		Collect_All_Quests()
		Collect_All_Reputations()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_All_journalInstance()
		Collect_Player_Level()
		Collect_WarMode()
		RequestTimePlayed()
		Octo_ToDo_FIRST_CreateAltFrame()
		Octo_ToDo_FIRST_AddDataToAltFrame()
		Hide_trash_frames()
	end
	if (event == "SHOW_SUBSCRIPTION_INTERSTITIAL") then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Hide trash frames: ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).."SubscriptionInterstitialFrame")
		end
	end
	if (event == "MAJOR_FACTION_RENOWN_LEVEL_CHANGED" or event == "MAJOR_FACTION_UNLOCKED") then
		if MajorFactionsRenownToast then
			MajorFactionsRenownToast:SetScript("OnEvent", nil)
			ChatFrame1:AddMessage(E.Octo_Func.func_Gradient("Hide trash frames: ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).."MajorFactionsRenownToast")
		end
	end
	if (event == "CHAT_MSG_SKILL" or event == "CHAT_MSG_SYSTEM") and not InCombatLockdown() then
		Collect_All_Professions()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if event == "PLAYER_XP_UPDATE" then
		Collect_Player_Level()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "QUEST_ACCEPTED" or event == "QUEST_COMPLETE" or event == "QUEST_FINISHED" or event == "QUEST_LOG_UPDATE" or event == "QUEST_REMOVED" or event == "QUEST_TURNED_IN" or event == "QUEST_LOOT_RECEIVED") then
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
		end)
		Hide_trash_frames()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_MONEY" or event == "ACCOUNT_MONEY") and not InCombatLockdown() then
		Collect_ALL_MoneyUpdate()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "CURRENCY_DISPLAY_UPDATE") and not InCombatLockdown() then
		Collect_All_Currency()
		Hide_trash_frames()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_EQUIPMENT_CHANGED") and not InCombatLockdown() then
		Collect_ALL_ItemLevel()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_LEAVING_WORLD") and not InCombatLockdown() then
		Collect_ALL_GreatVault()
		Collect_ALL_LoginTime()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
		Collect_ALL_LoginTime()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_All_journalInstance()
		Hide_trash_frames()
		GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or .8)
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED") and not InCombatLockdown() then
		Collect_ALL_ItemsInBag()
	end
	if (event == "BAG_UPDATE_DELAYED" and BankFrame:IsShown() ) and not InCombatLockdown() then
		Collect_ALL_ItemsInBag()
	end
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "ITEM_COUNT_CHANGED" or event == "MAIL_SEND_SUCCESS") and not InCombatLockdown() then
		C_Timer.After(2, function()
				if not InCombatLockdown() then
					Collect_ALL_ItemsInBag()
					if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
				end
		end)
	end
	if (event == "HEARTHSTONE_BOUND" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
		Collect_ALL_Locations()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "SPELLS_CHANGED") and not InCombatLockdown() then
		C_Timer.After(2, function()
				Collect_WarMode()
		end)
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "MAIL_INBOX_UPDATE" or event == "MAIL_SHOW" or event == "UPDATE_PENDING_MAIL") and not InCombatLockdown() then
		Collect_ALL_Mail()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if event == "PLAYER_REGEN_DISABLED" or InCombatLockdown() then
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then
			OctoToDo_MainFrame:Hide()
		end
	end
	if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM") and not InCombatLockdown() then
		E.Octo_Func.PlaySoundFile_whisper(...)
	end
	if (event == "READY_CHECK") and not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
	if event == "ENCOUNTER_END" then
		C_Timer.After(1, function()
				Collect_All_journalInstance()
				if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
		end)
	end
	if event == "TIME_PLAYED_MSG" then
		Collect_Played(...)
		Collect_ALL_mapChallengeModeID()
		if OctoToDo_MainFrame and OctoToDo_MainFrame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if event == "GROUP_ROSTER_UPDATE" then
		TEST_GROUP_ROSTER()
	end
end
Octo_ToDo_FIRST_OnLoad()
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	debugprofilestart()
	if not InCombatLockdown() then
		main_frame_toggle()
		Octo_ToDo_FIRST_AddDataToAltFrame()
	end
	ChatFrame1:AddMessage ("debug timer: "..E.Octo_Func.func_Gradient(tostringall(debugprofilestop()), E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).." ms.")
end
local editFrame, editBox
if select(4, GetBuildInfo()) > 20000 then
	editFrame = CreateFrame("FRAME", GlobalAddonName.."EditFrame", UIParent, "MyAddonEditFrameTemplate")
	editFrame:ClearAllPoints()
	editFrame:SetPoint("TOPLEFT", (UIParent:GetWidth() - editFrame:GetWidth()) / 2, -100)
	editBox = editFrame.editFrame
end
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	ChatFrame1:AddMessage (E.Octo_Func.func_Gradient("GSEARCH: ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color) .. msg)
	local str = ""
	local list = {}
	for i, n in pairs(_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..E.Octo_Func.func_Gradient(i, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).. " - ".. n .."\n"
		end
	end
	editBox:SetText(str)
	editFrame:Show()
end
SlashCmdList["RELOAD"] = ReloadUI
SLASH_RELOAD1 = "/rl"

-- fpde(E.Octo_Table.Movies)
