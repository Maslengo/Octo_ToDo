-- CLASS_SORT_ORDER
local GlobalAddonName, E = ...
Octo_ToDO_E = E
local _G = _G
_G["OctoTODO"] = OctoTODO
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local AceLocale = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local CallbackHandler = LibStub("CallbackHandler-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibOctopussy = LibStub("LibOctopussy-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibCustomGlow = LibStub("LibCustomGlow-1.0")
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local gsub, tinsert, next, type, wipe = gsub, tinsert, next, type, wipe
local ipairs, pairs, sort = ipairs, pairs, sort
local next, format, type = next, format, type
local tostring, tonumber, strfind, strmatch, strsplit = tostring, tonumber, strfind, strmatch, strsplit
local CreateFrame = CreateFrame
local UIParent = UIParent
local buildVersion, buildNumber, buildDate, interfaceVersion = GetBuildInfo() -- Mainline
local currentTier = tonumber(GetBuildInfo():match("(.-)%."))
local IsPublicBuild = IsPublicBuild()
local expansionQWEQWE = 13
-- local IsTestBuild = IsTestBuild()
-- local isTestBuild = GetCurrentRegion() == 72 -- PTR/beta
local isBeta = interfaceVersion >= 120000
local GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData()) or 20
local GetRestrictedAccountData_rMoney = select(2, GetRestrictedAccountData()) or 10000000
local GetRestrictedAccountData_profCap = select(3, GetRestrictedAccountData()) or 0
local IsAccountSecured = IsAccountSecured() or false
local IsRestrictedAccount = IsRestrictedAccount() or false
local IsTrialAccount = IsTrialAccount() or false
local IsVeteranTrialAccount = IsVeteranTrialAccount() or false
local BattleTag = select(2, BNGetInfo()) or "Trial Account" -- RAF_TRIAL_RECRUIT .."("..buildVersion.."."..buildNumber..")"
local BTAG = tostringall(strsplit("#", BattleTag))
local GameVersion = GetCurrentRegion() == 72 and "PTR" or "Retail"
-- ПОФИКСИТЬ
local BattleTagLocal = BTAG.." ("..GameVersion..")"
local curGUID = UnitGUID("PLAYER")
local ItemLevelGreen = 625
local ItemLevelOrange = 610
local ItemLevelRed = 580
local GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
local MISCELLANEOUS = MISCELLANEOUS
local expansion = _G['EXPANSION_NAME'..GetExpansionLevel()]
-- if currentTier == 1 then E.currentMaxLevel = 60 end
-- if currentTier == 2 then E.currentMaxLevel = 70 end
-- if currentTier == 3 then E.currentMaxLevel = 80 end
-- if currentTier == 4 then E.currentMaxLevel = 85 end
-- if currentTier == 5 then E.currentMaxLevel = 90 end
-- if currentTier == 6 then E.currentMaxLevel = 100 end
-- if currentTier == 7 then E.currentMaxLevel = 110 end
-- if currentTier == 8 then E.currentMaxLevel = 120 end
-- if currentTier == 9 then E.currentMaxLevel = 60 end
-- if currentTier == 10 then E.currentMaxLevel = 70 end
-- if currentTier == 11 then E.currentMaxLevel = 80 end
local curWidthTitle = E.curWidthTitle
LibOctopussy:func_LoadAddOn("Octo_ToDoTrashCan")
LibOctopussy:func_LoadAddOn("!BugGrabber")
LibOctopussy:func_LoadAddOn("BugSack")
-- LibOctopussy:func_LoadAddOn("MountsJournal")
-- LibOctopussy:func_LoadAddOn("HidingBar")
-- LibOctopussy:func_LoadAddOn("HidingBar_Options")
-- LibOctopussy:func_LoadAddOn("SpeedyAutoLoot")
-- LibOctopussy:func_LoadAddOn("TalentTreeTweaks")
-- LibOctopussy:func_LoadAddOn("Plater")
-- LibOctopussy:func_LoadAddOn("MacroManager")
-- LibOctopussy:func_LoadAddOn("MacroManagerData")
-- LibOctopussy:func_LoadAddOn("SilverDragon")
-- LibOctopussy:func_LoadAddOn("SilverDragon_History")
-- LibOctopussy:func_LoadAddOn("SilverDragon_Overlay")
-- LibOctopussy:func_LoadAddOn("SilverDragon_RangeExtender")
-- LibOctopussy:func_LoadAddOn("TomTom")
-- LibOctopussy:func_LoadAddOn("Pawn")
-- LibOctopussy:func_LoadAddOn("MySlot")
-- LibOctopussy:func_LoadAddOn("QuestsChanged")
-- LibOctopussy:func_LoadAddOn("AdvancedInterfaceOptions")















-- Octo_ToDo_FIRST_OnLoad
local Button = nil
local CF = nil
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
local classColor = LibOctopussy:func_GetClassColor(classFilename)
local r, g, b = GetClassColor(classFilename)
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local classColorHexCurrent = LibOctopussy:func_rgb2hex(r, g, b)
if classFilename == "SHAMAN" then classcolor = "0070de" end
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
local normalizedRealm = GetNormalizedRealmName()
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
local Meta_Table_DONE = {__index = function() return E.DONE end}
local Meta_Table_NONE = {__index = function() return E.NONE end}
local Meta_Table_EmptyString = {__index = function() return "" end}
local TrashFrames_table = {
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
local function Hide_trash_frames()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Hide_trash_frames".."|r")
	end
	for _, v in next, (TrashFrames_table) do
		if v.frame and v.frame:IsShown() then
			-- ChatFrame1:AddMessage(LibOctopussy:func_Gradient("Hide trash frames: ")..v.name)
			v.frame:Hide()
			-- v.frame:UnregisterAllEvents()
		end
	end
end
local function DEV_GUID()
	local strGUID = tostringall(strsplit("-", utf8lower(utf8reverse(curGUID))))
	local vivod = LibOctopussy:func_encryption(curGUID)
end
local function ConcatAtStart()
	-- В КАКУЮ ИЗ КАКОЙ ПОФИКСИТЬ
	LibOctopussy:func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
	for _, itemID in next, (E.OctoTable_itemID_ALL) do
		Octo_ToDo_DB_Config.ItemDB[itemID] = Octo_ToDo_DB_Config.ItemDB[itemID] or false
	end
	LibOctopussy:func_TableConcat(E.OctoTable_itemID_Config, E.OctoTable_itemID_ALL)
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
	for _, questID in next, (E.OctoTable_QuestID) do
		Octo_ToDo_DB_Config.QuestsDB[questID] = Octo_ToDo_DB_Config.QuestsDB[questID] or false
	end
end
local function Central_Frame_Mouse_OnEnter(self)
	local parent = OctoToDo_FIRST_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in next, (self.tooltip) do
		if v[2] ~= "0/0" then
			GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
local function Central_Frame_Mouse_OnLeave(self)
	local parent = OctoToDo_FIRST_MainFrame["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
local function checkCharInfo(self, GUID)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."checkCharInfo".."|r")
	end
	local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName = GetPlayerInfoByGUID(GUID)
	-- /dump GetPlayerInfoByGUID("Player-1615-0B55FBC0")
	if self.journalInstance == nil then self.journalInstance = {} end
	local ServerTime = GetServerTime()
	for instanceID, v in next, (self.journalInstance) do
		if instanceID then
			for difficultyID, w in next, (v) do
				for e, r in next, (w) do
					if e == "instanceReset" then
						if ServerTime >= r then
							self.journalInstance[instanceID] = {}
						end
					end
				end
			end
		end
	end
	-- УДАЛЕНИЕ:
	-- Octo_ToDo_DB_Other = nil
	-- self.LFGInstance = nil
	-- self.MASLENGO.OctoTable_QuestID = nil
	-- self.MASLENGO.ItemsInBag = nil
	-- self.GreatVault = nil
	-- self.professions = nil
	-- self.reputationID = nil
	-- self.PVP =nil
	-- self.journalInstance = nil
	-- self.buildInfo = nil
	-- self.curCovID = nil
	-- self.islandBfA = nil
	-- УДАЛЕНИЕ:
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- 404 строка метатаблица
	-- self.reputationID = self.MASLENGO.reputationID
	-- ----------------
	-- self.reputationID = nil
	----------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- self.CurrencyID = self.MASLENGO.CurrencyID or {}
	-- self.CurrencyID_Total = self.MASLENGO.CurrencyID_Total or {}
	-- self.CurrencyID_totalEarned = self.MASLENGO.CurrencyID_totalEarned or {}
	-- ----------------
	-- self.CurrencyID = nil
	-- self.CurrencyID_Total = nil
	-- self.CurrencyID_totalEarned = nil
	----------------
	self.MASLENGO = self.MASLENGO or {}
	self.UniversalQuest = nil
	self.MASLENGO.UniversalQuest = self.MASLENGO.UniversalQuest or {}
	self.MASLENGO.CurrencyID = self.MASLENGO.CurrencyID or {}
	self.MASLENGO.CurrencyID_Total = self.MASLENGO.CurrencyID_Total or {}
	self.MASLENGO.CurrencyID_totalEarned = self.MASLENGO.CurrencyID_totalEarned or {}
	----------------------------------------------------------------
	self.MASLENGO.ItemsInBag = self.MASLENGO.ItemsInBag or {}
	self.MASLENGO.professions = self.MASLENGO.professions or {}
	self.MASLENGO.reputationID = self.MASLENGO.reputationID or {}
	self.MASLENGO.OctoTable_QuestID = self.MASLENGO.OctoTable_QuestID or {}
	if self.CurrencyID ~= nil then
		self.MASLENGO.CurrencyID = self.CurrencyID
	end
	if self.CurrencyID_Total ~= nil then
		self.MASLENGO.CurrencyID_Total = self.CurrencyID_Total
	end
	if self.CurrencyID_totalEarned ~= nil then
		self.MASLENGO.CurrencyID_totalEarned = self.CurrencyID_totalEarned
	end
	if self.ItemsInBag ~= nil then
		self.MASLENGO.ItemsInBag = self.ItemsInBag
	end
	-- if self.professions ~= nil then
	--     self.MASLENGO.professions = self.professions
	-- end
	if self.reputationID ~= nil then
		self.MASLENGO.reputationID = self.reputationID
	end
	if self.OctoTable_QuestID ~= nil then
		self.MASLENGO.OctoTable_QuestID = self.OctoTable_QuestID
	end
	if self.time == nil and self.tmstp_Daily ~= nil then
		self.time = self.tmstp_Daily
	end
	for i = 1, 5 do
		self.MASLENGO.professions[i] = self.MASLENGO.professions[i] or {}
		self.MASLENGO.professions[i].skillLine = self.MASLENGO.professions[i].skillLine or 0
		self.MASLENGO.professions[i].skillLevel = self.MASLENGO.professions[i].skillLevel or 0
		self.MASLENGO.professions[i].maxSkillLevel = self.MASLENGO.professions[i].maxSkillLevel or 0
	end
	----------------------------------------------------------------
	self.LFGInstance = self.LFGInstance or {}
	self.MASLENGO.OctoTable_QuestID = self.MASLENGO.OctoTable_QuestID or {}
	self.GreatVault = self.GreatVault or {}
	for _, v in next, (E.OctoTable_UniversalQuest) do
		self.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] = self.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] or E.NONE
	end
	-- КОВЕНАНТ
	self.professions = nil
	self.Shadowland = nil
	if self.CovenantAndAnima == nil then self.CovenantAndAnima = {} end
	if self.CovenantAndAnima.curCovID == nil then self.CovenantAndAnima.curCovID = 0 end
	for k = 1, 2 do
		for i = 1, 4 do
			-- if self.CovenantAndAnima[i] and type(self.CovenantAndAnima[i]) == "number" then self.CovenantAndAnima[i] = {}
			self.CovenantAndAnima[i] = self.CovenantAndAnima[i] or {}
			-- if self.CovenantAndAnima[i][k] and type(self.CovenantAndAnima[i][k]) == "number" then self.CovenantAndAnima[i[k]] = {}
			self.CovenantAndAnima[i][k] = self.CovenantAndAnima[i][k] or 0
		end
	end
	self.PVP = self.PVP or {}
	self.PVP.rating2v2 = self.PVP.rating2v2 or 0
	self.PVP.seasonBest2v2 = self.PVP.seasonBest2v2 or 0
	self.PVP.winrate2v2 = self.PVP.winrate2v2 or 0
	self.PVP.rating3v3 = self.PVP.rating3v3 or 0
	self.PVP.seasonBest3v3 = self.PVP.seasonBest3v3 or 0
	self.PVP.winrate3v3 = self.PVP.winrate3v3 or 0
	self.PVP.ratingRBG = self.PVP.ratingRBG or 0
	self.PVP.seasonBestRBG = self.PVP.seasonBestRBG or 0
	self.PVP.winrateRBG = self.PVP.winrateRBG or 0
	self.avgItemLevel = self.avgItemLevel or 1
	self.avgItemLevelEquipped = self.avgItemLevelEquipped or 1
	self.avgItemLevelPvp = self.avgItemLevelPvp or 1
	self.className = self.className or localizedClass
	self.classFilename = self.classFilename or englishClass
	self.classId = self.classId or 1
	self.classColor = self.classColor or {r = 0.5, g = 0.5, b = 0.5}
	self.curServer = self.curServer or curServer
	self.normalizedRealm = self.normalizedRealm or "normalizedRealm"
	self.guildName = self.guildName or ""
	self.guildRankName = self.guildRankName or ""
	self.guildRankIndex = self.guildRankIndex or 0
	self.curServerShort = self.curServerShort or LibOctopussy:func_CurServerShort(curServer)
	self.Faction = self.Faction or "Horde"
	self.BattleTag = self.BattleTag or BattleTag
	self.BattleTagLocal = self.BattleTagLocal or BattleTagLocal
	self.IsPublicBuild = self.IsPublicBuild or true
	self.Chromie_canEnter = self.Chromie_canEnter or false
	self.Chromie_UnitChromieTimeID = self.Chromie_UnitChromieTimeID or 0
	self.Chromie_name = self.Chromie_name or ""
	self.buildVersion = self.buildVersion or buildVersion
	self.GameLimitedMode_IsActive = self.GameLimitedMode_IsActive or GameLimitedMode_IsActive
	if self.levelCapped20 == nil then -- ПОФИКСИТЬ
		self.levelCapped20 = false
	end
	if self.PlayerCanEarnExperience == nil then -- ПОФИКСИТЬ
		self.PlayerCanEarnExperience = true
	end
	self.buildNumber = self.buildNumber or buildNumber
	self.buildDate = self.buildDate or buildDate
	self.interfaceVersion = self.interfaceVersion or interfaceVersion
	self.currentTier = self.currentTier or currentTier
	-- self.IsTestBuild = self.IsTestBuild or false
	self.isBeta = self.isBeta or false
	self.IsAccountSecured = self.IsAccountSecured or false
	self.GetRestrictedAccountData_rLevel = self.GetRestrictedAccountData_rLevel or 20
	self.GetRestrictedAccountData_rMoney = self.GetRestrictedAccountData_rMoney or 10000000
	self.GetRestrictedAccountData_profCap = self.GetRestrictedAccountData_profCap or 0
	self.IsTrialAccount = self.IsTrialAccount or false
	self.IsVeteranTrialAccount = self.IsVeteranTrialAccount or false
	-- self.NoPlayTime = self.NoPlayTime or false
	-- self.PartialPlayTime = self.PartialPlayTime or false
	self.PlayerDurability = self.PlayerDurability or 100
	self.maxNumQuestsCanAccept = self.maxNumQuestsCanAccept or 0
	self.Name = self.Name or name
	self.numQuests = self.numQuests or 0
	self.RaceLocal = self.RaceLocal or localizedRace
	self.RaceEnglish = self.RaceEnglish or englishRace
	self.raceID = self.raceID or 0
	self.classColorHex = self.classColorHex or classColorHexCurrent
	self.currentXP = self.currentXP or 0
	self.UnitXPMax = self.UnitXPMax or 0
	self.UnitXPPercent = self.UnitXPPercent or 0
	self.realTotalTime = self.realTotalTime or 0
	self.realLevelTime = self.realLevelTime or 0
	self.Possible_Anima = self.Possible_Anima or 0
	self.Possible_CatalogedResearch = self.Possible_CatalogedResearch or 0
	self.numShownEntries = self.numShownEntries or 0
	self.loginDate = self.loginDate or date("%d.%m.%Y %H:%M:%S")
	self.loginDay = self.loginDay or date("%d.%m.%Y")
	self.loginHour = self.loginHour or date("%H:%M")
	self.time = self.time or time()
	self.UnitLevel = self.UnitLevel or 1
	self.Money = self.Money or 0
	self.totalSlots = self.totalSlots or 0
	self.usedSlots = self.usedSlots or 0
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
	for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
		self.GreatVault[i] = self.GreatVault[i] or {}
		self.GreatVault[i].progress = self.GreatVault[i].progress or 0
		self.GreatVault[i].threshold = self.GreatVault[i].threshold or 0
		self.GreatVault[i].hyperlink_STRING = self.GreatVault[i].hyperlink_STRING or 0
		self.GreatVault[i].type = self.GreatVault[i].type or ""
	end
	if type(self.MASLENGO.CurrencyID) == "number" then self.MASLENGO.CurrencyID = {} end
	if type(self.MASLENGO.CurrencyID_Total) == "number" then self.MASLENGO.CurrencyID_Total = {} end
	if type(self.MASLENGO.CurrencyID_totalEarned) == "number" then self.MASLENGO.CurrencyID_totalEarned = {} end
	if type(self.MASLENGO.ItemsInBag) == "number" then self.MASLENGO.ItemsInBag = {} end
	-- setmetatable(self, Meta_Table_0)
	setmetatable(self.MASLENGO.OctoTable_QuestID, Meta_Table_NONE)
	setmetatable(self.MASLENGO.CurrencyID, Meta_Table_0)
	setmetatable(self.MASLENGO.CurrencyID_Total, Meta_Table_0)
	setmetatable(self.MASLENGO.CurrencyID_totalEarned, Meta_Table_0)
	setmetatable(self.MASLENGO.ItemsInBag, Meta_Table_0)
	setmetatable(self.MASLENGO.reputationID, Meta_Table_0)
	if (self.tmstp_Weekly or 0) < GetServerTime() then
		for i = 1, #self.GreatVault do
			if self.GreatVault[i] and self.GreatVault[i].hyperlink_STRING ~= 0 then
				self.HasAvailableRewards = true
				self.GreatVault = {}
				break
			end
		end
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() and self.MASLENGO.UniversalQuest.Octopussy_DF_Weekly_CommunityFeast_count == E.DONE then
		self.Octopussy_DF_Weekly_CommunityFeast_count = E.NONE
	end
	if (self.tmstp_Weekly or 0) < GetServerTime() then
		self.tmstp_Weekly = LibOctopussy:func_tmstpDayReset(7)
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
		for _, v in next, (E.OctoTable_UniversalQuest) do
			for q, w in next, (v) do
				if w == "Weekly" then
					self.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Weekly"] = E.NONE
				end
			end
		end
	end
	if (self.tmstp_Daily or 0) < GetServerTime() then
		self.tmstp_Daily = LibOctopussy:func_tmstpDayReset(1)
		self.needResetDaily = true
		for _, v in next, (E.OctoTable_UniversalQuest) do
			for q, w in next, (v) do
				if w == "Daily" then
					self.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Daily"] = E.NONE
				end
			end
		end
		self.LFGInstance = {}
	end
	for dungeonID, name in next, (E.OctoTable_LFGDungeons) do
		self.LFGInstance[dungeonID] = self.LFGInstance[dungeonID] or {}
		self.LFGInstance[dungeonID].D_name = self.LFGInstance[dungeonID].D_name or name
		self.LFGInstance[dungeonID].donetoday = self.LFGInstance[dungeonID].donetoday or E.NONE
	end
	if (self.tmstp_Month or 0) < GetServerTime() then
		self.tmstp_Month = LibOctopussy:func_tmstpDayReset(30)
		self.needResetMonth = true
		for _, v in next, (E.OctoTable_UniversalQuest) do
			for q, w in next, (v) do
				if w == "Month" then
					self.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_".."Month"] = E.NONE
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
	if LibOctopussy:func_GetItemCooldown(self.itemID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnEnter(self)
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 0)
	local itemLink = select(2, GetItemInfo(self.itemID))
	if itemLink then
		GameTooltip:ClearLines()
		-- GameTooltip:SetHyperlink(itemLink)
		-- GameTooltip:AddLine(LibOctopussy:func_itemTexture(self.itemID).." "..LibOctopussy:func_itemName(self.itemID))
		if LibOctopussy:func_GetItemCooldown(self.itemID) ~= 0 then
			GameTooltip:AddDoubleLine(LibOctopussy:func_itemTexture(self.itemID).." "..E.White_Color..LibOctopussy:func_itemName(self.itemID).."|r", E.Red_Color..LibOctopussy:func_SecondsToClock(LibOctopussy:func_GetItemCooldown(self.itemID)).."|r")
		else
			GameTooltip:AddLine(LibOctopussy:func_itemTexture(self.itemID).." "..E.White_Color..LibOctopussy:func_itemName(self.itemID).."|r")
		end
		if self.itemID == 6948 then
			GameTooltip:AddLine(E.White_Color..GetBindLocation() or E.NONE.."|r")
		end
		GameTooltip:Show()
	end
	self:SetBackdropBorderColor(r, g, b, 1)
	if LibOctopussy:func_GetItemCooldown(self.itemID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
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
	if LibOctopussy:func_GetItemCooldown(self.itemID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableItems_OnEvent(self, event, arg1, ...)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableItems_OnEvent".."|r"..event)
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
		self:SetParent(OctoToDo_FIRST_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableItems_OnMouseDown(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableItems_OnMouseDown".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, E.BGALPHA)
end
local function CreateFrameUsableItems_OnMouseUp(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableItems_OnMouseUp".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameUsableItems(itemID, Texture, Xpos, Ypos, r, g, b, spellID)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableItems".."|r")
	end
	local Button = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
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
local function CreateFrameUsableSpells_OnEnter(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnEnter".."|r")
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
		-- GameTooltip:SetHyperlink(link)
		if LibOctopussy:func_GetSpellCooldown(self.spellID) ~= 0 then
			GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(LibOctopussy:func_GetSpellIcon(self.spellID)).." "..E.White_Color..LibOctopussy:func_GetSpellName(self.spellID).."|r", E.Red_Color..LibOctopussy:func_SecondsToClock(LibOctopussy:func_GetSpellCooldown(self.spellID)).."|r")
		else
			GameTooltip:AddLine(LibOctopussy:func_texturefromIcon(LibOctopussy:func_GetSpellIcon(self.spellID)).." "..E.White_Color..LibOctopussy:func_GetSpellName(self.spellID).."|r")
		end
		GameTooltip:Show()
	end
	if LibOctopussy:func_GetSpellCooldown(self.spellID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnLeave(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnLeave".."|r")
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
	if LibOctopussy:func_GetSpellCooldown(self.spellID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnShow(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnEvent".."|r")
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
		self:SetParent(OctoToDo_FIRST_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
	if LibOctopussy:func_GetSpellCooldown(self.spellID) ~= 0 then
		self.icon:SetVertexColor(1, .34, .44, 1)
		self:SetBackdropBorderColor(1, .34, .44, 1)
	else
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end
end
local function CreateFrameUsableSpells_OnEvent(self, event)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnEvent".."|r")
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
		self:SetParent(OctoToDo_FIRST_MainFrame)
		self:SetPoint("BOTTOMLEFT", OctoToDo_FIRST_MainFrame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableSpells_OnMouseDown(self)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnMouseDown".."|r")
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
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells_OnMouseUp".."|r")
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
		ChatFrame1:AddMessage(E.Blue_Color.."CreateFrameUsableSpells".."|r")
	end
	local Button = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
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
		ChatFrame1:AddMessage(E.Blue_Color.."Octo_ToDoDeleteChar".."|r")
	end
	Octo_ToDo_DB_Players[curGUID] = nil
	for X, Y in next, (OctoToDo_FIRST_MainFrame.AllCharFrames) do
		if Y == OctoToDo_FIRST_MainFrame[curGUID] then
			OctoToDo_FIRST_MainFrame.AllCharFrames[X].parent = nil
			OctoToDo_FIRST_MainFrame.AllCharFrames[X]:Hide()
			OctoToDo_FIRST_MainFrame.AllCharFrames[X] = nil
		end
	end
end
local function TestSpec()
	local SPEC_STAT_STRINGS = {
		[LE_UNIT_STAT_STRENGTH] = "Strength", -- SPEC_FRAME_PRIMARY_STAT_STRENGTH,
		[LE_UNIT_STAT_AGILITY] = "Agility", -- SPEC_FRAME_PRIMARY_STAT_AGILITY,
		[LE_UNIT_STAT_INTELLECT] = "Intellect", -- SPEC_FRAME_PRIMARY_STAT_INTELLECT,
	}
	local classFilename, classId = UnitClassBase("PLAYER")
	Octo_ToDoTrashCan = Octo_ToDoTrashCan or {}
	Octo_ToDoTrashCan[classFilename] = Octo_ToDoTrashCan[classFilename] or {}
	Octo_ToDoTrashCan[classFilename].classId = classId
	for SpecializationIndex = 1, GetNumSpecializations() do
		local id, name, description, icon, role, primaryStat = GetSpecializationInfo(SpecializationIndex)
		Octo_ToDoTrashCan[classFilename][SpecializationIndex] = Octo_ToDoTrashCan[classFilename][SpecializationIndex] or {}
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].id = id
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].name = name
		-- Octo_ToDoTrashCan[classFilename][SpecializationIndex].description = nil
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].icon = icon
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].role = role
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].primaryStat = primaryStat
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].primaryStatString = SPEC_STAT_STRINGS[primaryStat]
		Octo_ToDoTrashCan[classFilename][SpecializationIndex].iconPath = E.ArtTexturePaths[icon]
	end
	-- fpde(Octo_ToDoTrashCan[classFilename][GetSpecialization()])
end
local function Collect_ALL_PlayerInfo()
	profileKeys = profileKeys or {}
	profileKeys[curCharName.." - ".. curServer] = profileKeys[curCharName.." - ".. curServer] or "OctoUI"
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_PlayerInfo()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	local curServerShort = LibOctopussy:func_CurServerShort(curServer)
	local expansionOptions = C_ChromieTime.GetChromieTimeExpansionOptions()
	local specId, specName, specDescription, specIcon, specRole, specPrimaryStat = GetSpecializationInfo(GetSpecialization())
	local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("PLAYER")
	local SPEC_STAT_STRINGS = {
		[LE_UNIT_STAT_STRENGTH] = SPEC_FRAME_PRIMARY_STAT_STRENGTH,
		[LE_UNIT_STAT_AGILITY] = SPEC_FRAME_PRIMARY_STAT_AGILITY,
		[LE_UNIT_STAT_INTELLECT] = SPEC_FRAME_PRIMARY_STAT_INTELLECT,
	}
	TestSpec()
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
		-- collect.specDescription = specDescription or ""
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
				collect.Chromie_name = expansionOptions[i].name
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
		-- collect.IsTestBuild = IsTestBuild
		collect.isBeta = isBeta
		collect.GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData())
		collect.GetRestrictedAccountData_rMoney = select(2, GetRestrictedAccountData())
		collect.GetRestrictedAccountData_profCap = select(3, GetRestrictedAccountData())
		collect.IsAccountSecured = IsAccountSecured
		collect.IsRestrictedAccount = IsRestrictedAccount
		collect.IsTrialAccount = IsTrialAccount
		collect.IsVeteranTrialAccount = IsVeteranTrialAccount
		-- collect.NoPlayTime = NoPlayTime
		-- collect.PartialPlayTime = PartialPlayTime
	end
end
-- КОВЕНАНТ
local function Collect_All_Covenant()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Covenant()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
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
local function Collect_All_PlayerDurability()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Durability()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
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
		-- collect.PlayerDurability = math.floor(totalDurability+.5)
		collect.PlayerDurability = LibOctopussy:func_CompactNumberSimple(totalDurability)
	end
end
local function Collect_Player_Level()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_Player_Level()".."|r")
	end
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
		if UnitLevel == E.currentMaxLevel then
			collect.PlayerCanEarnExperience = false
		else
			if GameLimitedMode_IsActive == true then
				if UnitLevel >= GetRestrictedAccountData_rLevel then
					if MainStatusTrackingBarContainer and MainStatusTrackingBarContainer:IsShown() then
						tinsert(TrashFrames_table, {name = "MainStatusTrackingBarContainer", frame = MainStatusTrackingBarContainer})
						-- tinsert(TrashFrames_table, {name = "OverrideActionBarExpBar", frame = OverrideActionBarExpBar})
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
local function Collect_Played(totalTime, currentLevelTime)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_Played()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	if collect then
		collect.realTotalTime = totalTime
		collect.realLevelTime = currentLevelTime
	end
end
local function Collect_WarMode()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_WarMode()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	local WarMode = C_PvP.IsWarModeDesired()
	if collect then
		collect.WarMode = WarMode
	end
end
local function Collect_ALL_Mail()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_Mail()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	local hasMail = HasNewMail()
	if collect and not InCombatLockdown() then
		collect.hasMail = hasMail
	end
end
local function Collect_ALL_LoginTime()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_LoginTime()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	collect.loginDate = date("%d.%m.%Y %H:%M:%S")
	collect.loginDay = date("%d.%m.%Y")
	collect.loginHour = date("%H:%M")
	collect.needResetWeekly = false
	collect.needResetDaily = false
	collect.needResetMonth = false
	collect.time = time()
end
local function Collect_All_Professions()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Professions()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
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
local function Collect_ALL_GreatVault()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_GreatVault".."|r")
	end
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
local function Collect_All_Currency_TEST()
	local vivod = false
	if vivod == true then
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == false then
			ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Currency_TEST".."|r")
		end
		-- CurrencyTransferMenu:GetRequestedCurrencyTransferAmount()
		-- local CurrencyTransferMenu = CurrencyTransferSystemMixin:GetCurrencyTransferMenu();
		-- local sourceCharacterData = CurrencyTransferSystemMixin:GetCurrencyTransferMenu():GetSourceCharacterData()
		-- /dump (CurrencyTransferSystemMixin:GetCurrencyTransferMenu())
		-- local currencyID = CurrencyTransferSystemMixin:GetCurrencyTransferMenu():GetCurrencyID()
		-- /dump C_CurrencyInfo.RequestCurrencyFromAccountCharacter("Player-1615-0B228060", 1166, 0)
		-- Hook the Confirm button to get the sourceGUID BEFORE the transfer occurs.
		print("1")
		local sourceGUID
		CurrencyTransferMenu.ConfirmButton:HookScript("PreClick", function(self)
				print("QWE")
				local data = CurrencyTransferMenu:GetSourceCharacterData()
				if data then
					print (data)
					sourceGUID = data.characterGUID
				end
		end)
		if sourceGUID then
			print (sourceGUID)
		end
		local sourceCharacterData = CurrencyTransferMenu:GetSourceCharacterData()
		if sourceCharacterData then
			print (sourceCharacterData.characterGUID, CurrencyTransferMenu:GetCurrencyID(), CurrencyTransferMenu:GetRequestedCurrencyTransferAmount())
			-- fpde(C_CurrencyInfo.RequestCurrencyFromAccountCharacter(sourceCharacterData.characterGUID, CurrencyTransferMenu:GetCurrencyID(), CurrencyTransferMenu:GetRequestedCurrencyTransferAmount()))
			local characterName = sourceCharacterData.characterName
			local quantity = sourceCharacterData.quantity
			local characterGUID = sourceCharacterData.characterGUID
			local fullCharacterName = sourceCharacterData.fullCharacterName
			local currencyID = sourceCharacterData.currencyID
			-- /dump GetPlayerInfoByGUID("Player-1615-0B228060")
			-- /dump C_BattleNet.GetAccountInfoByGUID("Player-1615-0B228060")
			-- /dump C_BattleNet.GetAccountInfoByGUID(UnitGUID("player"))
			-- /dump C_BattleNet.GetGameAccountInfoByGUID("Player-1615-0B228060")
			-- /dump C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
			if characterGUID then
				local localizedClass, englishClass, localizedRace, englishRace, sex, name, realmName = GetPlayerInfoByGUID(characterGUID)
				Octo_ToDo_DB_Players[characterGUID] = Octo_ToDo_DB_Players[characterGUID] or {}
				local collect = Octo_ToDo_DB_Players[characterGUID]
				-- print (name)
				local currencyID = CurrencyTransferMenu:GetCurrencyID()
				if collect then
					collect.Name = collect.Name or name
					collect.GUID = collect.GUID or characterGUID
					collect.classFilename = collect.classFilename or englishClass
					collect.className = collect.className or localizedClass
					-- local classColor = LibOctopussy:func_GetClassColor(englishClass)
					local r, g, b = GetClassColor(englishClass)
					collect.classColorHex = collect.classColorHex or LibOctopussy:func_rgb2hex(r, g, b)
					collect.classColor = collect.classColor or {r = r, g = g, b = b}
					if realmName ~= "" then
						local LRI_name = select(2, LibStub("LibRealmInfo"):GetRealmInfo(realmName)) or curServer
						local LRI_englishName = select(10, LibStub("LibRealmInfo"):GetRealmInfo(realmName)) or curServer
						collect.curServer = LRI_name
						collect.curServerShort = LibOctopussy:func_CurServerShort(LRI_name)
					end
				end
				for GUID, CharInfo in next, (Octo_ToDo_DB_Players) do
					checkCharInfo(CharInfo, GUID)
				end
				if currencyID and quantity and collect.MASLENGO.CurrencyID then
					collect.MASLENGO.CurrencyID[currencyID] = quantity
				end
				-- collect.MASLENGO.CurrencyID_Total[currencyID] = quantity
				-- collect.MASLENGO.CurrencyID_totalEarned[currencyID] = quantity
			end
		end
	end
end
local function Collect_All_Currency_TEST2()
	---@type table<number, string>
	OCTO_DB_currencies = {}
	---@type table<number, number>
	OCTO_DB_currencies_sort = {}
	---@type table<string, boolean>
	OCTO_DB_currencies_headers = {}
	OCTO_DB_currencies_test = OCTO_DB_currencies_test or {}
	----------------------------------------------------------------
	-- ОТКРЫТЬ
	----------------------------------------------------------------
	local expanded = {}
	for index = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader and not info.isHeaderExpanded then
			ExpandCurrencyList(index, true)
			expanded[info.name] = true
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	for index = 1, C_CurrencyInfo.GetCurrencyListSize() do
		local link = C_CurrencyInfo.GetCurrencyListLink(index)
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if link then
			local currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(link)
			local icon = info.iconFileID or "Interface\\Icons\\INV_Misc_QuestionMark" --iconFileID not available on first login
			OCTO_DB_currencies[currencyID] = "|T" .. icon .. ":0|t" .. info.name
			OCTO_DB_currencies_sort[currencyID] = index
		elseif info.isHeader then
			OCTO_DB_currencies[info.name] = info.name
			OCTO_DB_currencies_sort[info.name] = index
			OCTO_DB_currencies_headers[info.name] = true
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local currentHeader
	for index = 1, C_CurrencyInfo.GetCurrencyListSize() do
		local link = C_CurrencyInfo.GetCurrencyListLink(index)
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader then
			OCTO_DB_currencies_test[info.name] = OCTO_DB_currencies_test[info.name] or {}
			currentHeader = OCTO_DB_currencies_test[info.name]
		elseif link then
			local currencyID = C_CurrencyInfo.GetCurrencyIDFromLink(link)
			currentHeader[currencyID] = currentHeader[currencyID] or false
		end
	end
	----------------------------------------------------------------
	-- ЗАКРЫТЬ
	----------------------------------------------------------------
	for index = C_CurrencyInfo.GetCurrencyListSize(), 1, -1 do
		local info = C_CurrencyInfo.GetCurrencyListInfo(index)
		if info.isHeader and expanded[info.name] then
			ExpandCurrencyList(index, false)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
local function Collect_All_Reputations_TEST2()
	---@type table<number, string>
	OCTO_DB_reputations = OCTO_DB_reputations or {}
	OCTO_DB_reputations_test = OCTO_DB_reputations_test or {}
	----------------------------------------------------------------
	-- ОТКРЫТЬ C_Reputation.ExpandAllFactionHeaders()
	----------------------------------------------------------------
	-- Dynamic expansion of all collapsed headers
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
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- Process all faction data
	for index = 1, C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData then
			local reputationID = factionData.factionID
			OCTO_DB_reputations[reputationID] = factionData.name or "UNKNOWN"
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	local currentHeader
	for index = 1, C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData then
			local reputationID = factionData.factionID
			local currentStanding = factionData.currentStanding
			local isHeaderWithRep = factionData.isHeaderWithRep
			if factionData.isHeader and not isHeaderWithRep then
				OCTO_DB_reputations_test[reputationID] = OCTO_DB_reputations_test[reputationID] or {}
				currentHeader = OCTO_DB_reputations_test[reputationID]
			else
				currentHeader[reputationID] = currentHeader[reputationID] or false
			end
		end
	end
	----------------------------------------------------------------
	-- ЗАКРЫТЬ
	----------------------------------------------------------------
	-- Collapse headers back to their original state
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData and collapsed[factionData.name] then
			C_Reputation.CollapseFactionHeader(index)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
end
local function Collect_All_Currency()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Currency()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	Octo_ToDo_DB_Config = Octo_ToDo_DB_Config or {}
	collect = collect or {}
	collect.MASLENGO = collect.MASLENGO or {}
	-- local GetCurrencyListSize = C_CurrencyInfo.GetCurrencyListSize
	-- local GetCurrencyIDFromLink = C_CurrencyInfo.GetCurrencyIDFromLink
	-- local ExpandCurrencyList = C_CurrencyInfo.ExpandCurrencyList
	-- local GetCurrencyListInfo = C_CurrencyInfo.GetCurrencyListInfo
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
					if type(collect.MASLENGO.CurrencyID) == "number" then collect.MASLENGO.CurrencyID = {} end
					collect.MASLENGO.CurrencyID = collect.MASLENGO.CurrencyID or {}
					if type(collect.MASLENGO.CurrencyID_totalEarned) == "number" then collect.MASLENGO.CurrencyID_totalEarned = {} end
					collect.MASLENGO.CurrencyID_totalEarned = collect.MASLENGO.CurrencyID_totalEarned or {}
					if type(collect.MASLENGO.CurrencyID_Total) == "number" then collect.MASLENGO.CurrencyID_Total = {} end
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
				for GUID, tbl in next, (Octo_ToDo_DB_Players) do
					tbl.MASLENGO = tbl.MASLENGO or {}
					tbl.MASLENGO.CurrencyID = tbl.MASLENGO.CurrencyID or {}
					tbl.MASLENGO.CurrencyID_totalEarned = tbl.MASLENGO.CurrencyID_totalEarned or {}
					tbl.MASLENGO.CurrencyID_Total = tbl.MASLENGO.CurrencyID_Total or {}
					if tbl and not InCombatLockdown() then
						if type(tbl.MASLENGO.CurrencyID) == "number" then tbl.MASLENGO.CurrencyID = {} end
						tbl.MASLENGO.CurrencyID = tbl.MASLENGO.CurrencyID or {}
						if type(tbl.MASLENGO.CurrencyID_totalEarned) == "number" then tbl.MASLENGO.CurrencyID_totalEarned = {} end
						tbl.MASLENGO.CurrencyID_totalEarned = tbl.MASLENGO.CurrencyID_totalEarned or {}
						if type(tbl.MASLENGO.CurrencyID_Total) == "number" then tbl.MASLENGO.CurrencyID_Total = {} end
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
local function Collect_All_Reputations()
	-- /run C_Reputation.SetWatchedFactionByIndex(13)
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Reputations()".."|r")
	end
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
		for reputationID, v in next, (Octo_ToDo_DB_Config.ReputationDB) do
			local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
			if isAccountWide == false then
				collect.MASLENGO.reputationID[reputationID] = LibOctopussy:func_CheckReputationByRepID(reputationID) or 0
			else
				for GUID, tbl in next, (Octo_ToDo_DB_Players) do
					tbl.MASLENGO.reputationID[reputationID] = LibOctopussy:func_CheckReputationByRepID(reputationID) or 0
				end
			end
		end
	end
end
local function func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text then return nil end
	local r, g, b, a = fontstring:GetTextColor()
	return LibOctopussy:func_rgb2hex(r, g, b, a)..text.."|r"
end
local function Collect_ALL_ItemsInBag()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_ItemsInBag()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
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
							local QWE = func_coloredText(_G["OctoToDoScanningTooltipFIRSTTextLeft"..i])
							if QWE:find(LibOctopussy:func_OnlyFirstWord(ITEM_CLASSES_ALLOWED)) and QWE:find(USE_COLON) or QWE:find("Манускрипт наблюдений за драконами") or QWE:find("Drakewatcher Manuscript") then
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
local function Collect_ALL_EncounterAndZoneLists()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_EncounterAndZoneLists()".."|r")
	end
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
local function Collect_ALL_Locations()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_Locations()".."|r")
	end
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
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Quests()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for questID, v in next, (Octo_ToDo_DB_Config.QuestsDB) do
		local vivod = LibOctopussy:func_CheckCompletedByQuestID(questID)
		collect.MASLENGO.OctoTable_QuestID[questID] = vivod
	end
	if collect then
		collect.numShownEntries = numShownEntries or 0
		collect.numQuests = LibOctopussy:func_CurrentNumQuests()
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept or 0
	end
end
local function Collect_ALL_ItemLevel()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_ItemLevel()".."|r")
	end
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
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_UNIVERSALQuestUpdate()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	collect.MASLENGO.UniversalQuest = collect.MASLENGO.UniversalQuest or {}
	for _, v in next, (E.OctoTable_UniversalQuest) do
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
					local IsComplete = LibOctopussy:func_CheckCompletedByQuestID(questID)
					if IsComplete ~= E.NONE then
						vivod = IsComplete
					end
				end
			end
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
local function Collect_ALL_MoneyUpdate()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_MoneyUpdate()".."|r")
	end
	Octo_ToDo_DB_Players[UnitGUID("PLAYER")].Money = GetMoney() or 0
	Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] = C_Bank.FetchDepositedMoney(2)
end
local function Collect_ALL_MoneyOnLogin()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_MoneyOnLogin()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.MoneyOnLogin = Money
	end
end
local function Collect_All_journalInstance()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_journalInstance()".."|r")
	end
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
					local color = E.Red_Color
					if lastBossDefeated then color = E.Yellow_Color end
					if defeatedBosses == totalBosses then color = E.Green_Color end
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
					collect.journalInstance[instanceId][instanceDifficulty].Time = LibOctopussy:func_SecondsToClock(instanceReset-ServerTime)
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
local function function_setBackup()
	local backup = Octo_ToDo_DB_Other.CVar
	backup.calendarShowHolidays = GetCVarBool("calendarShowHolidays")
	backup.calendarShowDarkmoon = GetCVarBool("calendarShowDarkmoon")
	backup.calendarShowLockouts = GetCVarBool("calendarShowLockouts")
	backup.calendarShowWeeklyHolidays = GetCVarBool("calendarShowWeeklyHolidays")
	backup.calendarShowBattlegrounds = GetCVarBool("calendarShowBattlegrounds")
	if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "1") end
	if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "1") end
	if backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "0") end
	if backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "0") end
	if backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "0") end
	Octo_ToDo_DB_Other.CVar.dateBackup = C_Calendar.GetMonthInfo()
	if CalendarFrame then
		CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end
local function function_restoreBackup()
	local backup = Octo_ToDo_DB_Other.CVar
	if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "0") end
	if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "0") end
	if backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "1") end
	if backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "1") end
	if backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "1") end
	-- C_Calendar.SetAbsMonth(Octo_ToDo_DB_Other.CVar.dateBackup.month, Octo_ToDo_DB_Other.CVar.dateBackup.year)
	if CalendarFrame then
		CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
		CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	end
end
local function OLD_Collect_All_Holiday()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Holiday()".."|r")
	end
	-- function_setBackup()
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
	collect.Active = {}
	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(month, monthDay, i)
		local id = event.eventID
		collect.Collect[id] = LibOctopussy:func_EventName(id)
		local startTime = event.startTime
		local endTime = event.endTime
		if startTime and endTime and id then
			local startTime_year = startTime.year
			local startTime_month = startTime.month
			local startTime_monthDay = startTime.monthDay
			-- local startTime_weekday = startTime.weekday
			-- local startTime_hour = startTime.hour
			-- local startTime_minute = startTime.minute
			local endTime_year = endTime.year
			local endTime_month = endTime.month
			local endTime_monthDay = endTime.monthDay
			-- local endTime_weekday = endTime.weekday
			-- local endTime_hour = endTime.hour
			-- local endTime_minute = endTime.minute
			if collect.Active[id] == nil then
				collect.Active[id] = {}
			end
			collect.Active[id].id = id
			collect.Active[id].title = LibOctopussy:func_EventName(id)
			collect.Active[id].startTime = startTime_monthDay.."/"..startTime_month.."/"..startTime_year
			collect.Active[id].endTime = endTime_monthDay.."/"..endTime_month.."/"..endTime_year
		end
	end
	-- function_restoreBackup()
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
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..LibOctopussy:func_CompactNumberFormat(totalLevelXP - xp)
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
local function OLD_Collect_ALL_PVPRaitings()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_ALL_PVPRaitings()".."|r")
	end
	local collect = Octo_ToDo_DB_Players[curGUID]
	if not LibOctopussy:IsAddOnLoaded("Blizzard_PVPUI") then
		LibOctopussy:LoadAddOn("Blizzard_PVPUI")
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
	collect.PVP.rating2v2 = rating2v2
	collect.PVP.seasonBest2v2 = seasonBest2v2
	collect.PVP.winrate2v2 = winrate2v2
	collect.PVP.rating3v3 = rating3v3
	collect.PVP.seasonBest3v3 = seasonBest3v3
	collect.PVP.winrate3v3 = winrate3v3
	collect.PVP.ratingRBG = ratingRBG
	collect.PVP.seasonBestRBG = seasonBestRBG
	collect.PVP.winrateRBG = winrateRBG
end
local function OLD_Collect_All_Legion_Transmoge()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Collect_All_Legion_Transmoge()".."|r")
	end
	local _, playerClass, classID = UnitClass("player")
	for classFilename, v in pairs(E.OctoTable_CLASS_ARTIFACT_DATA) do
		for itemID in pairs(E.OctoTable_CLASS_ARTIFACT_DATA[classFilename]) do
			local artifactData = E.OctoTable_CLASS_ARTIFACT_DATA[classFilename][itemID]
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
							if E.OctoTable_UNLOCK_DATA[data.unlock] then
								local unlock = E.OctoTable_UNLOCK_DATA[data.unlock].unlock
								local unlockOCto = E.OctoTable_UNLOCK_DATA[data.unlock].unlockOCto
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
	Octo_ToDo_DB_LegionArtifacts = Octo_ToDo_DB_LegionArtifacts or {}
	for className, classTable in pairs(E.OctoTable_LegionArtifacts) do
		Octo_ToDo_DB_LegionArtifacts[className] = Octo_ToDo_DB_LegionArtifacts[className] or {}
		for specName, specTable in pairs(classTable) do
			Octo_ToDo_DB_LegionArtifacts[className][specName] = Octo_ToDo_DB_LegionArtifacts[className][specName] or {}
			for number, sourceID in pairs(specTable) do
				Octo_ToDo_DB_LegionArtifacts[className][specName][number] = Octo_ToDo_DB_LegionArtifacts[className][specName][number] or false
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
			-- local factionName = GetFactionInfoByID(d.factionID)
			-- local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			-- if questIndex > 0 then
			--     local questData = C_QuestLog.GetInfo(questIndex)
			--     if questData and questData.title then
			--         factionName = questData.title
			--     end
			-- end
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
				collect["bounty_Legion"..i] = LibOctopussy:func_CheckCompletedByQuestID(d.questID)
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
			-- local factionName = GetFactionInfoByID(d.factionID)
			-- local questIndex = C_QuestLog.GetLogIndexForQuestID(d.questID)
			-- if questIndex then
			--     if questIndex > 0 then
			--         local questData = C_QuestLog.GetInfo(questIndex)
			--         if questData and questData.title then
			--             factionName = questData.title
			--         end
			--     end
			-- end
			local currQ, maxQ = 0, 0
			local secondsLeft = C_TaskQuest.GetQuestTimeLeftMinutes(d.questID)
			if secondsLeft then
				local strsecondsLeft = format("%dh %dm", (secondsLeft / 60) % 24, secondsLeft % 60)
				if secondsLeft >= 1440 then
					strsecondsLeft = floor(secondsLeft / 1440).."d "..strsecondsLeft
				end
				local faction_icon = "|T"..d.icon..":0|t "
				if collect and not InCombatLockdown() then
					collect["bounty_BfA"..i] = LibOctopussy:func_CheckCompletedByQuestID(d.questID)
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
			collect.islandBfA = LibOctopussy:func_CheckCompletedByQuestID(questID)
		end
	end
end
local function Octo_ToDo_FIRST_OnLoad()
	if not OctpToDo_FIRST_inspectScantip then
		OctpToDo_FIRST_inspectScantip = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFIRST", nil, "GameTooltipTemplate")
		OctpToDo_FIRST_inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
local function O_otrisovka_FIRST()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."O_otrisovka_FIRST".."|r")
	end
	OctoTable_func_otrisovka_FIRST = {}
	-- НИК ПЕРСОНАЖА
	tinsert(OctoTable_func_otrisovka_FIRST,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
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
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className, " "}
				end
				tooltip[#tooltip+1] = {" ", " "}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			if CharInfo.totalSlots ~= 0 then
				tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133634)..L["Bags"], CharInfo.classColorHex..(CharInfo.usedSlots.."/"..CharInfo.totalSlots).."|r"}
			end
			if CharInfo.maxNumQuestsCanAccept ~= 0 then
				tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(236664)..QUESTS_LABEL, CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"}
			end
			if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..(LibOctopussy:func_SecondsToClock(CharInfo.realTotalTime)).."|r")}
				tooltip[#tooltip+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..(LibOctopussy:func_SecondsToClock(CharInfo.realLevelTime)).."|r")}
			end
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"hasMail", CharInfo.hasMail and E.Icon_MailBox..CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {" ", " "}
			tooltip[#tooltip+1] = {"Chromie_canEnter", CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
			tooltip[#tooltip+1] = {"Chromie_UnitChromieTimeID", CharInfo.Chromie_UnitChromieTimeID.."|r"}
			tooltip[#tooltip+1] = {"Chromie_name", CharInfo.classColorHex..CharInfo.Chromie_name.."|r"}
			tooltip[#tooltip+1] = {"-----------------------------------------------------------------------------"}
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
			-- tooltip[#tooltip+1] = {"IsTestBuild (PTR/beta)", CharInfo.IsTestBuild and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
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
			tooltip[#tooltip+1] = {"-----------------------------------------------------------------------------"}
			if CharInfo.MASLENGO.ItemsInBag[122284] ~= 0 then
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(122284)..LibOctopussy:func_itemName(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
			end
			vivodLeft = E.Timers.Daily_Reset()
			return vivodCent, vivodLeft
	end)
	-- Classic
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 1 then
		local expansionQWEQWE = 1
	end
	-- The Burning Crusade
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 2 then
		local expansionQWEQWE = 2
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(23572)..LibOctopussy:func_itemName(23572)
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(30183)..LibOctopussy:func_itemName(30183)
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(32428)..LibOctopussy:func_itemName(32428)
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(34664)..LibOctopussy:func_itemName(34664)
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Wrath of the Lich King
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 3 then
		local expansionQWEQWE = 3
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(52019)..LibOctopussy:func_itemName(52019)
				if CharInfo.MASLENGO.ItemsInBag[52019] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52019]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(43102)..LibOctopussy:func_itemName(43102)
				if CharInfo.MASLENGO.ItemsInBag[43102] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[43102]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(45087)..LibOctopussy:func_itemName(45087)
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(47556)..LibOctopussy:func_itemName(47556)
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(49908)..LibOctopussy:func_itemName(49908)
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(1358))..LibOctopussy:func_achievementName(1358).." "..LibOctopussy:func_achievementvivod(1358)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_BoreanTundra_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_BoreanTundra_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(1359))..LibOctopussy:func_achievementName(1359).." "..LibOctopussy:func_achievementvivod(1359)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Dragonblight_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Dragonblight_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(1357))..LibOctopussy:func_achievementName(1357).." "..LibOctopussy:func_achievementvivod(1357)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_GrizzlyHills_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_GrizzlyHills_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(1356))..LibOctopussy:func_achievementName(1356).." "..LibOctopussy:func_achievementvivod(1356)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_HowlingFjord_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_HowlingFjord_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(40))..LibOctopussy:func_achievementName(40).." "..LibOctopussy:func_achievementvivod(40)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Icecrown_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Icecrown_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(39))..LibOctopussy:func_achievementName(39).." "..LibOctopussy:func_achievementvivod(39)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_SholazarBasin_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_SholazarBasin_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(38))..LibOctopussy:func_achievementName(38).." "..LibOctopussy:func_achievementvivod(38)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_TheStormPeaks_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_TheStormPeaks_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(LibOctopussy:func_achievementIcon(36))..LibOctopussy:func_achievementName(36).." "..LibOctopussy:func_achievementvivod(36)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_ZulDrak_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_ZulDrak_Once
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(13668)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Tournament_Once ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_WrathoftheLichKing_Tournament_Once
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Cataclysm
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 4 then
		local expansionQWEQWE = 4
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(52078)..LibOctopussy:func_itemName(52078)
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(69237)..LibOctopussy:func_itemName(69237)
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(71998)..LibOctopussy:func_itemName(71998)
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Mists of Pandaria
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 5 then
		local expansionQWEQWE = 5
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[697] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[697]
				end
				vivodLeft = LibOctopussy:func_currencyicon(697)..E.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(697)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[776] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[776]
				end
				vivodLeft = LibOctopussy:func_currencyicon(776)..E.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(776)
				return vivodCent, vivodLeft
		end)
	end
	-- Warlords of Draenor
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 6 then
		local expansionQWEQWE = 6
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1129] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1129]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1129)..E.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(1129)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[994] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[994]
				end
				vivodLeft = LibOctopussy:func_currencyicon(994)..E.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(994)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[823] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[823]
				end
				vivodLeft = LibOctopussy:func_currencyicon(823)..LibOctopussy:func_currencyName(823)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1101] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1101]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1101)..LibOctopussy:func_currencyName(1101)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[824] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[824]
				end
				vivodLeft = LibOctopussy:func_currencyicon(824)..LibOctopussy:func_currencyName(824)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
					vivodCent = LibOctopussy:func_itemTexture(110560)..vivodCent
				end
				vivodLeft = GARRISON_LOCATION_TOOLTIP
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[38242]
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..LibOctopussy:func_itemTexture(122457)
				end
				vivodLeft = LibOctopussy:func_questName(38242).." (ап пета)"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[39246]
				end
				vivodLeft = LibOctopussy:func_questName(39246)
				return vivodCent, vivodLeft
		end)
	end
	-- Legion
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 7 then
		local expansionQWEQWE = 7
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.Timers.Legion_Invasion().."Timer_Legion_Invasion")
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB"
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - Armies of Legionfall"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46246] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - Excavations"
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[46666] == E.DONE then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Broken Shore - ToArgus"
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(43533)
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
				end
				if CharInfo.MASLENGO.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1273] then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1273]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1273)..E.Blue_Color.."("..L["Coins"]..") |r"..LibOctopussy:func_currencyName(1273)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1508)..LibOctopussy:func_currencyName(1508)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1342]
				vivodLeft = LibOctopussy:func_currencyicon(1342)..LibOctopussy:func_currencyName(1342)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1220]
				vivodLeft = LibOctopussy:func_currencyicon(1220)..LibOctopussy:func_currencyName(1220)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1226]
				vivodLeft = LibOctopussy:func_currencyicon(1226)..LibOctopussy:func_currencyName(1226)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1533]
				vivodLeft = LibOctopussy:func_currencyicon(1533)..LibOctopussy:func_currencyName(1533)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1155]
				vivodLeft = LibOctopussy:func_currencyicon(1155)..LibOctopussy:func_currencyName(1155)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				vivodLeft = LibOctopussy:func_itemTexture(124124)..LibOctopussy:func_itemName(124124)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				vivodLeft = "bounty_Legion1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				vivodLeft = "bounty_Legion2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				vivodLeft = "bounty_Legion3"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 1 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 2 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 3 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local QWE = Octo_ToDo_DB_Artifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARRIOR[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARRIOR[k][q].unlockOCto.."("..QWE.WARRIOR[k][q].name..")", QWE.WARRIOR[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PALADIN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PALADIN) do
						for q, w in pairs (v) do
							if QWE.PALADIN[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PALADIN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PALADIN[k][q].unlockOCto.."("..QWE.PALADIN[k][q].name..")", QWE.PALADIN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "HUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.HUNTER) do
						for q, w in pairs (v) do
							if QWE.HUNTER[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.HUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.HUNTER[k][q].unlockOCto.."("..QWE.HUNTER[k][q].name..")", QWE.HUNTER[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "ROGUE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.ROGUE) do
						for q, w in pairs (v) do
							if QWE.ROGUE[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.ROGUE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.ROGUE[k][q].unlockOCto.."("..QWE.ROGUE[k][q].name..")", QWE.ROGUE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "PRIEST" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.PRIEST) do
						for q, w in pairs (v) do
							if QWE.PRIEST[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.PRIEST[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.PRIEST[k][q].unlockOCto.."("..QWE.PRIEST[k][q].name..")", QWE.PRIEST[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEATHKNIGHT" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEATHKNIGHT) do
						for q, w in pairs (v) do
							if QWE.DEATHKNIGHT[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEATHKNIGHT[k][q].unlockOCto.."("..QWE.DEATHKNIGHT[k][q].name..")", QWE.DEATHKNIGHT[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "SHAMAN" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.SHAMAN) do
						for q, w in pairs (v) do
							if QWE.SHAMAN[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.SHAMAN[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.SHAMAN[k][q].unlockOCto.."("..QWE.SHAMAN[k][q].name..")", QWE.SHAMAN[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MAGE" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MAGE) do
						for q, w in pairs (v) do
							if QWE.MAGE[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MAGE[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MAGE[k][q].unlockOCto.."("..QWE.MAGE[k][q].name..")", QWE.MAGE[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "WARLOCK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARLOCK) do
						for q, w in pairs (v) do
							if QWE.WARLOCK[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.WARLOCK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.WARLOCK[k][q].unlockOCto.."("..QWE.WARLOCK[k][q].name..")", QWE.WARLOCK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "MONK" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.MONK) do
						for q, w in pairs (v) do
							if QWE.MONK[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.MONK[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.MONK[k][q].unlockOCto.."("..QWE.MONK[k][q].name..")", QWE.MONK[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DRUID" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DRUID) do
						for q, w in pairs (v) do
							if QWE.DRUID[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DRUID[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DRUID[k][q].unlockOCto.."("..QWE.DRUID[k][q].name..")", QWE.DRUID[k][q].vivod}
							end
						end
					end
				end
				if CharInfo.classFilename == "DEMONHUNTER" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.DEMONHUNTER) do
						for q, w in pairs (v) do
							if QWE.DEMONHUNTER[k][q].specIDnumber == 4 then
								vivodCent = LibOctopussy:func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon)
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				for className, classTable in pairs(E.OctoTable_LegionArtifacts) do
					for specName, specTable in pairs(classTable) do
						vivodLeft = className
						vivodCent = specName
						for number, sourceID in pairs(specTable) do
							if number == 1 or number == 2 or number == 3 or number == 4 then
								tooltip[#tooltip+1] = {number, sourceID}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Battle for Azeroth
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 8 then
		local expansionQWEQWE = 8
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (E.Timers.BfA_Invasion().."Timer_BfA_Invasion (PVP)")
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Timers.BfA_Assault().."Timer_BfA_Assault (N'zoth)"
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
				end
				if CharInfo.MASLENGO.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174765]..LibOctopussy:func_itemTexture(174765)
				end
				if CharInfo.MASLENGO.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174761]..LibOctopussy:func_itemTexture(174761)
				end
				if CharInfo.MASLENGO.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174767]..LibOctopussy:func_itemTexture(174767)
				end
				if CharInfo.MASLENGO.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174766]..LibOctopussy:func_itemTexture(174766)
				end
				if CharInfo.MASLENGO.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.MASLENGO.ItemsInBag[174768]..LibOctopussy:func_itemTexture(174768)
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174764)..CharInfo.MASLENGO.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174765]..LibOctopussy:func_itemTexture(174765)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174756)..CharInfo.MASLENGO.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.MASLENGO.ItemsInBag[174761]..LibOctopussy:func_itemTexture(174761)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174759)..CharInfo.MASLENGO.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174767]..LibOctopussy:func_itemTexture(174767)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174760)..CharInfo.MASLENGO.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.MASLENGO.ItemsInBag[174766]..LibOctopussy:func_itemTexture(174766)}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(174758)..CharInfo.MASLENGO.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.MASLENGO.ItemsInBag[174768]..LibOctopussy:func_itemTexture(174768)}
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_miniVision_count
				end
				vivodLeft = E.Purple_Color.."Mini Vision".."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB"
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB: Nazjatar"
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBAssault_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: Assault"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_WorldBoss.."WB: PVP"
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = E.Icon_Rares.."Rares: Darkshore"
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1560] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1560]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1560)..LibOctopussy:func_currencyName(1560)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1721] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1721]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1721)..LibOctopussy:func_currencyName(1721)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1803] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1803]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1803)..LibOctopussy:func_currencyName(1803)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1755] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..LibOctopussy:func_itemTexture(173363)
				end
				vivodLeft = LibOctopussy:func_currencyicon(1755)..LibOctopussy:func_currencyName(1755)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1719] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1719]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1719)..LibOctopussy:func_currencyName(1719)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1710] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1710]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1710)..LibOctopussy:func_currencyName(1710)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1716] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1716]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1716)..LibOctopussy:func_currencyName(1716)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = CharInfo.MASLENGO.CurrencyID_Total[1718]
				vivodLeft = LibOctopussy:func_currencyicon(1718)..LibOctopussy:func_currencyName(1718)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
				vivodLeft = LibOctopussy:func_itemTexture(158075)..LibOctopussy:func_itemName(158075)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
				vivodLeft = LibOctopussy:func_itemTexture(169223)..LibOctopussy:func_itemName(169223)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.islandBfA then
					vivodCent = CharInfo.islandBfA
				end
				vivodLeft = "Collect_BfA_Island"
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					vivodLeft = LibOctopussy:func_questName(questID)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront1_count
				end
				vivodLeft = "Warfront: Stromgarde"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_Warfront2_count
				end
				vivodLeft = "Warfront: Darkshore"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count
				end
				vivodLeft = "Warfront: Heroic"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				vivodLeft = "bounty_BfA1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				vivodLeft = "bounty_BfA2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				vivodLeft = "bounty_BfA3"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.ItemsInBag[166846] ~= 0 or CharInfo.MASLENGO.ItemsInBag[169610] ~= 0 or CharInfo.MASLENGO.ItemsInBag[166970] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168327] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168832] ~= 0 or CharInfo.MASLENGO.ItemsInBag[166971] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168946] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168215] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168216] ~= 0 or CharInfo.MASLENGO.ItemsInBag[168217] ~= 0 then
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166846)..LibOctopussy:func_itemName(166846), CharInfo.MASLENGO.ItemsInBag[166846]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(169610)..LibOctopussy:func_itemName(169610), CharInfo.MASLENGO.ItemsInBag[169610]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166970)..LibOctopussy:func_itemName(166970), CharInfo.MASLENGO.ItemsInBag[166970]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168327)..LibOctopussy:func_itemName(168327), CharInfo.MASLENGO.ItemsInBag[168327]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168832)..LibOctopussy:func_itemName(168832), CharInfo.MASLENGO.ItemsInBag[168832]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(166971)..LibOctopussy:func_itemName(166971), CharInfo.MASLENGO.ItemsInBag[166971]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168946)..LibOctopussy:func_itemName(168946), CharInfo.MASLENGO.ItemsInBag[168946]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168215)..LibOctopussy:func_itemName(168215), CharInfo.MASLENGO.ItemsInBag[168215]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168216)..LibOctopussy:func_itemName(168216), CharInfo.MASLENGO.ItemsInBag[168216]}
					tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(168217)..LibOctopussy:func_itemName(168217), CharInfo.MASLENGO.ItemsInBag[168217]}
					vivodCent = "МЕХАГОН"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Shadowlands
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
		local expansionQWEQWE = 9
		--КОВЕНАНТ
		for k = 1, 2 do
			for i = 1, 4 do
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
						vivodLeft = LibOctopussy:func_texturefromIcon(E.OctoTable_Covenant[i].icon)..E.OctoTable_Covenant[i].color..E.OctoTable_Covenant[i].name.."|r"
						if k == 1 then
							vivodCent = CharInfo.CovenantAndAnima[i][k]
							vivodLeft = vivodLeft
						else
							vivodLeft = vivodLeft..LibOctopussy:func_currencyicon(1813)
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
				end)
			end
		end
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Maw: Covenant Assault "..E.Timers.SL_Maw_Assault()
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2009] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2009]
				end
				vivodLeft = LibOctopussy:func_currencyicon(2009)..LibOctopussy:func_currencyName(2009)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1906] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1906]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1906)..LibOctopussy:func_currencyName(1906)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1828] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1828]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1828)..LibOctopussy:func_currencyName(1828)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1979] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1979]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1979)..LibOctopussy:func_currencyName(1979)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[1931] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[1931]
				end
				vivodLeft = LibOctopussy:func_currencyicon(1931)..LibOctopussy:func_currencyName(1931)
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				vivodLeft = LibOctopussy:func_texturefromIcon(4074774)..LibOctopussy:func_questName(66042)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				vivodLeft = LibOctopussy:func_texturefromIcon(4066373)..LibOctopussy:func_questName(63949)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: "..LibOctopussy:func_questName(65143)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				vivodLeft = E.Icon_WorldBoss.."World Boss: "..LibOctopussy:func_questName(64531)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				vivodLeft = LibOctopussy:func_currencyicon(1813)..LibOctopussy:func_questName(61981)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = "Кузня творения"
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(188957)..LibOctopussy:func_itemName(188957), CharInfo.MASLENGO.ItemsInBag[188957]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187634)..LibOctopussy:func_itemName(187634), CharInfo.MASLENGO.ItemsInBag[187634]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187636)..LibOctopussy:func_itemName(187636), CharInfo.MASLENGO.ItemsInBag[187636]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(187633)..LibOctopussy:func_itemName(187633), CharInfo.MASLENGO.ItemsInBag[187633]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189146)..LibOctopussy:func_itemName(189146), CharInfo.MASLENGO.ItemsInBag[189146]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189145)..LibOctopussy:func_itemName(189145), CharInfo.MASLENGO.ItemsInBag[189145]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189147)..LibOctopussy:func_itemName(189147), CharInfo.MASLENGO.ItemsInBag[189147]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189148)..LibOctopussy:func_itemName(189148), CharInfo.MASLENGO.ItemsInBag[189148]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189149)..LibOctopussy:func_itemName(189149), CharInfo.MASLENGO.ItemsInBag[189149]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189151)..LibOctopussy:func_itemName(189151), CharInfo.MASLENGO.ItemsInBag[189151]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189152)..LibOctopussy:func_itemName(189152), CharInfo.MASLENGO.ItemsInBag[189152]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189153)..LibOctopussy:func_itemName(189153), CharInfo.MASLENGO.ItemsInBag[189153]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189154)..LibOctopussy:func_itemName(189154), CharInfo.MASLENGO.ItemsInBag[189154]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189155)..LibOctopussy:func_itemName(189155), CharInfo.MASLENGO.ItemsInBag[189155]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189156)..LibOctopussy:func_itemName(189156), CharInfo.MASLENGO.ItemsInBag[189156]}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189157)..LibOctopussy:func_itemName(189157), CharInfo.MASLENGO.ItemsInBag[189157]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189158)..LibOctopussy:func_itemName(189158), CharInfo.MASLENGO.ItemsInBag[189158]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189159)..LibOctopussy:func_itemName(189159), CharInfo.MASLENGO.ItemsInBag[189159]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189160)..LibOctopussy:func_itemName(189160), CharInfo.MASLENGO.ItemsInBag[189160]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189161)..LibOctopussy:func_itemName(189161), CharInfo.MASLENGO.ItemsInBag[189161]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189162)..LibOctopussy:func_itemName(189162), CharInfo.MASLENGO.ItemsInBag[189162]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189163)..LibOctopussy:func_itemName(189163), CharInfo.MASLENGO.ItemsInBag[189163]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189164)..LibOctopussy:func_itemName(189164), CharInfo.MASLENGO.ItemsInBag[189164]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189165)..LibOctopussy:func_itemName(189165), CharInfo.MASLENGO.ItemsInBag[189165]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189166)..LibOctopussy:func_itemName(189166), CharInfo.MASLENGO.ItemsInBag[189166]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189167)..LibOctopussy:func_itemName(189167), CharInfo.MASLENGO.ItemsInBag[189167]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189168)..LibOctopussy:func_itemName(189168), CharInfo.MASLENGO.ItemsInBag[189168]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189169)..LibOctopussy:func_itemName(189169), CharInfo.MASLENGO.ItemsInBag[189169]}
				tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(189170)..LibOctopussy:func_itemName(189170), CharInfo.MASLENGO.ItemsInBag[189170]}
				local count = 0
				if CharInfo.MASLENGO.ItemsInBag[188957] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[187634] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[187636] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[187633] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189146] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189145] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189147] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189148] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189149] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189151] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189152] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189153] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189154] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189155] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189156] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189157] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189158] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189159] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189160] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189161] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189162] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189163] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189164] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189165] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189166] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189167] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189168] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189169] >= 1 then count = count + 1 end
				if CharInfo.MASLENGO.ItemsInBag[189170] >= 1 then count = count + 1 end
				vivodCent = count.."/".."29"
				return vivodCent, vivodLeft
		end)
	end
	-- Dragonflight
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
		local expansionQWEQWE = 10
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1603189)..L["Aiding the Accord"]
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= "" and CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
					end
					return vivodCent, vivodLeft
			end)
		end
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(629056)..E.Timers.DF_CommunityFeast()..L["Community Feast"]
				if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
				end
				if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200652]..LibOctopussy:func_itemTexture(200652)
				end
				if CharInfo.MASLENGO.ItemsInBag[200095] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.MASLENGO.ItemsInBag[200095]..LibOctopussy:func_itemTexture(200095)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(236469)..E.Timers.DF_ResearchersUnderFire()..LibOctopussy:func_questName(74906)
				if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.MASLENGO.OctoTable_QuestID[75630]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.MASLENGO.OctoTable_QuestID[75629]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.MASLENGO.OctoTable_QuestID[75628]}
					tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.MASLENGO.OctoTable_QuestID[75627]}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(75665)
				if CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_texturefromIcon(134206)..E.Timers.DF_Flower()..LibOctopussy:func_questName(78319)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(78821)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(78444)
				if CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_questName(78381)
				if CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Once_EmeraldDreamDreamsUnified_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (LibOctopussy:func_texturefromIcon(628677)..E.Timers.DF_TimeRift()..L["TimeRift"])
				if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(209856)..LibOctopussy:func_itemName(209856)
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(207002)..LibOctopussy:func_itemName(207002)
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= 0 then
					vivodCent = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2594] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= 0 then
					vivodCent = vivodCent..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..LibOctopussy:func_itemTexture(208945)
				end
				vivodLeft = LibOctopussy:func_currencyicon(2594)..LibOctopussy:func_currencyName(2594)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = (LibOctopussy:func_texturefromIcon(134206)..E.Timers.DF_Dreamsurges()..L["Dreamsurges"])
				if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.NONE then
					vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
				end
				if CharInfo.MASLENGO.ItemsInBag[209419] ~= 0 then
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(1044087)..E.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.MASLENGO.ItemsInBag[209419]}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(210254)..E.WOW_Epic_Color..LibOctopussy:func_itemName_NOCOLOR(210254).."|r"
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= 0 then
					vivodCent = vivodCent..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= 0 then
					vivodCent = vivodCent..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(207026)..E.WOW_Common_Color..LibOctopussy:func_itemName_NOCOLOR(207026).."|r"
				if CharInfo.MASLENGO.ItemsInBag[207026] ~= 0 then
					vivodCent = E.WOW_Common_Color..CharInfo.MASLENGO.ItemsInBag[207026].."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.CurrencyID[2245] ~= 0 then
					vivodCent = CharInfo.MASLENGO.CurrencyID[2245]
				end
				vivodLeft = LibOctopussy:func_currencyicon(2245)..LibOctopussy:func_currencyName(2245)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(213089)..LibOctopussy:func_itemName(213089)
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(211516)..LibOctopussy:func_itemName(211516)
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_itemTexture(211515)..LibOctopussy:func_itemName(211515)
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= 0 then
					vivodCent = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				return vivodCent, vivodLeft
		end)
	end
	-- The War Within
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 11 then
		local expansionQWEQWE = 11
		-- ЭПОХАЛЬНЫЙ КЛЮЧ
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(4352494)..E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
					if CharInfo.UnitLevel == E.currentMaxLevel then
						if CharInfo.CurrentKeyFULL ~= 0 then
							tooltip[#tooltip+1] = {LibOctopussy:func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
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
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..LibOctopussy:func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.GreatVault[i].progress ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
							end
						end
					end
					if CharInfo.RIO_Score_TWW_S1 ~= 0 then
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {"RIO Score:", LibOctopussy:func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_Score_TWW_S1.."|r"}
						tooltip[#tooltip+1] = {"Weekly Best:", LibOctopussy:func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.RIO_weeklyBest_TWW_S1.."|r"}
					end
					if CharInfo.CurrentKey ~= 0 then
						vivodCent = LibOctopussy:func_RIOColor(CharInfo.RIO_Score_TWW_S1)..CharInfo.CurrentKey.."|r"
					end
					if CharInfo.HasAvailableRewards then
						vivodCent = vivodCent..E.Blue_Color..">Vault<|r"
					end
					-- vivodCent = CharInfo.Chromie_inChromieTime and E.Red_Color..CharInfo.Chromie_name.."|r" or ""
					if CharInfo.Chromie_inChromieTime == true then
						vivodCent = vivodCent..E.Red_Color..CharInfo.Chromie_name.."|r"
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.BeledarCycle == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.Timers.TWW_BeledarCycle() .. LibOctopussy:func_questName(83240)
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_TheTheaterTroupe_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = E.Icon_WorldBoss..L["World Boss"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_WorldBoss_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = L["Weekly Dungeon Quest"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_DungeonQuest_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = "TWW_Delve_Weekly"
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_Delve_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		--
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(132863) .. L["Major Keyflames"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MajorKeyflames_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(135619) .. L["Minor Keyflames"]
					if CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly ~= E.NONE then
						vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_TWW_MinorKeyflames_Weekly
					end
					return vivodCent, vivodLeft
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2917
					local color = E.WOW_Epic_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
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
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2916
					local color = E.WOW_Epic_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
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
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2915
					local color = E.WOW_Rare_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
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
			end)
		end
		--
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					local currencyID = 2914
					local color = E.WOW_Rare_Color
					vivodLeft = LibOctopussy:func_currencyicon(currencyID)..color..LibOctopussy:func_currencyName_NOCOLOR(currencyID).."|r"
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
			end)
		end
	end
	-- TEST
	if Octo_ToDo_DB_Vars.config.ExpansionToShow == 12 then
		local expansionQWEQWE = 12
		----DEBUGPIZZA
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
		end)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		LibOctopussy:func_RemoveDuplicates(list)
		sort(list)
		for i, value in next, (list) do
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							vivodLeft = i
							vivodCent = value
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		----DEBUGPIZZA
	end
	local expansionQWEQWE = 13
	-- ТАЙМВОЛКИ
	if Octo_ToDo_DB_Vars.config.Timewalk == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(1166)..DUNGEONS
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Dungeons_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(1166).."500 "..LibOctopussy:func_currencyName(1166)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_500Currency_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(1166)..RAIDS
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_Raid_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(1166)..LibOctopussy:func_questName(43323)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ATimetoReflect_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(3100)..LibOctopussy:func_questName(84616)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_CelebrateGoodFun_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(3100)..LibOctopussy:func_questName(82783)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_ChromiesCodex_Weekly
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodLeft = LibOctopussy:func_currencyicon(3100)..LibOctopussy:func_texturefromIcon(1322720)..LibOctopussy:func_questName(57300)
				if CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly ~= E.NONE then
					vivodCent = CharInfo.MASLENGO.UniversalQuest.Octopussy_Timewalk_SoldierofTime_Weekly
				end
				return vivodCent, vivodLeft
		end)
	end
	-- ИВЕНТЫ
	if Octo_ToDo_DB_Vars.config.Event == true then
		if Octo_ToDo_DB_Other.Holiday.Active[628] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(514016).."Cataclysm"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(514016)..L["Firelands"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if (Octo_ToDo_DB_Other.Holiday.Active[622] or Octo_ToDo_DB_Other.Holiday.Active[559]) then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(514016).."Burning Crusade"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(237385)..L["Black Temple"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1265] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1379226).."Legion"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[652] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1416740).."Mists of Pandaria"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[616] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(466283).."Wrath of the Lich King"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(237445)..L["Ulduar"]
					if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_WrathoftheLichKing_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1063] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(133594).."Warlords of Draenor"
					if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS
					if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(463446)..LibOctopussy:func_currencyName(1166)
					if CharInfo.MASLENGO.CurrencyID[1166] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[1166]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1352] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(1542856)..DUNGEONS.." Dragonfly"
					if CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1400] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = Octo_ToDo_DB_Other.Holiday.Collect[1400]
					if CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(4638724)..LibOctopussy:func_currencyName(2588)
					if CharInfo.MASLENGO.CurrencyID[2588] ~= 0 then
						vivodCent = CharInfo.MASLENGO.CurrencyID[2588]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[479] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(354435)..Octo_ToDo_DB_Other.Holiday.Collect[479]
					if CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= E.NONE and CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= "0/9" then
						vivodCent = CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[599] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(667491)..Octo_ToDo_DB_Other.Holiday.Collect[599]
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[72721]
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[613] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236683)..Octo_ToDo_DB_Other.Holiday.Collect[613]
					vivodCent = CharInfo.MASLENGO.OctoTable_QuestID[72728]
					return vivodCent, vivodLeft
			end)
		end
	end
	-- ПРАЗДНИКИ
	if Octo_ToDo_DB_Vars.config.Holiday == true then
		if Octo_ToDo_DB_Other.Holiday.Active[341] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = "SummerFestival"
					if CharInfo.Octopussy_DF_Month_SummerFestival_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_SummerFestival_count.." ("..CharInfo.MASLENGO.ItemsInBag[23247]..LibOctopussy:func_itemTexture(23247)..")"
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[372] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.LFGInstance[287].D_name ~= E.NONE then
						vivodLeft = LibOctopussy:func_texturefromIcon(236701)..CharInfo.LFGInstance[287].D_name
					end
					if CharInfo.LFGInstance[287].donetoday ~= E.NONE then
						vivodCent = CharInfo.LFGInstance[287].donetoday
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_texturefromIcon(133784)..LibOctopussy:func_itemName(37829)
					if CharInfo.MASLENGO.ItemsInBag[37829] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[37829]
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_questName(77155)
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
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_questName(12492)
					if CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_questName(76591)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236701)..LibOctopussy:func_questName(77208)
					if CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[324] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.LFGInstance[285].D_name ~= E.NONE then
						vivodLeft = LibOctopussy:func_texturefromIcon(133661)..CharInfo.LFGInstance[285].D_name
					end
					if CharInfo.LFGInstance[285].donetoday ~= E.NONE then
						vivodCent = CharInfo.LFGInstance[285].donetoday
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					if CharInfo.MASLENGO.ItemsInBag[33226] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[33226]
					end
					vivodLeft = LibOctopussy:func_texturefromIcon(236546)..LibOctopussy:func_itemName(33226)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[409] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(307568)..Octo_ToDo_DB_Other.Holiday.Collect[409]
					if CharInfo.Octopussy_DF_Once_DayoftheDead_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy_DF_Once_DayoftheDead_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[1397] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(136235)..LibOctopussy:func_questName(60215)
					if CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsDoomwalkinHasComeKnockin_count
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(136235)..LibOctopussy:func_questName(57300)
					if CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count ~= E.NONE then
						vivodCent = CharInfo.Octopussy__Weekly_19yearsSoldierofTime_count
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[404] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(236571)..Octo_ToDo_DB_Other.Holiday.Collect[404]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= E.NONE and CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_AlliancePilgrimsBounty_count
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14053)..E.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14053]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14055)..E.Gray_Color.." (Элвиннский лес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14055]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14048)..E.Gray_Color.." (Дун Морог)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14048]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14051)..E.Gray_Color.." (Дун Морог)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14051]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14054)..E.Gray_Color.." (Дарнас)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14054]}
						end
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= E.NONE and CharInfo.Octopussy__Daily_HordePilgrimsBounty_count ~= "0/5" then
							vivodCent = CharInfo.Octopussy__Daily_HordePilgrimsBounty_count
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14059)..E.Gray_Color.." (Подгород)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14059]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14058)..E.Gray_Color.." (Подгород)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14058]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14061)..E.Gray_Color.." (Дуротар)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14061]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14062)..E.Gray_Color.." (Дуротар)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14062]}
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(14060)..E.Gray_Color.." (Громовой Утес)".."|r", CharInfo.MASLENGO.OctoTable_QuestID[14060]}
						end
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_itemTexture(44812)..LibOctopussy:func_itemName(44812)
					if CharInfo.MASLENGO.ItemsInBag[44812] ~= 0 then
						vivodCent = CharInfo.MASLENGO.ItemsInBag[44812]
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDo_DB_Other.Holiday.Active[141] then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(7043)
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= E.NONE and CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_AllianceWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_questName(7043), CharInfo.MASLENGO.OctoTable_QuestID[7043]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= E.NONE and CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count ~= "0/1" then
							vivodCent = CharInfo.Octopussy__Daily_HordeWinterVeil_YoureaMeanOne_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_questName(6983), CharInfo.MASLENGO.OctoTable_QuestID[6983]}
					end
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(7045)
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
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
					BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
					vivodLeft = LibOctopussy:func_texturefromIcon(133202)..L["Gifts"]
					if CharInfo.Faction == "Alliance" then
						if CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= E.NONE and CharInfo.Octopussy__Once_AllianceWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_AllianceWinterVeil_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8744), CharInfo.MASLENGO.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8768), CharInfo.MASLENGO.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8769), CharInfo.MASLENGO.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8803), CharInfo.MASLENGO.OctoTable_QuestID[8803]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78131), CharInfo.MASLENGO.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78504), CharInfo.MASLENGO.OctoTable_QuestID[78504]}
					end
					if CharInfo.Faction == "Horde" then
						if CharInfo.Octopussy__Once_HordeWinterVeil_count ~= E.NONE and CharInfo.Octopussy__Once_HordeWinterVeil_count ~= "0/6" then
							vivodCent = CharInfo.Octopussy__Once_HordeWinterVeil_count
						end
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8768), CharInfo.MASLENGO.OctoTable_QuestID[8768]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8744), CharInfo.MASLENGO.OctoTable_QuestID[8744]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78504), CharInfo.MASLENGO.OctoTable_QuestID[78504]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8769), CharInfo.MASLENGO.OctoTable_QuestID[8769]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(78131), CharInfo.MASLENGO.OctoTable_QuestID[78131]}
						tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(133202)..LibOctopussy:func_questName(8803), CharInfo.MASLENGO.OctoTable_QuestID[8803]}
					end
					return vivodCent, vivodLeft
			end)
		end
	end
	-- ЗАДАНИЯ СТАРОЕ
	if Octo_ToDo_DB_Vars.config.Quests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = E.Gray_Color..QUESTS_LABEL.."|r"
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 10 then
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."Dragonflight".."«"), " "}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {E.Timers.DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {E.Timers.DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {E.Timers.DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.2.5".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Gilneas Reclamation"]..")", CharInfo.Octopussy_DF_Once_TheGilneasReclamationStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Azerothian Archives"]..")", CharInfo.Octopussy_DF_Once_AzerothianArchivesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.2.0".."«"), " "}
					tooltip[#tooltip+1] ={E.Timers.DF_Flower()..LibOctopussy:func_questName(78319), CharInfo.Octopussy_DF_Weekly_EmeraldDreamTheSuperbloom_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Emerald Dream"]..")", CharInfo.Octopussy_DF_Once_ALLEmeraldDreamStorylines_count}
					tooltip[#tooltip+1] ={LibOctopussy:func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={LibOctopussy:func_questName(78821), CharInfo.Octopussy_DF_Weekly_EmeraldDreamBloomingDreamseeds_count}
					tooltip[#tooltip+1] ={LibOctopussy:func_questName(78444), CharInfo.Octopussy_DF_Weekly_EmeraldDreamAWorthyAllyDreamWardens_count}
					tooltip[#tooltip+1] ={LibOctopussy:func_questName(78381), CharInfo.Octopussy_DF_Weekly_EmeraldDreamDreamsUnified_count}
					tooltip[#tooltip+1] ={L["Rares"], CharInfo.Octopussy_DF_Daily_EmeraldDreamRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.5".."«"), " "}
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {E.Timers.DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Zaralek Cavern"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_ResearchersUnderFire()..LibOctopussy:func_questName(74906), CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {E.Icon_WorldBoss..LibOctopussy:func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(5062638)..LibOctopussy:func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_questName(75665), CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_texturefromIcon(4643981)..LibOctopussy:func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["The Forbidden Reach"].."«"), " "}
					tooltip[#tooltip+1] = {E.Timers.DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."10.1.7".."«"), " "}
					tooltip[#tooltip+1] = {E.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
				end
				if Octo_ToDo_DB_Vars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»".."Shadowlands".."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Zereth Mortis"].."«"), " "}
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
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Korthia"].."«"), " "}
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
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Maw"].."«"), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Class quests"].."«"), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
						if CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.NONE and CharInfo.MASLENGO.OctoTable_QuestID[24547] ~= E.DONE then
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(24547), CharInfo.MASLENGO.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						tooltip[#tooltip+1] = {L["Green Fire"], CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Race quests"].."«"), " "}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
					end
				end
				for k, v in ipairs(E.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Allied Races Quests"] .."«"), " "}
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
		end)
	end
	-- ЗАДАНИЯ НОВОЕ
	if Octo_ToDo_DB_Vars.config.Quests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivo, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local list = {}
				for QuestID, v in next, (Octo_ToDo_DB_Config.QuestsDB) do
					tinsert(list, QuestID)
				end
				sort(list, LibOctopussy.func_Reverse_order)
				for k, QuestID in next, (list) do
					if Octo_ToDo_DB_Vars.config.QuestsShowAllways == false and Octo_ToDo_DB_Config.QuestsDB[QuestID] == true and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= 0 and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= "" and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= E.NONE then
						tooltip[#tooltip+1] = {LibOctopussy:func_questName(QuestID)..E.Gray_Color, CharInfo.MASLENGO.OctoTable_QuestID[QuestID]}
					elseif Octo_ToDo_DB_Vars.config.QuestsShowAllways == true and Octo_ToDo_DB_Config.QuestsDB[QuestID] == true then
						if CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= 0 and CharInfo.MASLENGO.OctoTable_QuestID[QuestID] ~= "" then
							tooltip[#tooltip+1] = {LibOctopussy:func_questName(QuestID)..E.Gray_Color, CharInfo.MASLENGO.OctoTable_QuestID[QuestID]}
						else
							tooltip[#tooltip+1] = {E.Gray_Color..LibOctopussy:func_questName(QuestID), E.Gray_Color..CharInfo.MASLENGO.OctoTable_QuestID[QuestID].."|r"}
						end
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..QUESTS_LABEL.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = QUESTS_LABEL.." NEW"
				return vivodCent, vivodLeft
		end)
	end
	-- ПОДЗЕМЕЛЬЯ
	if Octo_ToDo_DB_Vars.config.Dungeons == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..LibOctopussy:func_SecondsToClock(w.instanceReset-ServerTime).."|r", w.vivod}
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
		end)
	end
	-- ВАЛЮТА
	if Octo_ToDo_DB_Vars.config.Currency == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local list = {}
				for CurrencyID, v in next, (Octo_ToDo_DB_Config.CurrencyDB) do
					tinsert(list, CurrencyID)
				end
				sort(list, LibOctopussy.func_Reverse_order)
				for k, CurrencyID in next, (list) do
					if Octo_ToDo_DB_Vars.config.CurrencyShowAllways == false and Octo_ToDo_DB_Config.CurrencyDB[CurrencyID] == true and CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:func_currencyicon(CurrencyID)..LibOctopussy:func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
					elseif Octo_ToDo_DB_Vars.config.CurrencyShowAllways == true and Octo_ToDo_DB_Config.CurrencyDB[CurrencyID] == true then
						if CharInfo.MASLENGO.CurrencyID[CurrencyID] ~= 0 then
							tooltip[#tooltip+1] = {LibOctopussy:func_currencyicon(CurrencyID)..LibOctopussy:func_currencyName(CurrencyID), CharInfo.MASLENGO.CurrencyID_Total[CurrencyID]}
						else
							tooltip[#tooltip+1] = {LibOctopussy:func_currencyicon(CurrencyID)..E.Gray_Color..LibOctopussy:func_currencyName_NOCOLOR(CurrencyID), E.Gray_Color..CharInfo.MASLENGO.CurrencyID_Total[CurrencyID].."|r"}
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
		end)
	end
	-- РЕПУТАЦИЯ
	if Octo_ToDo_DB_Vars.config.Reputations == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				vivodCent = E.Gray_Color..REPUTATION.."|r"
				-- for _, questID in next, (E.OctoTable_QuestID_Paragon) do
				--     if CharInfo.MASLENGO.OctoTable_QuestID[questID] ~= (E.NONE or E.DONE) then
				--         tooltip[#tooltip+1] = {LibOctopussy:func_Gradient("»"..L["Paragon"].."«"), " "}
				--         tooltip[#tooltip+1] = {LibOctopussy:func_questName(questID), CharInfo.MASLENGO.OctoTable_QuestID[questID]}
				--         if #tooltip > 0 then
				--             tooltip[#tooltip+1] = {" ", " "}
				--             vivodCent = LibOctopussy:func_Gradient(L["Paragon"])
				--         end
				--     end
				-- end
				local list = {}
				for reputationID, v in next, (Octo_ToDo_DB_Config.ReputationDB) do
					tinsert(list, reputationID)
				end
				sort(list, LibOctopussy.func_Reverse_order)
				local j = 1
				for i, reputationID in next, (list) do
					if Octo_ToDo_DB_Config.ReputationDB[reputationID] == true and CharInfo.MASLENGO.reputationID[reputationID] ~= 0 and CharInfo.MASLENGO.reputationID[reputationID] ~= "" and LibOctopussy:func_reputationName(reputationID) ~= SEARCH_LOADING_TEXT then
						local color = j%2 == 0 and "|cffBBBBBB" or E.White_Color
						tooltip[#tooltip+1] = {color..LibOctopussy:func_reputationName(reputationID).."|r", CharInfo.MASLENGO.reputationID[reputationID]}
						j = j + 1
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Gray_Color..REPUTATION.."|r"
				else
					vivodCent = ""
				end
				vivodLeft = REPUTATION
				return vivodCent, vivodLeft
		end)
	end
	-- ПРЕДМЕТЫ
	if Octo_ToDo_DB_Vars.config.Items == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				local list = {}
				for itemID, v in next, (Octo_ToDo_DB_Config.ItemDB) do
					tinsert(list, itemID)
				end
				sort(list, LibOctopussy.func_Reverse_order)
				for k, itemID in next, (list) do
					if Octo_ToDo_DB_Config.ItemDB[itemID] == true then
						if Octo_ToDo_DB_Vars.config.ItemsShowAllways == false and Octo_ToDo_DB_Config.ItemDB[itemID] == true and CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
							tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(itemID)..LibOctopussy:func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
						elseif Octo_ToDo_DB_Vars.config.ItemsShowAllways == true and Octo_ToDo_DB_Config.ItemDB[itemID] == true then
							if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 and CharInfo.MASLENGO.ItemsInBag[itemID] ~= "" then
								tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(itemID)..LibOctopussy:func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
							else
								tooltip[#tooltip+1] = {LibOctopussy:func_itemTexture(itemID)..E.Gray_Color..LibOctopussy:func_itemName_NOCOLOR(itemID).."|r", E.Gray_Color..CharInfo.MASLENGO.ItemsInBag[itemID].."|r"}
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
		end)
	end
	-- ПРОФЕССИИ
	if Octo_ToDo_DB_Vars.config.Professions == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.MASLENGO.professions[1].skillLine ~= 0 then
					vivodCent = vivodCent..LibOctopussy:func_ProfessionIcon(CharInfo.MASLENGO.professions[1].skillLine)
					if CharInfo.MASLENGO.professions[2].skillLine ~= 0 then
						vivodCent = vivodCent.." "..LibOctopussy:func_ProfessionIcon(CharInfo.MASLENGO.professions[2].skillLine)
					end
				end
				for i = 1, 5 do
					if CharInfo.MASLENGO.professions[i].skillLine ~= 0 then
						tooltip[#tooltip+1] = {LibOctopussy:func_ProfessionIcon(CharInfo.MASLENGO.professions[i].skillLine)..LibOctopussy:func_ProfessionName(CharInfo.MASLENGO.professions[i].skillLine), CharInfo.MASLENGO.professions[i].skillLevel.."/"..CharInfo.MASLENGO.professions[i].maxSkillLevel}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	-- ЗОЛОТО
	if Octo_ToDo_DB_Vars.config.Gold == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
				BG:SetColorTexture(bgQWEr, bgQWEg, bgQWEb, E.BGALPHA/2)
				if CharInfo.Money then
					vivodCent = LibOctopussy:func_CompactNumberFormat(CharInfo.Money/10000)..E.Icon_Money
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Red_Color..LibOctopussy:func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						vivodCent = vivodCent..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Green_Color..LibOctopussy:func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.Icon_Money}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	-- УРОВЕНЬ ПРЕДМЕТОВ
	if Octo_ToDo_DB_Vars.config.ItemLevel == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
		end)
	end
	-- БЫЛ В СЕТИ
	if Octo_ToDo_DB_Vars.config.WasOnline == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft, bgQWEr, bgQWEg, bgQWEb = "", "", LibOctopussy:func_hex2rgbNUMBER(E.OctoTable_Expansions_Table[expansionQWEQWE].color)
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
						vivodCent = color..LibOctopussy:FriendsFrame_GetLastOnline(CharInfo.time).."|r"
						tooltip[#tooltip+1] = {color..LibOctopussy:FriendsFrame_GetLastOnlineText(CharInfo.time, CharInfo.classColorHex).."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginDay.."|r"}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginHour.."|r"}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
end
local function TotalMoneyCurServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."TotalMoneyCurServerOnShow".."|r")
	end
	local TotalMoneyCurServer = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalMoneyCurServer = TotalMoneyCurServer + CharInfo.Money
		end
	end
	return classColorHexCurrent..LibOctopussy:func_CompactNumberFormat(TotalMoneyCurServer/10000).."|r"..E.Icon_Money
end
local function TotalMoneyAllServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."TotalMoneyAllServerOnShow".."|r")
	end
	local TotalMoneyAllServer = 0
	local vivod = ""
	local AccountMoney = Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] or 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
		if CharInfo.Money ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
		end
	end
	if AccountMoney <= 9999 then
		vivod = classColorHexCurrent..LibOctopussy:func_CompactNumberFormat((TotalMoneyAllServer)/10000).."|r"..E.Icon_Money
	else
		vivod = classColorHexCurrent..LibOctopussy:func_CompactNumberFormat((TotalMoneyAllServer)/10000).."|r"..E.Icon_Money..E.LightGray_Color.." +"..LibOctopussy:func_CompactNumberFormat(AccountMoney/10000) .." (".. ACCOUNT_BANK_PANEL_TITLE.. ")".."|r"
	end -- REPUTATION_SORT_TYPE_ACCOUNT
	return vivod
end
local function Token_PriceOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Token_PriceOnShow".."|r")
	end
	local vivod = ""
	local TokenPrice = C_WowTokenPublic.GetCurrentMarketPrice()
	if TokenPrice == nil then
		C_WowTokenPublic.UpdateMarketPrice()
	else
		vivod = TOKEN_FILTER_LABEL..": "..classColorHexCurrent..LibOctopussy:func_CompactNumberFormat(TokenPrice/10000).."|r"..E.Icon_Money
	end
	return vivod
end
local function TotalTimeAllServerOnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."TotalTimeAllServerOnShow".."|r")
	end
	local TotalTimeAllServer = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
		if CharInfo.realTotalTime ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
			TotalTimeAllServer = TotalTimeAllServer + CharInfo.realTotalTime
		end
	end
	return classColorHexCurrent..(LibOctopussy:func_SecondsToClock(TotalTimeAllServer)).."|r"
end
local function TotalTimeAllServer80OnShow()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."TotalTimeAllServer80OnShow".."|r")
	end
	local TotalTimeAllServer70 = 0
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
		if CharInfo.UnitLevel == E.currentMaxLevel then
			if CharInfo.realLevelTime ~= 0 and CharInfo.BattleTagLocal == BattleTagLocal then
				TotalTimeAllServer70 = TotalTimeAllServer70 + CharInfo.realLevelTime
			end
		end
	end
	if TotalTimeAllServer70 ~= 0 then
		return classColorHexCurrent..(LibOctopussy:func_SecondsToClock(TotalTimeAllServer70)).."|r"
	else
		return ""
	end
end
-- function MainFrame_OnShow(self)
--     self.animation:SetFromAlpha(0)
--     self.animation:SetToAlpha(1)
--     self.group:Restart()
-- end
-- function MainFrame_OnHide(self)
--     self.animation:SetFromAlpha(1)
--     self.animation:SetToAlpha(0)
--     self.group:Restart()
-- end
local function Octo_ToDo_FIRST_CreateAltFrame()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Octo_ToDo_FIRST_CreateAltFrame".."|r")
	end
	OctoToDo_FIRST_MainFrame = CreateFrame("BUTTON", "OctoToDo_FIRST_MainFramePIZZA", UIParent, "BackdropTemplate")
	OctoToDo_FIRST_MainFrame:Hide()
	Octo_ToDo_DB_Vars.config.FrameScale = Octo_ToDo_DB_Vars.config.FrameScale or 1
	OctoToDo_FIRST_MainFrame:SetScale(Octo_ToDo_DB_Vars.config.FrameScale)
	local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame)
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
	-- OctoToDo_FIRST_MainFrame:SetScript("OnDragStart", OctoToDo_FIRST_MainFrame.StartMoving)
	OctoToDo_FIRST_MainFrame:SetScript("OnDragStart", function()
			OctoToDo_FIRST_MainFrame:SetAlpha(E.bgCa/2)
			OctoToDo_FIRST_MainFrame:StartMoving()
	end)
	OctoToDo_FIRST_MainFrame:SetScript("OnDragStop", function()
			OctoToDo_FIRST_MainFrame:SetAlpha(1)
			OctoToDo_FIRST_MainFrame:StopMovingOrSizing()
	end)
	OctoToDo_FIRST_MainFrame:RegisterForClicks("RightButtonUp")
	OctoToDo_FIRST_MainFrame:SetScript("OnClick", function(self) self:Hide() end)
	OctoToDo_FIRST_MainFrame:SetHeight(50)
	-- OctoToDo_FIRST_MainFrame:SetAlpha(0)
	-- OctoToDo_FIRST_MainFrame:SetScript("OnShow", MainFrame_OnShow)
	-- OctoToDo_FIRST_MainFrame:SetScript("OnHide", MainFrame_OnHide)
	-- OctoToDo_FIRST_MainFrame.group = OctoToDo_FIRST_MainFrame:CreateAnimationGroup()
	-- OctoToDo_FIRST_MainFrame.group:SetToFinalAlpha(true)
	-- OctoToDo_FIRST_MainFrame.animation = OctoToDo_FIRST_MainFrame.group:CreateAnimation("Alpha")
	-- OctoToDo_FIRST_MainFrame.animation:SetSmoothing("NONE")
	-- OctoToDo_FIRST_MainFrame.animation:SetDuration(.5)
	-- OctoToDo_FIRST_MainFrame.animation:SetTarget(OctoToDo_FIRST_MainFrame)
	if Octo_ToDo_DB_Vars.config.ShowTotalMoney then
		if not Octo_Frame_TotalMoneyCurServer then
			Octo_Frame_TotalMoneyCurServer = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					text:SetText(LibOctopussy:func_CurServerShort(curServer)..": "..TotalMoneyCurServerOnShow())
			end)
		end
		if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
			if not Octo_Frame_TotalMoneyAllServer then
				Octo_Frame_TotalMoneyAllServer = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
				end)
			end
		end
		if not Octo_Frame_Token_Price then
			Octo_Frame_Token_Price = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					end)
			end)
		end
	end
	if Octo_ToDo_DB_Vars.config.ShowTimeAll == true then
		if not Octo_Frame_TotalTimeAllServer then
			Octo_Frame_TotalTimeAllServer = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
			end)
		end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == true then
			if not Octo_Frame_TotalTimeAllServerMAXLEVEL then
				Octo_Frame_TotalTimeAllServerMAXLEVEL = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
				end)
			end
		end
	end
	----------------------------------------------------------------
	if not OctoToDo_FIRST_CloseButton then
		OctoToDo_FIRST_CloseButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
		OctoToDo_FIRST_CloseButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_FIRST_CloseButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*0, 1)
		OctoToDo_FIRST_CloseButton:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1
		})
		OctoToDo_FIRST_CloseButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_FIRST_CloseButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:ClearLines()
				GameTooltip:AddLine(classColorHexCurrent..CLOSE.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_FIRST_CloseButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		OctoToDo_FIRST_CloseButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_FIRST_CloseButton:SetScript("OnClick", function()
				OctoToDo_FIRST_MainFrame:Hide()
		end)
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
		end)
	end
	----------------------------------------------------------------
	if not OctoToDo_FIRST_OptionsButton then
		OctoToDo_FIRST_OptionsButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
		OctoToDo_FIRST_OptionsButton:SetSize(E.curHeight, E.curHeight)
		OctoToDo_FIRST_OptionsButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*1, 1)
		OctoToDo_FIRST_OptionsButton:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1
		})
		OctoToDo_FIRST_OptionsButton:SetBackdropBorderColor(1, 0, 0, 0)
		OctoToDo_FIRST_OptionsButton:SetScript("OnEnter", function(self)
				self.icon:SetVertexColor(r, g, b, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
				GameTooltip:AddLine(classColorHexCurrent..OPTIONS.."|r")
				GameTooltip:Show()
		end)
		OctoToDo_FIRST_OptionsButton:SetScript("OnLeave", function(self)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:Hide()
		end)
		OctoToDo_FIRST_OptionsButton:SetScript("OnMouseDown", function(self)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		OctoToDo_FIRST_OptionsButton:SetScript("OnClick", function()
				if OctoToDo_FIRST_MainFramePIZZA and OctoToDo_FIRST_MainFramePIZZA:IsShown() then
					OctoToDo_FIRST_MainFramePIZZA:Hide()
				end
				if SettingsPanel:IsVisible() and self:IsVisible() then
					HideUIPanel(SettingsPanel)
				else
					Settings.OpenToCategory(E.AddonTitle, true)
				end
		end)
		local t = OctoToDo_FIRST_OptionsButton:CreateTexture(nil, "BACKGROUND")
		OctoToDo_FIRST_OptionsButton.icon = t
		t:SetTexture(E.AddonTexture_1)
		t:SetAllPoints(OctoToDo_FIRST_OptionsButton)
	end
	----------------------------------------------------------------
	local function AbandonQuests()
		local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
		local numQuests = LibOctopussy:func_CurrentNumQuests()
		for i = 1, numShownEntries do
			if numQuests ~= 0 then
				local info = C_QuestLog.GetInfo(i)
				if info then
					if (not info.isHeader and not info.isHidden) then
						ChatFrame1:AddMessage(LibOctopussy:func_Gradient(L["Abandon: "])..LibOctopussy:func_questName(info.questID))
						C_QuestLog.SetSelectedQuest(info.questID)
						C_QuestLog.SetAbandonQuest()
						C_QuestLog.AbandonQuest()
					end
				end
			end
		end
		ChatFrame1:AddMessage(LibOctopussy:func_Gradient(L["Total"]).." "..E.Green_Color..numQuests.."|r")
	end
	if Octo_ToDo_DB_Vars.config.AdditionalButtons == true then
		if not OctoToDo_FIRST_AbandonButton then
			local numQuests = LibOctopussy:func_CurrentNumQuests()
			StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
				text = E.Red_Color.."!!! ACHTUNG !!!|r\n"..classColorHexCurrent.."Отменить все задания?|r",
				button1 = YES,
				button2 = NO,
				hideOnEscape = 1,
				whileDead = 1,
				OnAccept = function()
					C_Timer.After(1, AbandonQuests)
				end,
			}
			OctoToDo_FIRST_AbandonButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
			OctoToDo_FIRST_AbandonButton:SetSize(E.curHeight, E.curHeight)
			OctoToDo_FIRST_AbandonButton:SetPoint("BOTTOMRIGHT", OctoToDo_FIRST_MainFrame, "TOPRIGHT", (-E.curHeight)*2, 1)
			OctoToDo_FIRST_AbandonButton:SetBackdrop({
					edgeFile = E.edgeFile,
					edgeSize = 1
			})
			OctoToDo_FIRST_AbandonButton:SetBackdropBorderColor(1, 0, 0, 0)
			OctoToDo_FIRST_AbandonButton:SetScript("OnEnter", function(self)
					numQuests = LibOctopussy:func_CurrentNumQuests()
					self.icon:SetVertexColor(r, g, b, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					if numQuests > 0 then
						GameTooltip:AddLine(classColorHexCurrent..L["Abandon All Quests"].."|r".." ("..LibOctopussy:func_CurrentNumQuests()..")")
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
										tinsert(list, info.questID)
									else
									end
								end
							end
						end
					end
					sort(list, LibOctopussy.func_Reverse_order)
					for k, questID in next, (list) do
						GameTooltip:AddDoubleLine(LibOctopussy:func_questName(questID),LibOctopussy:func_CheckCompletedByQuestID(questID) , 1, 1, 1, 1, 1, 1)
					end
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_AbandonButton:SetScript("OnLeave", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_AbandonButton:SetScript("OnMouseDown", function(self)
					self.icon:SetVertexColor(1, 0, 0, .5)
			end)
			OctoToDo_FIRST_AbandonButton:SetScript("OnClick", function()
					if numQuests > 0 then
						StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
					end
			end)
			local t = OctoToDo_FIRST_AbandonButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_AbandonButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow72.tga")
			t:SetAllPoints(OctoToDo_FIRST_AbandonButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_MplusButton then
			OctoToDo_FIRST_MplusButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					local list = {}
					for dungeonID = 1, 1000 do
						local name = LibOctopussy:func_dungeonName(dungeonID)
						if name then
							tinsert(list, dungeonID)
						end
					end
					sort(list, LibOctopussy.func_Reverse_order)
					for count, dungeonID in next, (list) do
						local name = LibOctopussy:func_dungeonName(dungeonID)
						local timeLimit = LibOctopussy:func_dungeontimeLimit(dungeonID)
						local icon = LibOctopussy:func_dungeonIcon(dungeonID)
						i = i + 1
						local vivod_LEFT = LibOctopussy:func_texturefromIcon(icon) .. name
						local vivod_RIGHT = E.Gray_Color.."icon:|r"..E.Green_Color..icon.."|r "..E.Gray_Color.."time:|r"..E.Green_Color..LibOctopussy:func_SecondsToClock(timeLimit).."|r"
						GameTooltip:AddDoubleLine(vivod_LEFT, vivod_RIGHT, 1, 1, 1, 1, 1, 1)
					end
					if i == 0 then
						GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
						OctoToDo_FIRST_MplusButton:Hide()
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_MplusButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_MplusButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_MplusButton:SetScript("OnClick", function()
					-- OctoToDo_FIRST_MainFrame:Hide()
					fpde(list)
			end)
			local t = OctoToDo_FIRST_MplusButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_MplusButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
			t:SetAllPoints(OctoToDo_FIRST_MplusButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_ItemsButton then
			OctoToDo_FIRST_ItemsButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for _, itemID in next, (E.OctoTable_itemID_Config) do
						for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
							if CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0 then
								i = i + 1
								GameTooltip:AddDoubleLine(LibOctopussy:func_itemTexture(itemID)..LibOctopussy:func_itemName(itemID), CharInfo.MASLENGO.ItemsInBag[itemID].." "..CharInfo.classColorHex..CharInfo.Name.."|r "..CharInfo.curServerShort)
							end
						end
					end
					if i == 0 then
						GameTooltip:AddLine(classColorHexCurrent.."No Data".."|r")
						-- OctoToDo_FIRST_ItemsButton:Hide()
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_ItemsButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_ItemsButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_ItemsButton:SetScript("OnClick", function()
					-- OctoToDo_FIRST_MainFrame:Hide()
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
						if curCharGUID == curGUID then
							fpde(CharInfo)
						end
					end
			end)
			local t = OctoToDo_FIRST_ItemsButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_ItemsButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow21.tga")
			t:SetAllPoints(OctoToDo_FIRST_ItemsButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_MarkOfHonorButton then
			OctoToDo_FIRST_MarkOfHonorButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDo_DB_Players) do
						if (CharInfo.MASLENGO.ItemsInBag[137642] ~= 0) then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(1322720)..CharInfo.MASLENGO.ItemsInBag[137642], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[202196] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(4909720)..CharInfo.MASLENGO.ItemsInBag[202196], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[86547] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(237230)..CharInfo.MASLENGO.ItemsInBag[86547], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[183616] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(133291)..CharInfo.MASLENGO.ItemsInBag[183616], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[166751] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(967526)..CharInfo.MASLENGO.ItemsInBag[166751], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[122457] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(667491)..CharInfo.MASLENGO.ItemsInBag[122457], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[190189] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(LibOctopussy:func_texturefromIcon(519378)..CharInfo.MASLENGO.ItemsInBag[190189], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[204464] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(5009042)..CharInfo.MASLENGO.ItemsInBag[204464], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[201325] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(4644002)..CharInfo.MASLENGO.ItemsInBag[201325], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[12811] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_texturefromIcon(134122)..CharInfo.MASLENGO.ItemsInBag[12811], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_itemTexture(200652)..CharInfo.MASLENGO.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
						if CharInfo.MASLENGO.ItemsInBag[122284] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.WOW_Heirloom_Color..TOKEN_FILTER_LABEL.."|r"..LibOctopussy:func_texturefromIcon(1120721)..CharInfo.MASLENGO.ItemsInBag[122284], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_MarkOfHonorButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
			end)
			local t = OctoToDo_FIRST_MarkOfHonorButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_MarkOfHonorButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow1.tga")
			t:SetAllPoints(OctoToDo_FIRST_MarkOfHonorButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_QuestFeastButton then
			OctoToDo_FIRST_QuestFeastButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDo_DB_Players) do
						if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.DONE and CharInfo.UnitLevel >= 60 then
							i = i +1
							GameTooltip:AddDoubleLine(CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r", CharInfo.Octopussy_DF_Weekly_CommunityFeast_count)
						end
						if CharInfo.MASLENGO.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..LibOctopussy:func_itemTexture(200652)..CharInfo.MASLENGO.ItemsInBag[200652], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
						end
					end
					if i == 0 then
						GameTooltip:AddLine(E.Green_Color.."All done|r")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_QuestFeastButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
			end)
			local t = OctoToDo_FIRST_QuestFeastButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_QuestFeastButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow2.tga")
			t:SetAllPoints(OctoToDo_FIRST_QuestFeastButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_EventsButton then
			OctoToDo_FIRST_EventsButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					local classFilename = UnitClassBase("PLAYER")
					GameTooltip:AddDoubleLine(classColorHexCurrent..(L["Current Date"]).."|r", classColorHexCurrent..(date("%d/%m/%Y").."|r"))
					GameTooltip:AddDoubleLine(" ", " ")
					for eventID, v in pairs(Octo_ToDo_DB_Other.Holiday.Active) do
						GameTooltip:AddDoubleLine(LibOctopussy:func_EventName(eventID), Octo_ToDo_DB_Other.Holiday.Active[eventID].startTime.." - "..Octo_ToDo_DB_Other.Holiday.Active[eventID].endTime)
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_EventsButton:SetScript("OnShow", function(self)
					self.icon:SetVertexColor(1, 0, 1, 1)
			end)
			OctoToDo_FIRST_EventsButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 0, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_EventsButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_EventsButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
					fpde(Octo_ToDo_DB_Other.Holiday.Active)
			end)
			local t = OctoToDo_FIRST_EventsButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_EventsButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow6.tga")
			t:SetAllPoints(OctoToDo_FIRST_EventsButton)
		end
		----------------------------------------------------------------
		if not OctoToDo_FIRST_ConsumableButton then
			OctoToDo_FIRST_ConsumableButton = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "BackDropTemplate")
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
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10) -- 20, -30
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for itemID, v in pairs(Octo_ToDo_DB_Other.Items.Consumable) do
						for k, CharInfo in pairs(Octo_ToDo_DB_Players) do
							if CharInfo.curServer == GetRealmName() then
								if (CharInfo.MASLENGO.ItemsInBag[itemID] ~= 0) then
									i = i + 1
									GameTooltip:AddDoubleLine(LibOctopussy:func_itemTexture(itemID)..LibOctopussy:func_itemName(itemID).." "..CharInfo.MASLENGO.ItemsInBag[itemID], CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServerShort..")".."|r")
								end
							end
						end
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(r, g, b, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(r, g, b, .5)
			end)
			OctoToDo_FIRST_ConsumableButton:SetScript("OnClick", function()
					OctoToDo_FIRST_MainFrame:Hide()
			end)
			local t = OctoToDo_FIRST_ConsumableButton:CreateTexture(nil, "BACKGROUND")
			OctoToDo_FIRST_ConsumableButton.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow4.tga")
			t:SetAllPoints(OctoToDo_FIRST_ConsumableButton)
		end
		----------------------------------------------------------------
	end
	if not dd_FIRST then
		local dd_FIRST = CreateFrame("Button", E.AddonTitle..LibOctopussy:func_GenerateUniqueID(), OctoToDo_FIRST_MainFrame, "SecureActionButtonTemplate, BackDropTemplate")
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
		end)
		local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
			Octo_ToDo_DB_Players[menuButton.value].isShownPLAYER = checked
		end
		local function func_remove_GUID(menuButton) -- ПОФИКСИТЬ
			Octo_ToDoDeleteChar(menuButton.value)
			Octo_ToDo_DB_Players[menuButton.value] = nil
		end
		dd_FIRST:ddSetInitFunc(function(self, level, value)
				local info, list = {}, {}
				local count = 0
				local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
				local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
				if level == 1 then
					local BnetList = {}
					local Octo_ToDo_BatlleNets = {}
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
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
							-- self:ddAddButton(info, level)
							tinsert(list, info)
						end
					else
						local curCharGUID, CharInfo = next(Octo_ToDo_DB_Players)
						value = CharInfo.BattleTagLocal
					end
				end
				self:ddAddButton({list = list, listMaxSize = 20}, level)
				if type(value) == "string" then
					local Octo_ToDo_DB_Players_LIST = {}
					for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
						if CharInfo.BattleTagLocal == value or not value then
							Octo_ToDo_DB_Players_LIST[CharInfo.curServer] = Octo_ToDo_DB_Players_LIST[CharInfo.curServer] or {}
							Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] = Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] or {}
							Octo_ToDo_DB_Players_LIST[CharInfo.curServer][curCharGUID] = CharInfo.classColorHex..CharInfo.Name.."|r".." "..CharInfo.UnitLevel
						end
					end
					for Server, v in next, (Octo_ToDo_DB_Players_LIST) do
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
						-- self:ddAddButton(info, level)
					end
					self:ddAddButton({list = list, listMaxSize = 20}, level)
				elseif type(value) == "table" then
					local players_list = {}
					for GUID, names in next, (value) do
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
					for _, GUID in next, (players_list) do
						local info = {}
						info.keepShownOnClick = true
						info.isNotRadio = true
						local vivod = Octo_ToDo_DB_Players[GUID].classColorHex..Octo_ToDo_DB_Players[GUID].Name.."|r"
						if Octo_ToDo_DB_Players[GUID].UnitLevel ~= E.currentMaxLevel then
							vivod = vivod.." "..E.Yellow_Color..Octo_ToDo_DB_Players[GUID].UnitLevel.."|r"
						end
						info.text = vivod
						info.value = GUID
						info.func = selectFunctionisShownPLAYER
						info.checked = Octo_ToDo_DB_Players[GUID].isShownPLAYER
						info.remove = func_remove_GUID
						info.removeDoNotHide = true
						tinsert(list, info)
						-- self:ddAddButton(info, level)
					end
					self:ddAddButton({list = list, listMaxSize = 20}, level)
				end
				if level == 1 then
					----------------------------------------------------------------
					self:ddAddSeparator(level)
					----------------------------------------------------------------
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current Server"]
					info.hasArrow = nil
					info.checked = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
					info.func = function(_, _, _, checked)
						Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = checked
						main_frame_toggle()
						C_Timer.After(.1, function()
								main_frame_toggle()
						end)
					end
					self:ddAddButton(info, level)
					----------------------------------------------------------------
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
							main_frame_toggle()
							C_Timer.After(.1, function()
									main_frame_toggle()
							end)
						end
						self:ddAddButton(info, level)
					end
					----------------------------------------------------------------
				end
		end)
	end
	if Octo_ToDo_DB_Vars.config.PortalsButtons == true then
		-- 423335 инжа КАЛА альянс
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
		if UnitLevel >= 20 then
			CreateFrameUsableItems(128807, LibOctopussy:GetItemIcon(128807), Xpos*-15+Ypos*15, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(200707, LibOctopussy:GetItemIcon(200707), Xpos*-14+Ypos*14, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187339, LibOctopussy:GetItemIcon(187339), Xpos*-13+Ypos*13, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187875, LibOctopussy:GetItemIcon(187875), Xpos*-12+Ypos*12, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187896, LibOctopussy:GetItemIcon(187896), Xpos*-11+Ypos*11, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187897, LibOctopussy:GetItemIcon(187897), Xpos*-10+Ypos*10, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187869, LibOctopussy:GetItemIcon(187869), Xpos*-9+Ypos*9, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187895, LibOctopussy:GetItemIcon(187895), Xpos*-8+Ypos*8, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187899, LibOctopussy:GetItemIcon(187899), Xpos*-7+Ypos*7, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187900, LibOctopussy:GetItemIcon(187900), Xpos*-6+Ypos*6, Ypos*-1, 0, .43, .86)
			CreateFrameUsableItems(187898, LibOctopussy:GetItemIcon(187898), Xpos*-5+Ypos*5, Ypos*-1, 0, .43, .86)
			if Faction == "Horde" then
				CreateFrameUsableItems(150745, LibOctopussy:GetItemIcon(150745), Xpos*-4+Ypos*4, Ypos*-1, 0, .43, .86) -- Horde East
			else
				CreateFrameUsableItems(150746, LibOctopussy:GetItemIcon(150746), Xpos*-4+Ypos*4, Ypos*-1, 0, .43, .86) -- ally East
			end
			if Faction == "Horde" then
				CreateFrameUsableItems(150744, LibOctopussy:GetItemIcon(150744), Xpos*-3+Ypos*3, Ypos*-1, 0, .43, .86) -- Horde Kalimd
			else
				CreateFrameUsableItems(150743, LibOctopussy:GetItemIcon(150743), Xpos*-3+Ypos*3, Ypos*-1, 0, .43, .86) -- ally Kalimd
			end
		end
		CreateFrameUsableSpells(431280, LibOctopussy:func_GetSpellIcon(431280), Xpos*-1+Ypos*1, Ypos*-1, 0, .43, .86)
		CreateFrameUsableSpells(460905, LibOctopussy:func_GetSpellIcon(460905), Xpos*-2+Ypos*2, Ypos*-1, 0, .43, .86)
		if prof1 == 202 or prof2 == 202 then
			CreateFrameUsableItems(198156, LibOctopussy:GetItemIcon(198156), Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 366254)
			CreateFrameUsableItems(172924, LibOctopussy:GetItemIcon(172924), Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 310542)
			if Faction == "Horde" then
				CreateFrameUsableItems(168808, LibOctopussy:GetItemIcon(168808), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 265807)
				CreateFrameUsableItems(168807, LibOctopussy:GetItemIcon(168807), Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 265807)
			else
				CreateFrameUsableItems(168808, LibOctopussy:GetItemIcon(168808), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 264492)
				CreateFrameUsableItems(168807, LibOctopussy:GetItemIcon(168807), Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 264492)
			end
			CreateFrameUsableItems(151652, LibOctopussy:GetItemIcon(151652), Xpos*4+Ypos*1, Ypos*5, 0, .43, .86, 264490)
			CreateFrameUsableItems(112059, LibOctopussy:GetItemIcon(112059), Xpos*5+Ypos*1, Ypos*6, 0, .43, .86, 264487)
			CreateFrameUsableItems(87215, LibOctopussy:GetItemIcon(87215), Xpos*6+Ypos*1, Ypos*7, 0, .43, .86, 264485)
			CreateFrameUsableItems(48933, LibOctopussy:GetItemIcon(48933), Xpos*7+Ypos*1, Ypos*8, 0, .43, .86, 264481)
			CreateFrameUsableItems(110560, LibOctopussy:GetItemIcon(110560), Xpos*8+Ypos*1, Ypos*9, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, LibOctopussy:GetItemIcon(6948), Xpos*9+Ypos*1, Ypos*10, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, LibOctopussy:GetItemIcon(140192), Xpos*10+Ypos*1, Ypos*11, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, LibOctopussy:func_GetSpellIcon(193753), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, LibOctopussy:func_GetSpellIcon(50977), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
				CreateFrameUsableSpells(53428, LibOctopussy:func_GetSpellIcon(53428), Xpos*13+Ypos*1, Ypos*13, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, LibOctopussy:func_GetSpellIcon(556), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, LibOctopussy:func_GetSpellIcon(126892), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, LibOctopussy:func_GetSpellIcon(265225), Xpos*12+Ypos*1, Ypos*13, 0, .43, .86)
			end
		else
			CreateFrameUsableItems(110560, LibOctopussy:GetItemIcon(110560), Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 6603)
			CreateFrameUsableItems(6948, LibOctopussy:GetItemIcon(6948), Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 6603)
			CreateFrameUsableItems(140192, LibOctopussy:GetItemIcon(140192), Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 6603)
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, LibOctopussy:func_GetSpellIcon(193753), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, LibOctopussy:func_GetSpellIcon(50977), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
				CreateFrameUsableSpells(53428, LibOctopussy:func_GetSpellIcon(53428), Xpos*5+Ypos*1, Ypos*5, 0, .43, .86)
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, LibOctopussy:func_GetSpellIcon(556), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, LibOctopussy:func_GetSpellIcon(126892), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86)
			end
			if RaceEnglish == "DarkIronDwarf" then
				CreateFrameUsableSpells(265225, LibOctopussy:func_GetSpellIcon(265225), Xpos*4+Ypos*1, Ypos*5, 0, .43, .86)
			end
		end
		if UnitLevel >= 20 then
			if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == false then
				for k, v in next, (E.OctoTable_Portals_MoP) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_WoD) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*3, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_Legion) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*4, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_BfA) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*5, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_SL) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*6, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_DF) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*7, (Ypos*k), 0, .43, .86)
				end
				for k, v in next, (E.OctoTable_Portals_DF_S3) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
				end
				if Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
					end
				end
				for k, v in next, (E.OctoTable_Spells_Other) do
					CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*10, (Ypos*k), 0, .43, .86)
				end
				if classFilename == "MAGE" and Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_Mage_Solo_Horde) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
					for k, v in next, (E.OctoTable_Portals_Mage_Group_Horde) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*12, (Ypos*k), 0, .43, .86)
					end
				end
				if classFilename == "MAGE" and Faction == "Alliance" then
					for k, v in next, (E.OctoTable_Portals_Mage_Solo_Alliance) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*11, (Ypos*k), 0, .43, .86)
					end
					for k, v in next, (E.OctoTable_Portals_Mage_Group_Alliance) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*12, (Ypos*k), 0, .43, .86)
					end
				end
			else
				if Faction == "Horde" then
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Horde) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
					end
				else
					for k, v in next, (E.OctoTable_Portals_TWW_S1_Alliance) do
						CreateFrameUsableSpells(v, LibOctopussy:func_GetSpellIcon(v), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
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
		OctoToDo_FIRST_MainFrame[fname] = CreateFrame("Frame", E.AddonTitle..LibOctopussy:func_GenerateUniqueID().."FrameLine"..i, OctoToDo_FIRST_MainFrame.scrollChild, "BackdropTemplate")
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
-- POOLS
----------------------------------------------------------------
local function resetPoolFunc(pool, f)
	f:Hide()
	f:ClearAllPoints()
end
local function resetPoolFunc_BG(pool, f)
	f:Hide()
	f.BG:Hide()
	f:ClearAllPoints()
end
----------------------------------------------------------------
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
----------------------------------------------------------------
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
----------------------------------------------------------------
function Octo_ToDo_FIRST_AddDataToAltFrame()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."Octo_ToDo_FIRST_AddDataToAltFrame".."|r")
	end
	local ShowOnlyCurrentServer = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag
	local LevelToShow = Octo_ToDo_DB_Vars.config.LevelToShow
	local LevelToShowMAX = Octo_ToDo_DB_Vars.config.LevelToShowMAX
	local itemLevelToShow = Octo_ToDo_DB_Vars.config.itemLevelToShow
	OctoToDo_FIRST_MainFrame.AllCharFrames = {}
	local sorted = {}
	for curCharGUID, CharInfo in next, (Octo_ToDo_DB_Players) do
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
	end)
	for GUID, CharInfo in next, (sorted) do
		local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
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
function TEST_FUNC()
	local testFrame = nil
	if not testFrame then
		testFrame = CreateFrame("FRAME")
		testFrame:Hide()
		if not testFrame.promise then
			testFrame.promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
			testFrame.promise:AddItems(E.OctoTable_itemID_ALL)
			-- testFrame.promise:AddItems(E.OctoTable_itemID_Config)
			-- testFrame.promise:AddItems(E.OctoTable_itemID_AutoOpen)
			-- testFrame.promise:AddItems(E.OctoTable_itemID_Ignore_List)
			-- testFrame.promise:AddItems(E.OctoTable_itemID_ItemsDelete)
			testFrame.promise:AddSpells(E.OctoTable_Portals_MoP)
			testFrame.promise:AddSpells(E.OctoTable_Portals_WoD)
			testFrame.promise:AddSpells(E.OctoTable_Portals_Legion)
			testFrame.promise:AddSpells(E.OctoTable_Portals_BfA)
			testFrame.promise:AddSpells(E.OctoTable_Portals_SL)
			testFrame.promise:AddSpells(E.OctoTable_Portals_DF)
			testFrame.promise:AddSpells(E.OctoTable_Portals_DF_S3)
			testFrame.promise:AddSpells(E.OctoTable_Portals_TWW_S1_Horde)
			testFrame.promise:AddSpells(E.OctoTable_Portals_TWW_S1_Alliance)
			testFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Solo_Horde)
			testFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Group_Horde)
			testFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Solo_Alliance)
			testFrame.promise:AddSpells(E.OctoTable_Portals_Mage_Group_Alliance)
			testFrame.promise:AddSpells(E.OctoTable_Portals_DRUID)
			testFrame.promise:AddSpells(E.OctoTable_Portals_DEATHKNIGHT)
			testFrame.promise:AddSpells(E.OctoTable_Portals_SHAMAN)
			testFrame.promise:AddSpells(E.OctoTable_Portals_MONK)
			testFrame.promise:AddQuests(E.OctoTable_QuestID)
			testFrame.promise:AddQuests(E.OctoTable_QuestID_Promise)
		end
	end
end
function main_frame_toggle()
	if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Blue_Color.."main_frame_toggle".."|r")
	end
	local button = LibDBIcon:GetMinimapButton(GlobalAddonName.."Octo_ToDo_FIRST_Minimap")
	if not OctoToDo_FIRST_MainFrame.promise then
		OctoToDo_FIRST_MainFrame.promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
		OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_ALL)
		-- OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_Config)
		-- OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_AutoOpen)
		-- OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_Ignore_List)
		-- OctoToDo_FIRST_MainFrame.promise:AddItems(E.OctoTable_itemID_ItemsDelete)
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
				-- LibOctopussy:START()
				button:Enable()
				Collect_ALL_PlayerInfo()
				Collect_All_Currency()
				Collect_All_Currency_TEST()
				Collect_All_Currency_TEST2()
				Collect_All_Reputations_TEST2()
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
				OLD_Collect_All_Holiday()
				OLD_Collect_BfA_Azerite()
				OLD_Collect_BfA_Cloaklvl()
				OLD_Collect_ALL_PVPRaitings()
				OLD_Collect_All_Legion_Transmoge()
				OLD_Collect_All_Legion_TransmogeNEW()
				OLD_Collect_BfA_QuestsBounties()
				OLD_Collect_BfA_Island()
				Hide_trash_frames()
				OctoToDo_FIRST_MainFrame:Show()
				Octo_ToDo_FIRST_AddDataToAltFrame()
				-- LibOctopussy:STOP()
		end)
	end
end







----------------------------------------------------------------
local Octo_EventFrame = CreateFrame("FRAME", "Octo_EventFrame")
for index, event in ipairs(E.OctoTable_Events) do
	Octo_EventFrame:RegisterEvent(event)
end
Octo_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
----------------------------------------------------------------
function Octo_EventFrame:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		print ("ADDON_LOADED")
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		--------------------------------
		E:ADDON_LOADED(GlobalAddonName)
		-- НАЧАЛО
		if profileKeys == nil then profileKeys = {} end
		if OctoPlayer == nil then OctoPlayer = {} end
		if Octo_ToDo_DB_Config == nil then Octo_ToDo_DB_Config = {} end
		if Octo_ToDo_DB_Players == nil then Octo_ToDo_DB_Players = {} end
		if Octo_ToDo_DB_Vars == nil then Octo_ToDo_DB_Vars = {} end
		if Octo_ToDo_DB_Other == nil then Octo_ToDo_DB_Other = {} end
		if Octo_ToDo_DB_Artifact == nil then Octo_ToDo_DB_Artifact = {} end
		if Octo_ToDo_DB_LegionArtifacts == nil then Octo_ToDo_DB_LegionArtifacts = {} end
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
		if Octo_ToDo_DB_Players_LIST == nil then Octo_ToDo_DB_Players_LIST = {} end
		if Octo_ToDo_Movies == nil then Octo_ToDo_Movies = {} end
		if Octo_ToDo_DB_Config.CurrencyDB == nil then Octo_ToDo_DB_Config.CurrencyDB = {} end
		if Octo_ToDo_DB_Config.ItemDB == nil then Octo_ToDo_DB_Config.ItemDB = {} end
		if Octo_ToDo_DB_Config.QuestsDB == nil then Octo_ToDo_DB_Config.QuestsDB = {} end
		if Octo_ToDo_DB_Config.ReputationDB == nil then Octo_ToDo_DB_Config.ReputationDB = {} end
		if Octo_ToDo_DB_Other.AccountMoney == nil then Octo_ToDo_DB_Other.AccountMoney = {} end
		if Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] == nil then Octo_ToDo_DB_Other.AccountMoney[BattleTagLocal] = 0 end
		if Octo_ToDo_DB_Other.CVar == nil then Octo_ToDo_DB_Other.CVar = {} end
		if Octo_ToDo_DB_Other.Holiday == nil then Octo_ToDo_DB_Other.Holiday = {} end
		if Octo_ToDo_DB_Other.Holiday.Active == nil then Octo_ToDo_DB_Other.Holiday.Active = {} end
		if Octo_ToDo_DB_Other.Holiday.Collect == nil then Octo_ToDo_DB_Other.Holiday.Collect = {} end
		if Octo_ToDo_DB_Other.Items == nil then Octo_ToDo_DB_Other.Items = {} end
		if Octo_ToDo_DB_Other.Items.Consumable == nil then Octo_ToDo_DB_Other.Items.Consumable = {} end
		if Octo_ToDo_DB_Other.LFGInstance == nil then Octo_ToDo_DB_Other.LFGInstance = {} end
		if Octo_ToDo_DB_Vars.config == nil then Octo_ToDo_DB_Vars.config = {} end
		if Octo_ToDo_DB_Vars.config.curWidthCentral == nil then Octo_ToDo_DB_Vars.config.curWidthCentral = 90 end
		if Octo_ToDo_DB_Vars.config.curWidthCentral ~= nil then E.curWidthCentral = Octo_ToDo_DB_Vars.config.curWidthCentral end
		if Octo_ToDo_DB_Vars.config.Addon_Height == nil then Octo_ToDo_DB_Vars.config.Addon_Height = 600 end
		if Octo_ToDo_DB_Vars.config.Addon_Height ~= nil then E.Addon_Height = Octo_ToDo_DB_Vars.config.Addon_Height end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST ~= nil then E.Octo_debug_BUTTONS_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND ~= nil then E.Octo_debug_BUTTONS_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_BUTTONS_SECOND end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST ~= nil then E.Octo_debug_Event_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Event_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND = true end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND ~= nil then E.Octo_debug_Event_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Event_SECOND end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST = false end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST ~= nil then E.Octo_debug_Function_FIRST = Octo_ToDo_DB_Vars.config.Octo_debug_Function_FIRST end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND == nil then Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND = false end
		if Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND ~= nil then E.Octo_debug_Function_SECOND = Octo_ToDo_DB_Vars.config.Octo_debug_Function_SECOND end
		if Octo_ToDo_DB_Vars.config.curHeight == nil then Octo_ToDo_DB_Vars.config.curHeight = 20 end
		if Octo_ToDo_DB_Vars.config.curHeight ~= nil then E.curHeight = Octo_ToDo_DB_Vars.config.curHeight end
		if Octo_ToDo_DB_Vars.config.curWidthTitle == nil then Octo_ToDo_DB_Vars.config.curWidthTitle = 200 end
		if Octo_ToDo_DB_Vars.config.curWidthTitle ~= nil then E.curWidthTitle = Octo_ToDo_DB_Vars.config.curWidthTitle end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement == nil then Octo_ToDo_DB_Vars.config.curWidthTitleAchievement = 300 end
		if Octo_ToDo_DB_Vars.config.curWidthTitleAchievement ~= nil then E.curWidthTitleAchievement = Octo_ToDo_DB_Vars.config.curWidthTitleAchievement end
		if Octo_ToDo_DB_Vars.config.Achievements == nil then Octo_ToDo_DB_Vars.config.Achievements = true end
		if Octo_ToDo_DB_Vars.config.AchievementShowCompleted == nil then Octo_ToDo_DB_Vars.config.AchievementShowCompleted = true end
		-- if Octo_ToDo_DB_Vars.config.AchievementToShow == nil then Octo_ToDo_DB_Vars.config.AchievementToShow = 92 end
		-- Octo_ToDo_DB_Vars.config.AchievementToShow = nil
		if Octo_ToDo_DB_Vars.config.AchievementToShow == nil then Octo_ToDo_DB_Vars.config.AchievementToShow = {} end
		-- if Octo_ToDo_DB_Vars.config.AchievementToShow[92] == nil then Octo_ToDo_DB_Vars.config.AchievementToShow[92] = true end
		if Octo_ToDo_DB_Vars.config.AdditionalButtons == nil then Octo_ToDo_DB_Vars.config.AdditionalButtons = true end
		if Octo_ToDo_DB_Vars.config.AidingtheAccord == nil then Octo_ToDo_DB_Vars.config.AidingtheAccord = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsCasual == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsCasual = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsDUNG = true end
		if Octo_ToDo_DB_Vars.config.AnotherAddonsRAID == nil then Octo_ToDo_DB_Vars.config.AnotherAddonsRAID = true end
		if Octo_ToDo_DB_Vars.config.Auto_ChatClearing == nil then Octo_ToDo_DB_Vars.config.Auto_ChatClearing = false end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicCanceler = true end
		if Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip == nil then Octo_ToDo_DB_Vars.config.Auto_CinematicFastSkip = true end
		if Octo_ToDo_DB_Vars.config.Auto_Gossip == nil then Octo_ToDo_DB_Vars.config.Auto_Gossip = true end
		if Octo_ToDo_DB_Vars.config.Auto_Screenshot == nil then Octo_ToDo_DB_Vars.config.Auto_Screenshot = true end
		if Octo_ToDo_DB_Vars.config.AutoGossip == nil then Octo_ToDo_DB_Vars.config.AutoGossip = true end
		if Octo_ToDo_DB_Vars.config.AutoOpen == nil then Octo_ToDo_DB_Vars.config.AutoOpen = true end
		if Octo_ToDo_DB_Vars.config.AutoRepair == nil then Octo_ToDo_DB_Vars.config.AutoRepair = true end
		if Octo_ToDo_DB_Vars.config.AutoSellGrey == nil then Octo_ToDo_DB_Vars.config.AutoSellGrey = true end
		if Octo_ToDo_DB_Vars.config.AutoTurnQuests == nil then Octo_ToDo_DB_Vars.config.AutoTurnQuests = true end
		if Octo_ToDo_DB_Vars.config.BeledarCycle == nil then Octo_ToDo_DB_Vars.config.BeledarCycle = true end
		if Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.CarvedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame == nil then Octo_ToDo_DB_Vars.config.ChallengesKeystoneFrame = true end
		if Octo_ToDo_DB_Vars.config.CinematicCanceler == nil then Octo_ToDo_DB_Vars.config.CinematicCanceler = true end
		if Octo_ToDo_DB_Vars.config.Currency == nil then Octo_ToDo_DB_Vars.config.Currency = true end
		if Octo_ToDo_DB_Vars.config.CurrencyShowAllways == nil then Octo_ToDo_DB_Vars.config.CurrencyShowAllways = false end
		if Octo_ToDo_DB_Vars.config.CVar == nil then Octo_ToDo_DB_Vars.config.CVar = true end
		if Octo_ToDo_DB_Vars.config.Dungeons == nil then Octo_ToDo_DB_Vars.config.Dungeons = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Dreamseeds = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Rares == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Rares = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Sparks = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_Storyline = true end
		if Octo_ToDo_DB_Vars.config.EmeraldDream_WB == nil then Octo_ToDo_DB_Vars.config.EmeraldDream_WB = true end
		if Octo_ToDo_DB_Vars.config.Event == nil then Octo_ToDo_DB_Vars.config.Event = true end
		if Octo_ToDo_DB_Vars.config.ExpansionToShow == nil then Octo_ToDo_DB_Vars.config.ExpansionToShow = LibOctopussy:func_CurrentExpansion() end
		if Octo_ToDo_DB_Vars.config.FieldOfView == nil then Octo_ToDo_DB_Vars.config.FieldOfView = false end
		if Octo_ToDo_DB_Vars.config.FoV_bottom == nil then Octo_ToDo_DB_Vars.config.FoV_bottom = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_left == nil then Octo_ToDo_DB_Vars.config.FoV_left = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_right == nil then Octo_ToDo_DB_Vars.config.FoV_right = 0 end
		if Octo_ToDo_DB_Vars.config.FoV_top == nil then Octo_ToDo_DB_Vars.config.FoV_top = 0 end
		if Octo_ToDo_DB_Vars.config.FrameScale == nil then Octo_ToDo_DB_Vars.config.FrameScale = 1 end
		if Octo_ToDo_DB_Vars.config.GameMenuFrameScale == nil then Octo_ToDo_DB_Vars.config.GameMenuFrameScale = .8 end
		if Octo_ToDo_DB_Vars.config.GildedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.GildedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.GlobalFadePersist == nil then Octo_ToDo_DB_Vars.config.GlobalFadePersist = true end
		if Octo_ToDo_DB_Vars.config.glowColor == nil then Octo_ToDo_DB_Vars.config.glowColor = 1 end
		if Octo_ToDo_DB_Vars.config.glowType == nil then Octo_ToDo_DB_Vars.config.glowType = 1 end
		if Octo_ToDo_DB_Vars.config.Gold == nil then Octo_ToDo_DB_Vars.config.Gold = true end
		if Octo_ToDo_DB_Vars.config.Professions == nil then Octo_ToDo_DB_Vars.config.Professions = true end
		if Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI == nil then Octo_ToDo_DB_Vars.config.Hide_AzeriteEmpoweredItemUI = true end
		if Octo_ToDo_DB_Vars.config.Hide_Boss_Banner == nil then Octo_ToDo_DB_Vars.config.Hide_Boss_Banner = true end
		if Octo_ToDo_DB_Vars.config.Hide_Covenant == nil then Octo_ToDo_DB_Vars.config.Hide_Covenant = true end
		if Octo_ToDo_DB_Vars.config.Hide_Error_Messages == nil then Octo_ToDo_DB_Vars.config.Hide_Error_Messages = true end
		if Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance == nil then Octo_ToDo_DB_Vars.config.Hide_ObjectivesInInstance = true end
		if Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar == nil then Octo_ToDo_DB_Vars.config.Hide_OrderHallCommandBar = true end
		if Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Raid_Boss_Emote_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame == nil then Octo_ToDo_DB_Vars.config.Hide_RaidWarningFrame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame == nil then Octo_ToDo_DB_Vars.config.Hide_Talking_Head_Frame = true end
		if Octo_ToDo_DB_Vars.config.Hide_Zone_Text == nil then Octo_ToDo_DB_Vars.config.Hide_Zone_Text = true end
		if Octo_ToDo_DB_Vars.config.Holiday == nil then Octo_ToDo_DB_Vars.config.Holiday = true end
		if Octo_ToDo_DB_Vars.config.InputDelete == nil then Octo_ToDo_DB_Vars.config.InputDelete = true end
		if Octo_ToDo_DB_Vars.config.ItemLevel == nil then Octo_ToDo_DB_Vars.config.ItemLevel = true end
		if Octo_ToDo_DB_Vars.config.itemLevelToShow == nil then Octo_ToDo_DB_Vars.config.itemLevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.Items == nil then Octo_ToDo_DB_Vars.config.Items = true end
		if Octo_ToDo_DB_Vars.config.ItemsDelete == nil then Octo_ToDo_DB_Vars.config.ItemsDelete = false end
		if Octo_ToDo_DB_Vars.config.ItemsShowAllways == nil then Octo_ToDo_DB_Vars.config.ItemsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.ItemsUsable == nil then Octo_ToDo_DB_Vars.config.ItemsUsable = false end
		if Octo_ToDo_DB_Vars.config.LastUpdate == nil then Octo_ToDo_DB_Vars.config.LastUpdate = true end
		if Octo_ToDo_DB_Vars.config.LevelToShow == nil then Octo_ToDo_DB_Vars.config.LevelToShow = 1 end
		if Octo_ToDo_DB_Vars.config.LevelToShowMAX == nil then Octo_ToDo_DB_Vars.config.LevelToShowMAX = E.currentMaxLevel end
		-- if Octo_ToDo_DB_Vars.config.LevelToShowMAX > E.currentMaxLevel then Octo_ToDo_DB_Vars.config.LevelToShowMAX = E.currentMaxLevel end
		if Octo_ToDo_DB_Vars.config.LootFrame == nil then Octo_ToDo_DB_Vars.config.LootFrame = true end
		if Octo_ToDo_DB_Vars.config.MajorKeyflames == nil then Octo_ToDo_DB_Vars.config.MajorKeyflames = true end
		if Octo_ToDo_DB_Vars.config.Minecraft == nil then Octo_ToDo_DB_Vars.config.Minecraft = false end
		if Octo_ToDo_DB_Vars.config.MinorKeyflames == nil then Octo_ToDo_DB_Vars.config.MinorKeyflames = true end
		if Octo_ToDo_DB_Vars.config.MP_MythicKeystone == nil then Octo_ToDo_DB_Vars.config.MP_MythicKeystone = true end
		if Octo_ToDo_DB_Vars.config.PortalsButtons == nil then Octo_ToDo_DB_Vars.config.PortalsButtons = true end
		if Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent == nil then Octo_ToDo_DB_Vars.config.PortalsButtonsOnlyCurrent = false end
		if Octo_ToDo_DB_Vars.config.prefix == nil then Octo_ToDo_DB_Vars.config.prefix = 1 end
		if Octo_ToDo_DB_Vars.config.Quests == nil then Octo_ToDo_DB_Vars.config.Quests = true end
		if Octo_ToDo_DB_Vars.config.QuestsShowAllways == nil then Octo_ToDo_DB_Vars.config.QuestsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.Reputations == nil then Octo_ToDo_DB_Vars.config.Reputations = true end
		if Octo_ToDo_DB_Vars.config.ReputationsShowAllways == nil then Octo_ToDo_DB_Vars.config.ReputationsShowAllways = false end
		if Octo_ToDo_DB_Vars.config.ResetAllChars == nil then Octo_ToDo_DB_Vars.config.ResetAllChars = true end
		if Octo_ToDo_DB_Vars.config.RunedHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.RunedHarbingerCrest = true end
		if Octo_ToDo_DB_Vars.config.ShowIDS == nil then Octo_ToDo_DB_Vars.config.ShowIDS = true end
		if Octo_ToDo_DB_Vars.config.SpeedFrame == nil then Octo_ToDo_DB_Vars.config.SpeedFrame = {} end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.Shown == nil then Octo_ToDo_DB_Vars.config.SpeedFrame.Shown = true end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.point == nil then Octo_ToDo_DB_Vars.config.SpeedFrame.point = "BOTTOM" end
		-- Octo_ToDo_DB_Vars.config.SpeedFrame.relativeTo = nil
		if Octo_ToDo_DB_Vars.config.SpeedFrame.relativePoint == nil then Octo_ToDo_DB_Vars.config.SpeedFrame.relativePoint = "BOTTOM" end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.xOfs == nil then Octo_ToDo_DB_Vars.config.SpeedFrame.xOfs = 129 end
		if Octo_ToDo_DB_Vars.config.SpeedFrame.yOfs == nil then Octo_ToDo_DB_Vars.config.SpeedFrame.yOfs = 67 end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentBattleTag = false end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentRealm = true end
		if Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer == nil then Octo_ToDo_DB_Vars.config.ShowOnlyCurrentServer = true end
		if Octo_ToDo_DB_Vars.config.ShowTime70 == nil then Octo_ToDo_DB_Vars.config.ShowTime70 = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeAll == nil then Octo_ToDo_DB_Vars.config.ShowTimeAll = true end
		if Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL == nil then Octo_ToDo_DB_Vars.config.ShowTimeMAXLEVEL = true end
		if Octo_ToDo_DB_Vars.config.ShowTotalMoney == nil then Octo_ToDo_DB_Vars.config.ShowTotalMoney = true end
		if Octo_ToDo_DB_Vars.config.SORTING == nil then Octo_ToDo_DB_Vars.config.SORTING = true end
		if Octo_ToDo_DB_Vars.config.StaticPopup1Button1 == nil then Octo_ToDo_DB_Vars.config.StaticPopup1Button1 = true end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks = true end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Alpha = 1 end
		if Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale == nil then Octo_ToDo_DB_Vars.config.TalentTreeTweaks_Scale = 1 end
		if Octo_ToDo_DB_Vars.config.TheBigDig == nil then Octo_ToDo_DB_Vars.config.TheBigDig = true end
		if Octo_ToDo_DB_Vars.config.TheBigDig_REPUTATION == nil then Octo_ToDo_DB_Vars.config.TheBigDig_REPUTATION = true end
		if Octo_ToDo_DB_Vars.config.THIRD == nil then Octo_ToDo_DB_Vars.config.THIRD = true end
		if Octo_ToDo_DB_Vars.config.Timewalk == nil then Octo_ToDo_DB_Vars.config.Timewalk = true end
		if Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_Delve_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_DungeonQuest_Weekly = true end
		if Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly == nil then Octo_ToDo_DB_Vars.config.TWW_WorldBoss_Weekly = true end
		if Octo_ToDo_DB_Vars.config.UIErrorsFramePosition == nil then Octo_ToDo_DB_Vars.config.UIErrorsFramePosition = true end
		if Octo_ToDo_DB_Vars.config.WasOnline == nil then Octo_ToDo_DB_Vars.config.WasOnline = true end
		if Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest == nil then Octo_ToDo_DB_Vars.config.WeatheredHarbingerCrest = true end
		-- КОНЕЦ
		for classFilename, v in pairs(E.OctoTable_CLASS_ARTIFACT_DATA) do
			for itemID in pairs(E.OctoTable_CLASS_ARTIFACT_DATA[classFilename]) do
				local artifactData = E.OctoTable_CLASS_ARTIFACT_DATA[classFilename][itemID]
				-- local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
				for index, data in pairs(artifactData.sets) do
					local appearanceID = data.appearanceID
					local sourceID = data.sourceID
					local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
					local visualID = sourceInfo.visualID
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
				end
			end
		end
		ConcatAtStart()
		O_otrisovka_FIRST()
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
							main_frame_toggle()
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
				end,
				OnEnter = function(self)
					TEST_FUNC()
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					GameTooltip_SetTitle(GameTooltip, LibOctopussy:func_Gradient(GlobalAddonName).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDo_DB_Vars.minimap_FIRST = Octo_ToDo_DB_Vars.minimap_FIRST or {}
		Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos = Octo_ToDo_DB_Vars.minimap_FIRST.minimapPos or 244
		Octo_ToDo_DB_Vars.config.AddonVersion = tonumber(E.AddonVersion)
		LibDBIcon:Register(MinimapName, ldb_icon, Octo_ToDo_DB_Vars.minimap_FIRST)
		LibDBIcon:Show(MinimapName)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_ENTERING_WORLD()
	if not InCombatLockdown() then
		print ("QWE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.PLAYER_ENTERING_WORLD = nil
		--------------------------------
		Collect_ALL_LoginTime()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_All_journalInstance()
		Hide_trash_frames()
		Collect_All_PlayerDurability()
		OLD_Collect_All_Holiday()
		Collect_All_Covenant()
		Collect_WarMode()
		Collect_ALL_Mail()
		-- OLD_Collect_All_Legion_Transmoge()
		-- -- OLD_Collect_All_Legion_TransmogeNEW()
		GameMenuFrame:SetScale(Octo_ToDo_DB_Vars.config.GameMenuFrameScale or 1)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_LOGIN()
	if not InCombatLockdown() then
		print ("QWE")
		self:UnregisterEvent("PLAYER_LOGIN")
		self.PLAYER_LOGIN = nil
		--------------------------------
		C_WowTokenPublic.UpdateMarketPrice()
		Octo_ToDo_DB_Players[curGUID] = Octo_ToDo_DB_Players[curGUID] or {}
		local count = 0
		for GUID, CharInfo in next, (Octo_ToDo_DB_Players) do
			count = count + 1
			-- print (count, GUID, CharInfo)
			checkCharInfo(CharInfo, GUID)
		end
		Collect_ALL_PlayerInfo()
		Collect_All_Currency()
		Collect_All_Currency_TEST2()
		Collect_All_Reputations_TEST2()
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
		OLD_Collect_All_Holiday()
		OLD_Collect_BfA_Azerite()
		OLD_Collect_BfA_Cloaklvl()
		OLD_Collect_ALL_PVPRaitings()
		OLD_Collect_All_Legion_Transmoge()
		OLD_Collect_All_Legion_TransmogeNEW()
		OLD_Collect_BfA_QuestsBounties()
		OLD_Collect_BfA_Island()
		RequestTimePlayed()
		Octo_ToDo_FIRST_CreateAltFrame()
		Hide_trash_frames()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		--------------------------------
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			ChatFrame1:AddMessage(LibOctopussy:func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end
----------------------------------------------------------------
function Octo_EventFrame:SKILL_LINES_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_Professions()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_XP_UPDATE()
	if not InCombatLockdown() then
		--------------------------------
		Collect_Player_Level()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_ACCEPTED()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_COMPLETE()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_FINISHED()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_LOG_UPDATE()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_REMOVED()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_TURNED_IN()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:QUEST_LOOT_RECEIVED()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_Quests()
				Collect_ALL_UNIVERSALQuestUpdate()
				OLD_Collect_BfA_Island()
				OLD_Collect_BfA_QuestsBounties()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_MONEY()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_MoneyUpdate()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ACCOUNT_MONEY()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_MoneyUpdate()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:CURRENCY_DISPLAY_UPDATE()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_Currency()
		Collect_All_Currency_TEST2()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_EQUIPMENT_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemLevel()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_LEAVING_WORLD()
	if not InCombatLockdown() then
		self:UnregisterEvent("PLAYER_LEAVING_WORLD")
		self.PLAYER_LEAVING_WORLD = nil
		--------------------------------
		Collect_ALL_GreatVault()
		Collect_ALL_LoginTime()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		OLD_Collect_BfA_Azerite()
		OLD_Collect_BfA_Cloaklvl()
	end
end

----------------------------------------------------------------
function Octo_EventFrame:COVENANT_CHOSEN()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_Covenant()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_Covenant()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_DEAD()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_PlayerDurability()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:UPDATE_INVENTORY_DURABILITY()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_PlayerDurability()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemsInBag()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:BAG_UPDATE_DELAYED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemsInBag()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ZONE_CHANGED_NEW_AREA()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemsInBag()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ITEM_COUNT_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemsInBag()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:MAIL_SEND_SUCCESS()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_ItemsInBag()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_SPECIALIZATION_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_PlayerInfo()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:HEARTHSTONE_BOUND()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_Locations()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ZONE_CHANGED_NEW_AREA()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_Locations()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:SPELLS_CHANGED()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(2, function()
				Collect_WarMode()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:MAIL_INBOX_UPDATE()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_Mail()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:MAIL_SHOW()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_Mail()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:UPDATE_PENDING_MAIL()
	if not InCombatLockdown() then
		--------------------------------
		Collect_ALL_Mail()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:PLAYER_REGEN_DISABLED()
	if addonName == GlobalAddonName and InCombatLockdown() then
		--------------------------------
		if OctoToDo_FIRST_MainFrame and OctoToDo_FIRST_MainFrame:IsShown() then
			OctoToDo_FIRST_MainFrame:Hide()
		end
	end
end
----------------------------------------------------------------
function Octo_EventFrame:READY_CHECK()
	if not InCombatLockdown() then
		--------------------------------
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ENCOUNTER_END()
	if not InCombatLockdown() then
		--------------------------------
		C_Timer.After(1, function()
				Collect_All_journalInstance()
		end)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:TIME_PLAYED_MSG()
	if not InCombatLockdown() then
		--------------------------------
		-- Collect_Played(...)
	end
end
----------------------------------------------------------------
function Octo_EventFrame:LFG_UPDATE_RANDOM_INFO()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_journalInstance()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:LFG_COMPLETION_REWARD()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_journalInstance()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:ENCOUNTER_LOOT_RECEIVED()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_journalInstance()
	end
end
----------------------------------------------------------------
function Octo_EventFrame:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if not InCombatLockdown() then
		--------------------------------
		Collect_All_journalInstance()
	end
end








Octo_ToDo_FIRST_OnLoad()
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		main_frame_toggle()
	end
end
local editFrame, editBox = _G[GlobalAddonName.."EditFrame"], _G[GlobalAddonName.."EditFrame"].editFrame
SLASH_GSEARCH1, SLASH_GSEARCH2 = "/gsearch", "/gs"
SlashCmdList.GSEARCH = function(msg)
	ChatFrame1:AddMessage (LibOctopussy:func_Gradient("GSEARCH: ") .. msg)
	local str = ""
	local list = {}
	for i, n in next, (_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..LibOctopussy:func_Gradient(i).. " - ".. n .."\n"
		end
	end
	editBox:SetText(str)
	editFrame:Show()
end
SlashCmdList["RELOAD"] = LibOctopussy:ReloadUI()
SLASH_RELOAD1 = "/rl"
SLASH_FRAMESTK1 = "/fs"
SlashCmdList.FRAMESTK = function(msg)
	if not LibOctopussy:IsAddOnLoaded("Blizzard_DebugTools") then LibOctopussy:LoadAddOn("Blizzard_DebugTools") end
	local showHidden, showRegions, showAnchors = (msg == "true"), true, true
	FrameStackTooltip_Toggle(showHidden, showRegions, showAnchors)
end
