local GlobalAddonName, E = ...
OctoToDo_ToDO_E = E
local OctoToDo_EventFrame_OCTOMAIN = CreateFrame("FRAME")
OctoToDo_EventFrame_OCTOMAIN:Hide()
-- G:\World of Warcraft\MyAddons, -G:\World of Warcraft\MyAddons\OctoToDo\Libs, -G:\World of Warcraft\MyAddons\.git,-G:\World of Warcraft\MyAddons\.vscode
----------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
LibSFDropDown:CreateMenuStyle(GlobalAddonName, function(parent)
		local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
		f:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		f:SetPoint("TOPLEFT", 8, -2)
		f:SetPoint("BOTTOMRIGHT", -8, 2)
		f:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
		f:SetBackdropBorderColor(0, 0, 0, 1)
		return f
end)
----------------------------------------------------------------
----------------------------------------------------------------
-- E.func_LoadAddOn("OctoToDo_Achievements")
E.func_LoadAddOn("OctoToDo_AddonsManager")
-- E.func_LoadAddOn("OctoToDo_Minecraft")
E.func_LoadAddOn("OctoToDo_TrashCan")
E.func_LoadAddOn("!BugGrabber")
E.func_LoadAddOn("BugSack")
E.func_LoadAddOn("MountsJournal")
E.func_LoadAddOn("HidingBar")
E.func_LoadAddOn("HidingBar_Options")
E.func_LoadAddOn("SpeedyAutoLoot")
-- E.func_LoadAddOn("SimpleAddonManager")
-- E.func_LoadAddOn("TalentTreeTweaks")
-- E.func_LoadAddOn("Plater")
-- E.func_LoadAddOn("MacroManager")
-- E.func_LoadAddOn("MacroManagerData")
-- E.func_LoadAddOn("SilverDragon")
-- E.func_LoadAddOn("SilverDragon_History")
-- E.func_LoadAddOn("SilverDragon_Overlay")
-- E.func_LoadAddOn("SilverDragon_RangeExtender")
-- E.func_LoadAddOn("TomTom")
-- E.func_LoadAddOn("Pawn")
-- E.func_LoadAddOn("MySlot")
-- E.func_LoadAddOn("QuestsChanged")
-- E.func_LoadAddOn("AdvancedInterfaceOptions")
----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOMAIN:ConcatAtStart()
	E.func_TableConcat(E.OctoTable_QuestID, E.OctoTable_QuestID_Paragon)
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
		OctoToDo_DB_Config.CurrencyDB[currencyID] = OctoToDo_DB_Config.CurrencyDB[currencyID] or false
	end
	for _, reputationID in next, (E.OctoTable_reputationID_Hidden) do
		OctoToDo_DB_Config.ReputationDB[reputationID] = OctoToDo_DB_Config.ReputationDB[reputationID] or false
	end
	for _, reputationID in next, (E.OctoTable_reputation_ALL) do
		OctoToDo_DB_Config.ReputationDB[reputationID] = OctoToDo_DB_Config.ReputationDB[reputationID] or false
	end
	for _, questID in next, (E.OctoTable_QuestID) do
		OctoToDo_DB_Config.QuestsDB[questID] = OctoToDo_DB_Config.QuestsDB[questID] or false
	end
end
function E:func_checkCharInfo()
	local Meta_Table_0 = {__index = function() return 0 end}
	local Meta_Table_1 = {__index = function() return 1 end}
	local Meta_Table_false = {__index = function() return false end}
	local Meta_Table_true = {__index = function() return true end}
	local Meta_Table_DONE = {__index = function() return E.DONE end}
	local Meta_Table_NONE = {__index = function() return E.NONE end}
	local Meta_Table_EmptyString = {__index = function() return "" end}
	OctoToDo_DB_Levels[E.curGUID] = OctoToDo_DB_Levels[E.curGUID] or {}
	if OctoToDo_DB_Levels then
		for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
			local localizedClass, englishClass, localizedRace, englishRace, _, name = GetPlayerInfoByGUID(GUID)
			if CharInfo.journalInstance == nil then CharInfo.journalInstance = {} end
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
			if CharInfo.SavedWorldBoss == nil then CharInfo.SavedWorldBoss = {} end
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
			CharInfo.MASLENGO.Quests = CharInfo.MASLENGO.Quests or {}
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
			CharInfo.ReloadCount = CharInfo.ReloadCount or 0
			CharInfo.PVP = CharInfo.PVP or {}
			CharInfo.avgItemLevel = CharInfo.avgItemLevel or 1
			CharInfo.avgItemLevelEquipped = CharInfo.avgItemLevelEquipped or 1
			CharInfo.azeriteEXP = CharInfo.azeriteEXP or 0
			CharInfo.azeriteLVL = CharInfo.azeriteLVL or 0
			CharInfo.avgItemLevelPvp = CharInfo.avgItemLevelPvp or 1
			CharInfo.className = CharInfo.className or E.className
			CharInfo.classFilename = CharInfo.classFilename or E.classFilename
			CharInfo.GUID = CharInfo.GUID or GUID
			CharInfo.cloak_lvl = CharInfo.cloak_lvl or 0
			CharInfo.cloak_res = CharInfo.cloak_res or 0
			CharInfo.classId = CharInfo.classId or 1
			CharInfo.classColor = CharInfo.classColor or E.classColor
			CharInfo.curServer = CharInfo.curServer or E.curServer
			CharInfo.guildName = CharInfo.guildName or ""
			CharInfo.guildRankName = CharInfo.guildRankName or ""
			CharInfo.guildRankIndex = CharInfo.guildRankIndex or 0
			CharInfo.curServerShort = CharInfo.curServerShort or E.func_CurServerShort(E.curServer)
			CharInfo.Faction = CharInfo.Faction or "Horde"
			CharInfo.BattleTag = CharInfo.BattleTag or E.BattleTag
			CharInfo.BattleTagLocal = CharInfo.BattleTagLocal or E.BattleTagLocal
			CharInfo.IsPublicBuild = CharInfo.IsPublicBuild or E.IsPublicBuild
			CharInfo.Chromie_canEnter = CharInfo.Chromie_canEnter or false
			CharInfo.Chromie_UnitChromieTimeID = CharInfo.Chromie_UnitChromieTimeID or 0
			CharInfo.Chromie_name = CharInfo.Chromie_name or ""
			CharInfo.GameLimitedMode_IsActive = CharInfo.GameLimitedMode_IsActive or E.GameLimitedMode_IsActive
			if CharInfo.levelCapped20 == nil then
				CharInfo.levelCapped20 = false
			end
			if CharInfo.PlayerCanEarnExperience == nil then
				CharInfo.PlayerCanEarnExperience = true
			end
			CharInfo.buildVersion = CharInfo.buildVersion or E.buildVersion
			CharInfo.buildNumber = CharInfo.buildNumber or E.buildNumber
			CharInfo.buildDate = CharInfo.buildDate or E.buildDate
			CharInfo.interfaceVersion = CharInfo.interfaceVersion or E.interfaceVersion
			CharInfo.currentTier = CharInfo.currentTier or E.currentTier
			CharInfo.IsAccountSecured = CharInfo.IsAccountSecured or E.IsAccountSecured
			CharInfo.GetRestrictedAccountData_rLevel = CharInfo.GetRestrictedAccountData_rLevel or E.GetRestrictedAccountData_rLevel
			CharInfo.GetRestrictedAccountData_rMoney = CharInfo.GetRestrictedAccountData_rMoney or E.GetRestrictedAccountData_rMoney
			CharInfo.GetRestrictedAccountData_profCap = CharInfo.GetRestrictedAccountData_profCap or E.GetRestrictedAccountData_profCap
			CharInfo.IsTrialAccount = CharInfo.IsTrialAccount or E.IsTrialAccount
			CharInfo.IsVeteranTrialAccount = CharInfo.IsVeteranTrialAccount or E.IsVeteranTrialAccount
			CharInfo.PlayerDurability = CharInfo.PlayerDurability or 100
			CharInfo.maxNumQuestsCanAccept = CharInfo.maxNumQuestsCanAccept or 0
			CharInfo.Name = CharInfo.Name or E.curCharName
			CharInfo.numQuests = CharInfo.numQuests or 0
			CharInfo.RaceLocal = CharInfo.RaceLocal or localizedRace
			CharInfo.RaceEnglish = CharInfo.RaceEnglish or englishRace
			CharInfo.raceID = CharInfo.raceID or 0
			CharInfo.classColorHex = CharInfo.classColorHex or E.classColorHexCurrent
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
			CharInfo.CurrentKey = CharInfo.CurrentKey or 0
			CharInfo.CurrentKeyName = CharInfo.CurrentKeyName or 0
			CharInfo.CurrentKeyLevel = CharInfo.CurrentKeyLevel or 0
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
			CharInfo.RIO_Score_TWW_S2 = CharInfo.RIO_Score_TWW_S2 or 0
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
				CharInfo.CurrentKeyName = 0
				CharInfo.CurrentKeyLevel = 0
				CharInfo.journalInstance = {}
				CharInfo.SavedWorldBoss = {}
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local AddonHeight = 20 -- Высота -- OctoToDo_DB_Vars.curHeight
local AddonRightFrameWeight = 90 -- Ширина Центрального -- OctoToDo_DB_Vars.curWidthCentral
local AddonLeftFrameWeight = 200 -- Ширина Левого -- OctoToDo_DB_Vars.curWidthTitle
local PhysicalScreenWidth, PhysicalScreenHeight = GetPhysicalScreenSize()
local NumberOfLines = math.floor((math.floor(PhysicalScreenHeight / AddonHeight))*.7)
-- дефолт 30
local MainFrameNumLines = 30
if MainFrameNumLines > NumberOfLines then
	MainFrameNumLines = NumberOfLines
end
----------------------------------------------------------------
local function func_NumPlayers()
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = OctoToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = OctoToDo_DB_Vars.LevelToShowMAX
	local itemLevelToShow = OctoToDo_DB_Vars.itemLevelToShow
	local sorted = {}
	for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == E.curServer)
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == E.curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	return #sorted or 1
end
local function OnENTERTTOOLTIP(f)
	if not f.tooltip then
		return
	elseif #f.tooltip == 0 then
		return
	end
	GameTooltip:SetOwner(f, "ANCHOR_BOTTOMRIGHT", 0, 0)
	GameTooltip:AddLine(" ")
	for _, v in next, (f.tooltip) do
		GameTooltip:AddDoubleLine(v[1], v[2], 1, 1, 1, 1, 1, 1)
	end
	GameTooltip:AddLine(" ")
	GameTooltip:Show()
end
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ
local function func_OnAcquired(owner, frame, data, new)
	if new then
		frame.first = CreateFrame("FRAME", nil, frame, "BackDropTemplate")
		frame.first:SetPropagateMouseClicks(false)
		frame.first:SetSize(AddonHeight, AddonHeight)
		frame.first:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.first.icon = frame:CreateTexture(nil, "BACKGROUND", nil, -2) -- ПОФИКСИТЬ -- https://warcraft.wiki.gg/wiki/API_Frame_CreateTexture --https://warcraft.wiki.gg/wiki/API_Frame_CreateMaskTexture
		frame.first.icon:SetAllPoints(frame.first)
		frame.first.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		------------------------------------------------
		frame.left = CreateFrame("FRAME", "frame.left", frame, "BackdropTemplate")
		frame.left:SetPropagateMouseClicks(true)
		frame.left:SetSize(AddonLeftFrameWeight, AddonHeight)
		frame.left:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.left:SetFrameLevel(frame:GetFrameLevel()-1)
		frame.left.text = frame.left:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		frame.left.text:SetPoint("LEFT", AddonHeight+1, 0)
		frame.left.text:SetPoint("RIGHT", 0, 0)
		frame.left.text:SetFontObject(OctoFont11)
		frame.left.text:SetWordWrap(false)
		frame.left.text:SetJustifyV("MIDDLE")
		frame.left.text:SetJustifyH("LEFT")
		frame.left.text:SetTextColor(1, 1, 1, 1)
		------------------------------------------------
		frame.cent  = setmetatable({}, {
				__index = function(self, key)
					local f = CreateFrame("FRAME", "frame"..key, frame, "BackdropTemplate")
					f:SetPropagateMouseClicks(true)
					f:SetSize(AddonRightFrameWeight, AddonHeight)
					f:SetPoint("TOPLEFT", frame.left, "TOPLEFT", (AddonLeftFrameWeight-AddonRightFrameWeight)+(AddonRightFrameWeight*key), 0)
					f.text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
					f.text:SetAllPoints()
					f.text:SetFontObject(OctoFont11)
					f.text:SetJustifyV("MIDDLE")
					f.text:SetJustifyH("CENTER")
					f.text:SetTextColor(1, 1, 1, 1)
					f:SetScript("OnEnter", OnENTERTTOOLTIP)
					f:SetScript("OnLeave", GameTooltip_Hide)
					f:SetScript("OnHide", f.Hide)
					self[key] = f
					return f
		end})
		------------------------------------------------
	end
end
-- ОТРИСОВЫВАЕТ ДАННЫЕ НА КНОПКЕ
local function OctoToDo_Frame_init(frame, data)
	if data.firsticonTexture ~= E.Icon_Empty then
		frame.first.icon:SetTexture(data.firsticonTexture)
	end
	frame.left.text:SetText(data.left)
	if data.index % 2 == 0 then
		E:func_SetBackdrop(frame.left, nil, 0, 0)
	else
		E:func_SetBackdrop(frame.left, "|cff000000", E.bgCaOverlay, 0)
	end
	E:func_SetBackdrop(frame.left, data.BGcolor, E.bgCaOverlay, 0)
	for NumPlayers = 1, #data do
		frame.cent[NumPlayers].text:SetText(data[NumPlayers][1])
		frame.cent[NumPlayers].tooltip = data[NumPlayers][2]
		frame.cent[NumPlayers]:Show()
		if data[NumPlayers].currentChar then
			E:func_SetBackdrop(frame.cent[NumPlayers], E.classColorHexCurrent, E.bgCaOverlay*2, 0)
		else

			if data.index % 2 == 0 then
				E:func_SetBackdrop(frame.cent[NumPlayers], nil, 0, 0)
			else
				E:func_SetBackdrop(frame.cent[NumPlayers], "|cff000000", E.bgCaOverlay, 0)
			end
		end

		if data[NumPlayers][3] then
			E:func_SetBackdrop(frame.cent[NumPlayers], data[NumPlayers][3], E.bgCaOverlay, 0)
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:OctoToDo_Create_MainFrame_OCTOMAIN()
	local OctoToDo_MainFrame_OCTOMAIN = CreateFrame("BUTTON", "OctoToDo_MainFrame_OCTOMAIN", UIParent, "BackdropTemplate")
	tinsert(E.OctoTable_Frames, OctoToDo_MainFrame_OCTOMAIN)
	OctoToDo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonRightFrameWeight*func_NumPlayers(), AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_OCTOMAIN:Hide()
	OctoToDo_MainFrame_OCTOMAIN:SetDontSavePosition(true)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox = CreateFrame("FRAME", "ScrollBox", OctoToDo_MainFrame_OCTOMAIN, "WowScrollBoxList")
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetAllPoints()
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetPropagateMouseClicks(true)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:GetScrollTarget():SetPropagateMouseClicks(true)
	-- OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetHorizontal(true)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar = CreateFrame("EventFrame", "ScrollBar", OctoToDo_MainFrame_OCTOMAIN, "MinimalScrollBar")
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("TOPLEFT", OctoToDo_MainFrame_OCTOMAIN.ScrollBox, "TOPRIGHT", 6, 0)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBar:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN.ScrollBox, "BOTTOMRIGHT", 6, 0)
	OctoToDo_MainFrame_OCTOMAIN.view = CreateScrollBoxListLinearView()
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementExtent(AddonHeight)
	OctoToDo_MainFrame_OCTOMAIN.view:SetElementInitializer("BackdropTemplate", OctoToDo_Frame_init)
	OctoToDo_MainFrame_OCTOMAIN.view:RegisterCallback(OctoToDo_MainFrame_OCTOMAIN.view.Event.OnAcquiredFrame, func_OnAcquired, OctoToDo_MainFrame_OCTOMAIN)
	-- OctoToDo_MainFrame_OCTOMAIN.view:SetHorizontal(true)
	ScrollUtil.InitScrollBoxListWithScrollBar(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar, OctoToDo_MainFrame_OCTOMAIN.view)
	-- ОТКЛЮЧАЕТ СКРОЛЛЫ КОГДА НЕНУЖНЫ
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(OctoToDo_MainFrame_OCTOMAIN.ScrollBox, OctoToDo_MainFrame_OCTOMAIN.ScrollBar)
	OctoToDo_MainFrame_OCTOMAIN:SetClampedToScreen(false)
	OctoToDo_MainFrame_OCTOMAIN:SetFrameStrata("HIGH")
	OctoToDo_MainFrame_OCTOMAIN:SetPoint("CENTER")
	OctoToDo_MainFrame_OCTOMAIN:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0
			},
	})
	OctoToDo_MainFrame_OCTOMAIN:SetBackdropColor(E.bgCr, E.bgCg, E.bgCb, E.bgCa)
	OctoToDo_MainFrame_OCTOMAIN:SetBackdropBorderColor(0, 0, 0, 1)
	-- OctoToDo_MainFrame_OCTOMAIN:SetBackdropColor(0, 0, 0, 0)
	-- OctoToDo_MainFrame_OCTOMAIN:SetBackdropBorderColor(0, 0, 0, 0)
	OctoToDo_MainFrame_OCTOMAIN:EnableMouse(true)
	OctoToDo_MainFrame_OCTOMAIN:SetMovable(true)
	OctoToDo_MainFrame_OCTOMAIN:RegisterForDrag("LeftButton")
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStart", function()
			OctoToDo_MainFrame_OCTOMAIN:SetAlpha(E.bgCa)
			OctoToDo_MainFrame_OCTOMAIN:StartMoving()
	end)
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnDragStop", function()
			OctoToDo_MainFrame_OCTOMAIN:SetAlpha(1)
			OctoToDo_MainFrame_OCTOMAIN:StopMovingOrSizing()
	end)
	OctoToDo_MainFrame_OCTOMAIN:RegisterForClicks("RightButtonUp")
	OctoToDo_MainFrame_OCTOMAIN:SetScript("OnClick", function(self) self:Hide() end)
	----------------------------------------------------------------
	self:func_DataProvider()
end
function OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = OctoToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = OctoToDo_DB_Vars.LevelToShowMAX
	local itemLevelToShow = OctoToDo_DB_Vars.itemLevelToShow
	local sorted = {}
	for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == E.curServer)
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == E.curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.avgItemLevel >= itemLevelToShow)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	sort(sorted, function(b, a)
			if a and b then
				return
				a.UnitLevel < b.UnitLevel or a.UnitLevel == b.UnitLevel
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				b.Name < a.Name
			end
	end)
	local OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT = E:func_Otrisovka()
	local CENT = {}
	for i, func in ipairs(OctoTable_func_otrisovkaCENT) do
		CENT[i] = CENT[i] or {}
		CENT[i].left = OctoTable_func_otrisovkaLEFT[i]()
		CENT[i].firsticonTexture = select(2, OctoTable_func_otrisovkaLEFT[i]())
		CENT[i].BGcolor = select(3, OctoTable_func_otrisovkaLEFT[i]())
		CENT[i].index = i
		for index, CharInfo in ipairs(sorted) do
			CENT[i][index] = {func(CharInfo)}
			CENT[i][index].currentChar = CharInfo.GUID == E.curGUID
		end
	end
	local newcount = #OctoTable_func_otrisovkaCENT
	MainFrameNumLines = newcount
	if MainFrameNumLines > OctoToDo_DB_Vars.Addon_Height then
		MainFrameNumLines = OctoToDo_DB_Vars.Addon_Height
	end
	if MainFrameNumLines < 1 then MainFrameNumLines = 1 end
	local DataProvider = CreateDataProvider(CENT)
	OctoToDo_MainFrame_OCTOMAIN:SetSize(AddonLeftFrameWeight+AddonRightFrameWeight*func_NumPlayers(), AddonHeight*MainFrameNumLines)
	OctoToDo_MainFrame_OCTOMAIN.ScrollBox:SetDataProvider(DataProvider, ScrollBoxConstants.RetainScrollPosition)
end
function E.Update(event_name)
	--OctoToDo_DB_Vars.DebugFunction
	local updateScheduled = false
	local isMainFrameVisible = OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown()
	if isMainFrameVisible then
		if not updateScheduled then
			updateScheduled = true
			C_Timer.After(0.1, function()
					updateScheduled = false
					if OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown() then
						if E.DebugEvent then
							DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Green_Color, E.Yellow_Color)..event_name..E.Yellow_Color..")|r")
						end
						OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
					end
			end)
		end
	else
		if E.DebugEvent then
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("E.Update(", E.Addon_Left_Color, E.Addon_Right_Color)..event_name..E.Addon_Right_Color..")|r")
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:func_Create_DD_OCTOMAIN()
	local DD_OCTOMAIN = CreateFrame("Button", "DD_OCTOMAIN", OctoToDo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD_OCTOMAIN:SetSize(AddonLeftFrameWeight/2, AddonHeight)
	E:func_SetBackdrop(DD_OCTOMAIN)
	DD_OCTOMAIN.ExpandArrow = DD_OCTOMAIN:CreateTexture(nil, "ARTWORK")
	DD_OCTOMAIN.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD_OCTOMAIN.ExpandArrow:SetSize(14, 14)
	DD_OCTOMAIN.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD_OCTOMAIN.text = DD_OCTOMAIN:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD_OCTOMAIN.text:SetAllPoints()
	DD_OCTOMAIN.text:SetFontObject(OctoFont11)
	DD_OCTOMAIN.text:SetJustifyV("MIDDLE")
	DD_OCTOMAIN.text:SetJustifyH("CENTER")
	DD_OCTOMAIN.text:SetTextColor(1, 1, 1, 1)
	DD_OCTOMAIN.text:SetText(E.classColorHexCurrent..L["Characters"].."|r")
	LibSFDropDown:SetMixin(DD_OCTOMAIN)
	DD_OCTOMAIN:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, 0)
	DD_OCTOMAIN:ddSetDisplayMode(GlobalAddonName)
	DD_OCTOMAIN:ddSetNoGlobalMouseEvent(true)
	DD_OCTOMAIN:ddHideWhenButtonHidden()
	DD_OCTOMAIN:RegisterForClicks("LeftButtonUp")
	DD_OCTOMAIN:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
		end
	)
	local function selectFunctionisShownPLAYER(menuButton, _, _, checked)
		OctoToDo_DB_Levels[menuButton.value].isShownPLAYER = checked
		OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
	end
	local function func_remove_GUID(menuButton)
		OctoToDo_DB_Levels[menuButton.value] = nil
		OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
	end
	DD_OCTOMAIN:ddSetInitFunc(function(self, level, value)
			local info, list = {}, {}
			local count = 0
			local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
			local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
			if level == 1 then
				local BnetList = {}
				local OctoToDo_BatlleNets = {}
				for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if not BnetList[CharInfo.BattleTagLocal] then
						count = count + 1
						OctoToDo_BatlleNets[count] = CharInfo.BattleTagLocal
					end
					BnetList[CharInfo.BattleTagLocal] = true
				end
				sort(OctoToDo_BatlleNets)
				if count > 1 then
					for i, Bnets in ipairs(OctoToDo_BatlleNets) do
						local info = {}
						info.fontObject = OctoFont11
						info.hasArrow = true
						info.keepShownOnClick = true
						info.notCheckable = true
						local vivod = Bnets
						if Bnets == E.BattleTagLocal then
							vivod = E.classColorHexCurrent..Bnets.."|r"
						end
						if ShowOnlyCurrentBattleTag == true then
							if Bnets ~= E.BattleTagLocal then
								vivod = E.Gray_Color..vivod.."|r"
							end
						end
						info.text = vivod
						info.value = Bnets
						tinsert(list, info)
					end
				else
					local curCharGUID, CharInfo = next(OctoToDo_DB_Levels)
					value = CharInfo.BattleTagLocal
				end
			end
			self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			if type(value) == "string" then
				local tbl_Players = {}
				for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
					if CharInfo.BattleTagLocal == value or not value then
						tbl_Players[CharInfo.curServer] = tbl_Players[CharInfo.curServer] or {}
						tbl_Players[CharInfo.curServer][curCharGUID] = tbl_Players[CharInfo.curServer][curCharGUID] or {}
						tbl_Players[CharInfo.curServer][curCharGUID] = CharInfo.classColorHex..CharInfo.Name.."|r".."QEWQWE "..CharInfo.UnitLevel
					end
				end
				for Server, v in next, (tbl_Players) do
					local info = {}
					info.fontObject = OctoFont11
					info.hasArrow = true
					info.keepShownOnClick = true
					info.notCheckable = true
					local vivod = Server
					if ShowOnlyCurrentBattleTag and (value ~= E.BattleTagLocal or ShowOnlyCurrentServer and Server ~= E.curServer)
					or not ShowOnlyCurrentBattleTag and ShowOnlyCurrentServer and Server ~= E.curServer
					then
						vivod = E.Gray_Color..vivod.."|r"
					elseif Server == E.curServer then
						vivod = E.classColorHexCurrent..vivod.."|r"
					end
					info.text = vivod
					info.value = v
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			elseif type(value) == "table" then
				local players_list = {}
				for GUID, names in next, (value) do
					tinsert(players_list, GUID)
				end
				sort(players_list, function(a, b)
						local infoA = OctoToDo_DB_Levels[a]
						local infoB = OctoToDo_DB_Levels[b]
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
					info.fontObject = OctoFont11
					info.keepShownOnClick = true
					info.isNotRadio = true
					local vivod = OctoToDo_DB_Levels[GUID].classColorHex..OctoToDo_DB_Levels[GUID].Name.."|r"
					if OctoToDo_DB_Levels[GUID].UnitLevel ~= E.currentMaxLevel then
						vivod = vivod.." "..E.Yellow_Color..OctoToDo_DB_Levels[GUID].UnitLevel.."|r"
					end
					info.text = vivod
					info.value = GUID
					info.func = selectFunctionisShownPLAYER
					info.checked = OctoToDo_DB_Levels[GUID].isShownPLAYER
					info.remove = func_remove_GUID
					info.removeDoNotHide = true
					info.icon = OctoToDo_DB_Levels[GUID].specIcon
					info.iconInfo = {tSizeX = 16, tSizeY = 16}
					tinsert(list, info)
				end
				self:ddAddButton({list = list, listMaxSize = E.listMaxSize}, level)
			end
			if level == 1 then
				----------------
				self:ddAddSeparator(level)
				info.fontObject = OctoFont11
				info.keepShownOnClick = false
				info.notCheckable = false
				info.isNotRadio = true
				info.text = L["Only Current Server"]
				info.hasArrow = nil
				info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentServer
				info.func = function(_, _, _, checked)
					OctoToDo_DB_Vars.ShowOnlyCurrentServer = checked
					OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				if count > 1 then
					info.fontObject = OctoFont11
					info.keepShownOnClick = false
					info.notCheckable = false
					info.isNotRadio = true
					info.text = L["Only Current BattleTag"]
					info.hasArrow = nil
					info.checked = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
					info.func = function(_, _, _, checked)
						OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = checked
						OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
					end
					self:ddAddButton(info, level)
				end
				----------------
				self:ddAddSeparator(level)
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Show all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = true
					end
					OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
				end
				self:ddAddButton(info, level)
				----------------
				info.keepShownOnClick = false
				info.notCheckable = true
				info.text = "Hide all"
				info.icon = false
				info.func = function(_, _, _, checked)
					for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
						CharInfo.isShownPLAYER = false
					end
					OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
				end
				self:ddAddButton(info, level)
				----------------
			end
		end
	)
	DD_OCTOMAIN:ddSetOpenMenuUp(true)
	DD_OCTOMAIN:ddSetMenuButtonHeight(16)
end
function OctoToDo_EventFrame_OCTOMAIN:func_Create_DD2_OCTOMAIN()
	local DD2_OCTOMAIN = CreateFrame("Button", "DD2_OCTOMAIN", OctoToDo_MainFrame_OCTOMAIN, "SecureActionButtonTemplate, BackDropTemplate")
	DD2_OCTOMAIN:SetSize(AddonLeftFrameWeight/2, AddonHeight)
	E:func_SetBackdrop(DD2_OCTOMAIN)
	DD2_OCTOMAIN.ExpandArrow = DD2_OCTOMAIN:CreateTexture(nil, "ARTWORK")
	DD2_OCTOMAIN.ExpandArrow:SetTexture("Interface/ChatFrame/ChatFrameExpandArrow")
	DD2_OCTOMAIN.ExpandArrow:SetSize(14, 14)
	DD2_OCTOMAIN.ExpandArrow:SetPoint("RIGHT", -4, 0)
	DD2_OCTOMAIN.text = DD2_OCTOMAIN:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	DD2_OCTOMAIN.text:SetAllPoints()
	DD2_OCTOMAIN.text:SetFontObject(OctoFont11)
	DD2_OCTOMAIN.text:SetJustifyV("MIDDLE")
	DD2_OCTOMAIN.text:SetJustifyH("CENTER")
	DD2_OCTOMAIN.text:SetTextColor(1, 1, 1, 1)
	DD2_OCTOMAIN.text:SetText(EXPANSION_FILTER_TEXT)
	LibSFDropDown:SetMixin(DD2_OCTOMAIN)
	DD2_OCTOMAIN:SetPoint("BOTTOMLEFT", OctoToDo_MainFrame_OCTOMAIN, "TOPLEFT", 0, AddonHeight)
	DD2_OCTOMAIN:ddSetDisplayMode(GlobalAddonName)
	DD2_OCTOMAIN:ddSetNoGlobalMouseEvent(true)
	-- DD2_OCTOMAIN:ddHideWhenButtonHidden()
	DD2_OCTOMAIN:RegisterForClicks("LeftButtonUp")
	DD2_OCTOMAIN:SetScript("OnClick", function(self)
			self:ddToggle(1, nil, self, self:GetWidth()-7, -self:GetHeight()-2)
	end)
	local function selectFunctionExpansion(menuButton, _, _, checked)
		OctoToDo_DB_Vars.ExpansionToShow[menuButton.value] = checked or nil
		DD2_OCTOMAIN:SetText("EXP")
		OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
	end
	DD2_OCTOMAIN:ddSetInitFunc(function(self, level, value)
			local info = {}
			info.fontObject = OctoFont11
			if not value then
				for expansionID, v in ipairs(E.OctoTable_Expansions_Table) do
					info.isNotRadio = true
					info.notCheckable = false
					info.keepShownOnClick = true
					info.text = v.color..v.name.."|r"
					info.value = expansionID
					info.icon = v.icon
					info.checked = OctoToDo_DB_Vars.ExpansionToShow[expansionID]
					info.func = selectFunctionExpansion
					self:ddAddButton(info, level)
				end
			end
			--------------------------------------------------
			self:ddAddSeparator(level)
			info.keepShownOnClick = false
			info.notCheckable = true
			info.text = "Show all"
			info.icon = false
			info.func = function(_, _, _, checked)
				for expansionID, v in ipairs(E.OctoTable_Expansions_Table) do
					OctoToDo_DB_Vars.ExpansionToShow[expansionID] = true
				end
				OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
			end
			self:ddAddButton(info, level)
			--------------------------------------------------
			info.keepShownOnClick = false
			info.notCheckable = true
			info.text = "Hide all"
			info.icon = false
			info.func = function(_, _, _, checked)
				for expansionID, v in ipairs(E.OctoTable_Expansions_Table) do
					OctoToDo_DB_Vars.ExpansionToShow[expansionID] = false
				end
				OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
			end
			self:ddAddButton(info, level)
			--------------------------------------------------
	end)
	DD2_OCTOMAIN:ddSetOpenMenuUp(true)
	DD2_OCTOMAIN:ddSetMenuButtonHeight(16)
end
----------------------------------------------------------------
function OctoToDo_EventFrame_OCTOMAIN:func_CreateMineFrame()
	local pizda = false
	if pizda == true then
		local colorBtn =  CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate")
		colorBtn:SetBackdrop({
				edgeFile = E.edgeFile,
				edgeSize = 1,
				insets = {left = 1, right = 1, top = 1, bottom = 1},
		})
		colorBtn:SetBackdropBorderColor(0, 0, 0, bbalpha)
		colorBtn:SetSize(32, 16)
		colorBtn:SetPoint("TOPLEFT", 50, -50)
		-- colorBtn:SetNormalTexture("Interface/ChatFrame/ChatFrameColorSwatch")
		colorBtn:SetNormalTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\statusbar\\02 Octo-Blank.tga")
		local colorTex = colorBtn:GetNormalTexture()
		colorTex:SetColorTexture(unpack(OctoToDo_DB_Vars.color))
		colorTex:ClearAllPoints()
		colorTex:SetPoint("TOPLEFT", 1, -1)
		colorTex:SetPoint("BOTTOMRIGHT", -1, 1)
		colorBtn.swatchFunc = function()
			colorTex:SetColorTexture(ColorPickerFrame:GetColorRGB())
			OctoToDo_DB_Vars.color = {ColorPickerFrame:GetColorRGB()}
			MineFrame.FG:SetVertexColor(ColorPickerFrame:GetColorRGB())
			-- self:setCursorSettings()
		end
		colorBtn.cancelFunc = function(color)
			OctoToDo_DB_Vars.color = {color.r, color.g, color.b, color.a}
			colorTex:SetColorTexture(color.r, color.g, color.b)
			MineFrame.FG:SetVertexColor(color.r, color.g, color.b, color.a)
			-- self:setCursorSettings()
		end
		colorBtn.hasOpacity = true
		colorBtn.opacityFunc = function()
			local a = ColorPickerFrame:GetColorAlpha()
			OctoToDo_DB_Vars.color[4] = a
			colorTex:SetAlpha(a)
		end
		colorBtn:SetScript("OnClick", function(btn)
				btn.r, btn.g, btn.b, btn.opacity = unpack(OctoToDo_DB_Vars.color)
				if OpenColorPicker then
					OpenColorPicker(btn)
				else
					ColorPickerFrame:SetupColorPickerAndShow(btn)
				end
		end)
		-- local r, g, b = E.func_hex2rgbNUMBER(E.Yellow_Color)
		colorBtn:SetScript("OnEnter", function(btn)
				btn:SetBackdropBorderColor(r, g, b, 1)
		end)
		colorBtn:SetScript("OnLeave", function(btn)
				btn:SetBackdropBorderColor(0, 0, 0, 1)
		end)
		local btnResetColor = CreateFrame("BUTTON", nil, UIParent, "UIPanelButtonTemplate")
		btnResetColor:SetSize(64, 24)
		btnResetColor:SetPoint("LEFT", colorBtn, "RIGHT", 3, 0)
		btnResetColor:SetText(RESET)
		btnResetColor:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				colorTex:SetColorTexture(1, 1, 1)
				colorTex:SetAlpha(1)
				MineFrame.FG:SetVertexColor(1,1,1,1)
				OctoToDo_DB_Vars.color = {1, 1, 1, 1}
				-- config:setCursorSettings()
		end)
		----
		local MineFrame = CreateFrame("Frame", "MineFrame", UIParent, "BackdropTemplate")
		MineFrame:SetPoint("TOPLEFT", 100, -100)
		MineFrame:SetSize(1256, 68)
		MineFrame:SetBackdrop({bgFile = E.bgFile, edgeFile = E.edgeFile, edgeSize = 1})
		MineFrame:SetBackdropColor(29/255, 42/255, 76/255, 1)
		MineFrame:SetBackdropBorderColor(0, 0, 0, 0)
		MineFrame.FG = MineFrame:CreateTexture(nil, "BACKGROUND", nil, 2)
		MineFrame.FG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\MINECRAFT\\minecraft FG.tga")
		MineFrame.FG:SetAllPoints(MineFrame)
		MineFrame.FG:SetVertexColor(unpack(OctoToDo_DB_Vars.color))
		MineFrame.BG = MineFrame:CreateTexture(nil, "BACKGROUND", nil, 3)
		MineFrame.BG:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\MINECRAFT\\minecraft BG.tga")
		MineFrame.BG:SetAllPoints(MineFrame)
		-- MineFrame.BG:SetVertexColor(unpack(OctoToDo_DB_Vars.color))
	end
end
----------------------------------------------------------------
local MyEventsTable = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN",
	"PLAYER_REGEN_DISABLED",
	"READY_CHECK",
	"SHOW_SUBSCRIPTION_INTERSTITIAL",
}
E.RegisterMyEventsToFrames(OctoToDo_EventFrame_OCTOMAIN, MyEventsTable, E.func_DebugPath())
function OctoToDo_EventFrame_OCTOMAIN:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		if OctoToDo_DB_Config == nil then OctoToDo_DB_Config = {} end
		if OctoToDo_DB_Levels == nil then OctoToDo_DB_Levels = {} end
		if OctoToDo_DB_Other == nil then OctoToDo_DB_Other = {} end


		if OctoToDo_DB_Config.CurrencyDB == nil then OctoToDo_DB_Config.CurrencyDB = {} end
		if OctoToDo_DB_Config.QuestsDB == nil then OctoToDo_DB_Config.QuestsDB = {} end
		if OctoToDo_DB_Config.ReputationDB == nil then OctoToDo_DB_Config.ReputationDB = {} end
		if OctoToDo_DB_Other.AccountMoney == nil then OctoToDo_DB_Other.AccountMoney = {} end
		if OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] == nil then OctoToDo_DB_Other.AccountMoney[E.BattleTagLocal] = 0 end
		if OctoToDo_DB_Other.CVar == nil then OctoToDo_DB_Other.CVar = {} end
		if OctoToDo_DB_Other.Items == nil then OctoToDo_DB_Other.Items = {} end
		if OctoToDo_DB_Other.LFGInstance == nil then OctoToDo_DB_Other.LFGInstance = {} end
		-- if OctoToDo_DB_Other.Holiday == nil then OctoToDo_DB_Other.Holiday = {} end
		if OctoToDo_DB_Vars == nil then OctoToDo_DB_Vars = {} end
		if OctoToDo_DB_Vars.DebugIDs == nil then OctoToDo_DB_Vars.DebugIDs = false end
		E.DebugIDs = OctoToDo_DB_Vars.DebugIDs
		if OctoToDo_DB_Vars.DebugInfo == nil then OctoToDo_DB_Vars.DebugInfo = false end
		E.DebugInfo = OctoToDo_DB_Vars.DebugInfo
		if OctoToDo_DB_Vars.DebugEvent == nil then OctoToDo_DB_Vars.DebugEvent = false end
		E.DebugEvent = OctoToDo_DB_Vars.DebugEvent
		if OctoToDo_DB_Vars.DebugFunction == nil then OctoToDo_DB_Vars.DebugFunction = false end
		E.DebugFunction = OctoToDo_DB_Vars.DebugFunction
		if OctoToDo_DB_Vars.DebugButton == nil then OctoToDo_DB_Vars.DebugButton = false end
		E.DebugButton = OctoToDo_DB_Vars.DebugButton
		if OctoToDo_DB_Vars.PortalsButtons == nil then OctoToDo_DB_Vars.PortalsButtons = true end
		if OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable == nil then OctoToDo_DB_Vars.PortalsButtonsOnlyAvailable = true end
		if OctoToDo_DB_Vars.color == nil then OctoToDo_DB_Vars.color = {1, 1, 1} end
		if OctoToDo_DB_Vars.AchievementShowCompleted == nil then OctoToDo_DB_Vars.AchievementShowCompleted = true end
		if OctoToDo_DB_Vars.AchievementToShow == nil then OctoToDo_DB_Vars.AchievementToShow = {[92] = true} end
		if OctoToDo_DB_Vars.curWidthCentral == nil then OctoToDo_DB_Vars.curWidthCentral = 90 end
		if OctoToDo_DB_Vars.curWidthCentral ~= nil then E.curWidthCentral = OctoToDo_DB_Vars.curWidthCentral end
		if OctoToDo_DB_Vars.Addon_Height == nil then OctoToDo_DB_Vars.Addon_Height = 30 end
		if OctoToDo_DB_Vars.curHeight == nil then OctoToDo_DB_Vars.curHeight = 20 end
		if OctoToDo_DB_Vars.curHeight ~= nil then E.curHeight = OctoToDo_DB_Vars.curHeight end
		if OctoToDo_DB_Vars.curWidthTitle == nil then OctoToDo_DB_Vars.curWidthTitle = 200 end
		if OctoToDo_DB_Vars.curWidthTitle ~= nil then E.curWidthTitle = OctoToDo_DB_Vars.curWidthTitle end
		if OctoToDo_DB_Vars.AidingtheAccord == nil then OctoToDo_DB_Vars.AidingtheAccord = true end
		if OctoToDo_DB_Vars.AnotherAddonsCasual == nil then OctoToDo_DB_Vars.AnotherAddonsCasual = true end
		if OctoToDo_DB_Vars.AnotherAddonsDUNG == nil then OctoToDo_DB_Vars.AnotherAddonsDUNG = true end
		if OctoToDo_DB_Vars.AnotherAddonsRAID == nil then OctoToDo_DB_Vars.AnotherAddonsRAID = true end
		if OctoToDo_DB_Vars.Auto_ChatClearing == nil then OctoToDo_DB_Vars.Auto_ChatClearing = false end
		if OctoToDo_DB_Vars.Auto_CinematicCanceler == nil then OctoToDo_DB_Vars.Auto_CinematicCanceler = true end
		if OctoToDo_DB_Vars.Auto_CinematicFastSkip == nil then OctoToDo_DB_Vars.Auto_CinematicFastSkip = true end
		if OctoToDo_DB_Vars.Auto_Gossip == nil then OctoToDo_DB_Vars.Auto_Gossip = true end
		if OctoToDo_DB_Vars.Auto_Screenshot == nil then OctoToDo_DB_Vars.Auto_Screenshot = true end
		if OctoToDo_DB_Vars.AutoGossip == nil then OctoToDo_DB_Vars.AutoGossip = true end
		if OctoToDo_DB_Vars.AutoOpen == nil then OctoToDo_DB_Vars.AutoOpen = true end
		if OctoToDo_DB_Vars.AutoRepair == nil then OctoToDo_DB_Vars.AutoRepair = true end
		if OctoToDo_DB_Vars.AutoSellGrey == nil then OctoToDo_DB_Vars.AutoSellGrey = true end
		if OctoToDo_DB_Vars.AutoTurnQuests == nil then OctoToDo_DB_Vars.AutoTurnQuests = true end
		if OctoToDo_DB_Vars.BeledarCycle == nil then OctoToDo_DB_Vars.BeledarCycle = true end
		if OctoToDo_DB_Vars.CarvedHarbingerCrest == nil then OctoToDo_DB_Vars.CarvedHarbingerCrest = true end
		if OctoToDo_DB_Vars.ChallengesKeystoneFrame == nil then OctoToDo_DB_Vars.ChallengesKeystoneFrame = true end
		if OctoToDo_DB_Vars.CinematicCanceler == nil then OctoToDo_DB_Vars.CinematicCanceler = true end
		if OctoToDo_DB_Vars.Currency == nil then OctoToDo_DB_Vars.Currency = true end
		if OctoToDo_DB_Vars.CurrencyShowAllways == nil then OctoToDo_DB_Vars.CurrencyShowAllways = false end
		if OctoToDo_DB_Vars.CVar == nil then OctoToDo_DB_Vars.CVar = true end
		if OctoToDo_DB_Vars.Dungeons == nil then OctoToDo_DB_Vars.Dungeons = true end
		if OctoToDo_DB_Vars.EmeraldDream_Dreamseeds == nil then OctoToDo_DB_Vars.EmeraldDream_Dreamseeds = true end
		if OctoToDo_DB_Vars.EmeraldDream_Rares == nil then OctoToDo_DB_Vars.EmeraldDream_Rares = true end
		if OctoToDo_DB_Vars.EmeraldDream_Sparks == nil then OctoToDo_DB_Vars.EmeraldDream_Sparks = true end
		if OctoToDo_DB_Vars.EmeraldDream_WB == nil then OctoToDo_DB_Vars.EmeraldDream_WB = true end
		if OctoToDo_DB_Vars.Event == nil then OctoToDo_DB_Vars.Event = true end
		if OctoToDo_DB_Vars.ExpansionToShow == nil then OctoToDo_DB_Vars.ExpansionToShow = {[1] = true} end
		if OctoToDo_DB_Vars.FrameScale == nil then OctoToDo_DB_Vars.FrameScale = 1 end
		if OctoToDo_DB_Vars.GameMenuFrameScale == nil then OctoToDo_DB_Vars.GameMenuFrameScale = .8 end
		if OctoToDo_DB_Vars.GildedHarbingerCrest == nil then OctoToDo_DB_Vars.GildedHarbingerCrest = true end
		if OctoToDo_DB_Vars.Gold == nil then OctoToDo_DB_Vars.Gold = true end
		if OctoToDo_DB_Vars.Professions == nil then OctoToDo_DB_Vars.Professions = true end
		if OctoToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI == nil then OctoToDo_DB_Vars.Hide_AzeriteEmpoweredItemUI = true end
		if OctoToDo_DB_Vars.Hide_Boss_Banner == nil then OctoToDo_DB_Vars.Hide_Boss_Banner = true end
		if OctoToDo_DB_Vars.Hide_Covenant == nil then OctoToDo_DB_Vars.Hide_Covenant = true end
		if OctoToDo_DB_Vars.Hide_Error_Messages == nil then OctoToDo_DB_Vars.Hide_Error_Messages = true end
		if OctoToDo_DB_Vars.Hide_ObjectivesInInstance == nil then OctoToDo_DB_Vars.Hide_ObjectivesInInstance = true end
		if OctoToDo_DB_Vars.Hide_OrderHallCommandBar == nil then OctoToDo_DB_Vars.Hide_OrderHallCommandBar = true end
		if OctoToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame == nil then OctoToDo_DB_Vars.Hide_Raid_Boss_Emote_Frame = true end
		if OctoToDo_DB_Vars.Hide_RaidWarningFrame == nil then OctoToDo_DB_Vars.Hide_RaidWarningFrame = true end
		if OctoToDo_DB_Vars.Hide_Talking_Head_Frame == nil then OctoToDo_DB_Vars.Hide_Talking_Head_Frame = true end
		if OctoToDo_DB_Vars.Hide_Zone_Text == nil then OctoToDo_DB_Vars.Hide_Zone_Text = true end
		if OctoToDo_DB_Vars.InputDelete == nil then OctoToDo_DB_Vars.InputDelete = true end
		if OctoToDo_DB_Vars.ItemLevel == nil then OctoToDo_DB_Vars.ItemLevel = true end
		if OctoToDo_DB_Vars.itemLevelToShow == nil then OctoToDo_DB_Vars.itemLevelToShow = 1 end
		if OctoToDo_DB_Vars.Items == nil then OctoToDo_DB_Vars.Items = true end
		if OctoToDo_DB_Vars.ItemsShowAllways == nil then OctoToDo_DB_Vars.ItemsShowAllways = false end
		if OctoToDo_DB_Vars.ItemsUsable == nil then OctoToDo_DB_Vars.ItemsUsable = false end
		if OctoToDo_DB_Vars.LastUpdate == nil then OctoToDo_DB_Vars.LastUpdate = true end
		if OctoToDo_DB_Vars.LevelToShow == nil then OctoToDo_DB_Vars.LevelToShow = 1 end
		if OctoToDo_DB_Vars.LevelToShowMAX == nil then OctoToDo_DB_Vars.LevelToShowMAX = E.currentMaxLevel end
		if OctoToDo_DB_Vars.LootFrame == nil then OctoToDo_DB_Vars.LootFrame = true end
		if OctoToDo_DB_Vars.MajorKeyflames == nil then OctoToDo_DB_Vars.MajorKeyflames = true end
		if OctoToDo_DB_Vars.MinorKeyflames == nil then OctoToDo_DB_Vars.MinorKeyflames = true end
		if OctoToDo_DB_Vars.MP_MythicKeystone == nil then OctoToDo_DB_Vars.MP_MythicKeystone = true end
		if OctoToDo_DB_Vars.prefix == nil then OctoToDo_DB_Vars.prefix = 1 end
		if OctoToDo_DB_Vars.Quests == nil then OctoToDo_DB_Vars.Quests = true end
		if OctoToDo_DB_Vars.QuestsShowAllways == nil then OctoToDo_DB_Vars.QuestsShowAllways = false end
		if OctoToDo_DB_Vars.Reputations == nil then OctoToDo_DB_Vars.Reputations = true end
		if OctoToDo_DB_Vars.ReputationsShowAllways == nil then OctoToDo_DB_Vars.ReputationsShowAllways = false end
		if OctoToDo_DB_Vars.ResetAllChars == nil then OctoToDo_DB_Vars.ResetAllChars = true end
		if OctoToDo_DB_Vars.RunedHarbingerCrest == nil then OctoToDo_DB_Vars.RunedHarbingerCrest = true end
		if OctoToDo_DB_Vars.ShowIDS == nil then OctoToDo_DB_Vars.ShowIDS = true end
		if OctoToDo_DB_Vars.SpeedFrame == nil then OctoToDo_DB_Vars.SpeedFrame = {} end
		if OctoToDo_DB_Vars.SpeedFrame.Shown == nil then OctoToDo_DB_Vars.SpeedFrame.Shown = true end
		if OctoToDo_DB_Vars.SpeedFrame.point == nil then OctoToDo_DB_Vars.SpeedFrame.point = "BOTTOM" end
		if OctoToDo_DB_Vars.SpeedFrame.relativePoint == nil then OctoToDo_DB_Vars.SpeedFrame.relativePoint = "BOTTOM" end
		if OctoToDo_DB_Vars.SpeedFrame.xOfs == nil then OctoToDo_DB_Vars.SpeedFrame.xOfs = 129 end
		if OctoToDo_DB_Vars.SpeedFrame.yOfs == nil then OctoToDo_DB_Vars.SpeedFrame.yOfs = 67 end
		if OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag == nil then OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag = false end
		if OctoToDo_DB_Vars.ShowOnlyCurrentServer == nil then OctoToDo_DB_Vars.ShowOnlyCurrentServer = true end
		if OctoToDo_DB_Vars.ShowTime70 == nil then OctoToDo_DB_Vars.ShowTime70 = true end
		if OctoToDo_DB_Vars.SORTING == nil then OctoToDo_DB_Vars.SORTING = true end
		if OctoToDo_DB_Vars.StaticPopup1Button1 == nil then OctoToDo_DB_Vars.StaticPopup1Button1 = true end
		if OctoToDo_DB_Vars.TalentTreeTweaks == nil then OctoToDo_DB_Vars.TalentTreeTweaks = true end
		if OctoToDo_DB_Vars.TalentTreeTweaks_Alpha == nil then OctoToDo_DB_Vars.TalentTreeTweaks_Alpha = 1 end
		if OctoToDo_DB_Vars.TalentTreeTweaks_Scale == nil then OctoToDo_DB_Vars.TalentTreeTweaks_Scale = 1 end
		if OctoToDo_DB_Vars.Timewalk == nil then OctoToDo_DB_Vars.Timewalk = true end
		if OctoToDo_DB_Vars.TWW_Delve_Weekly == nil then OctoToDo_DB_Vars.TWW_Delve_Weekly = true end
		if OctoToDo_DB_Vars.TWW_DungeonQuest_Weekly == nil then OctoToDo_DB_Vars.TWW_DungeonQuest_Weekly = true end
		if OctoToDo_DB_Vars.WorldBoss_Weekly == nil then OctoToDo_DB_Vars.WorldBoss_Weekly = true end
		if OctoToDo_DB_Vars.UIErrorsFramePosition == nil then OctoToDo_DB_Vars.UIErrorsFramePosition = true end
		if OctoToDo_DB_Vars.WasOnline == nil then OctoToDo_DB_Vars.WasOnline = true end
		if OctoToDo_DB_Vars.WeatheredHarbingerCrest == nil then OctoToDo_DB_Vars.WeatheredHarbingerCrest = true end
		AddonHeight =  OctoToDo_DB_Vars.curHeight
		AddonRightFrameWeight = OctoToDo_DB_Vars.curWidthCentral
		AddonLeftFrameWeight = OctoToDo_DB_Vars.curWidthTitle
		self:ConcatAtStart()
		for i, func in next, (E.Modules) do
			func()
		end
		-- OctoToDo_MainFrame_OCTOMAIN
	end
end
function OctoToDo_EventFrame_OCTOMAIN:VARIABLES_LOADED()
	if not InCombatLockdown() then
		self:UnregisterEvent("VARIABLES_LOADED")
		self.VARIABLES_LOADED = nil
		----------------------------------------------------------------
		if OctoToDo_DB_Vars.CVar then
			E.LoadCVars()
			-- C_Timer.After(.1, function()
			--     if not InCombatLockdown() then
			--         print ("2")
			--         E.LoadCVars()
			--     end
			-- end)
		end
		----------------------------------------------------------------
	end
end
function OctoToDo_EventFrame_OCTOMAIN:PLAYER_LOGIN()
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
	C_WowTokenPublic.UpdateMarketPrice()
	self:func_CreateMineFrame()
	GameMenuFrame:SetScale(OctoToDo_DB_Vars.GameMenuFrameScale or 1)
	if not PlayerSpellsFrame then
		E.func_LoadAddOn("Blizzard_PlayerSpells")
		PlayerSpellsFrame:HookScript("OnShow", function()
				PlayerSpellsFrame:SetScale(0.8)
		end)
		PlayerSpellsFrame:EnableMouse(true)
		PlayerSpellsFrame:SetMovable(true)
		PlayerSpellsFrame:RegisterForDrag("LeftButton")
		PlayerSpellsFrame:SetScript("OnDragStart", function()
				PlayerSpellsFrame:SetAlpha(E.bgCa)
				PlayerSpellsFrame:StartMoving()
		end)
		PlayerSpellsFrame:SetScript("OnDragStop", function()
				PlayerSpellsFrame:SetAlpha(1)
				PlayerSpellsFrame:StopMovingOrSizing()
		end)
		-- PlayerSpellsFrame:RegisterForClicks("RightButtonUp")
		-- PlayerSpellsFrame:SetScript("OnClick", function(self)
		--    self:Hide()
		-- end)
	end
	----------------------------------------------------------------
	E:InitOptions()
	self:OctoToDo_Create_MainFrame_OCTOMAIN()
	E.PortalsFrame()
	self:func_Create_DD_OCTOMAIN()
	self:func_Create_DD2_OCTOMAIN()
	----------------------------------------------------------------
	E:func_CreateUtilsButton(OctoToDo_MainFrame_OCTOMAIN)
	local totalMoney = 0
	local totalReload = 0
	local realTotalTime = 0
	local realLevelTime = 0
	for curCharGUID, CharInfo in next, (OctoToDo_DB_Levels) do
		totalReload = totalReload + CharInfo.ReloadCount
		if CharInfo.curServer == E.curServer then
			totalMoney = totalMoney + CharInfo.Money
			realTotalTime = realTotalTime + CharInfo.realTotalTime
			if CharInfo.UnitLevel >= E.currentMaxLevel then
				realLevelTime = realLevelTime + CharInfo.realLevelTime
			end
		end
	end


	E.func_CreateInfoFrame("Money: "..E.classColorHexCurrent..E.func_CompactNumberFormat(totalMoney/10000).."|r "..E.curServerShort, "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, 0, AddonLeftFrameWeight, AddonHeight)
	E.func_CreateInfoFrame("Reloads: "..E.classColorHexCurrent..totalReload.."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight, AddonLeftFrameWeight, AddonHeight)
	E.func_CreateInfoFrame("realTotalTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realTotalTime).."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*2, AddonLeftFrameWeight, AddonHeight)
	if realLevelTime ~= 0 then
		E.func_CreateInfoFrame("realLevelTime: "..E.classColorHexCurrent..E.func_SecondsToClock(realLevelTime).."|r", "TOPLEFT", OctoToDo_MainFrame_OCTOMAIN, "BOTTOMLEFT", 0, -AddonHeight*3, AddonLeftFrameWeight, AddonHeight)
	end








	E:func_CreateMinimapButton(GlobalAddonName, OctoToDo_DB_Vars, OctoToDo_MainFrame_OCTOMAIN, function()
			OctoToDo_EventFrame_OCTOMAIN:func_DataProvider()
			RequestRaidInfo()
	end)
	C_Timer.After(0, function()
			-- E.PromiseItem = {}
			-- E.PromiseSpell = {}
			-- E.PromiseCurrency = {}
			-- E.PromiseQuest = {}
			-- E.PromiseReputation = {}
			local promise = LibThingsLoad:Items(E.OctoTable_itemID_ALL)
			promise:AddItems(E.PromiseItem)
			promise:AddSpells(E.PromiseSpell)
			-- promise:AddSpells(E.PromiseCurrency)
			promise:AddQuests(E.PromiseQuest)
			-- promise:AddSpells(E.PromiseReputation)
			promise:Then(function()
					if OctoToDo_MainFrame_OCTOMAIN:IsShown() then
						OctoToDo_MainFrame_OCTOMAIN:Hide()
						OctoToDo_MainFrame_OCTOMAIN:Show()
					end
			end)
			-- promise:FailWithChecked(function(...) print (...) end)
	end)
end
function OctoToDo_EventFrame_OCTOMAIN:SHOW_SUBSCRIPTION_INTERSTITIAL()
	if not InCombatLockdown() then
		if SubscriptionInterstitialFrame then
			SubscriptionInterstitialFrame:SetScript("OnEvent", nil)
			DEFAULT_CHAT_FRAME:AddMessage(E.func_Gradient("Hide trash frames: ").."SubscriptionInterstitialFrame")
		end
	end
end
function OctoToDo_EventFrame_OCTOMAIN:PLAYER_REGEN_DISABLED()
	if OctoToDo_MainFrame_OCTOMAIN and OctoToDo_MainFrame_OCTOMAIN:IsShown() then
		OctoToDo_MainFrame_OCTOMAIN:Hide()
	end
end
function OctoToDo_EventFrame_OCTOMAIN:READY_CHECK()
	if not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
end
----------------------------------------------------------------
SLASH_Octo1, SLASH_Octo2, SLASH_Octo3, SLASH_Octo4 = "/Octo", "/OctoTWW", "/octo", "/o"
function SlashCmdList.Octo(msg)
	if not InCombatLockdown() then
		OctoToDo_EventFrame_OCTOMAIN:main_frame_toggle()
	end
end
local editFrame, editBox = _G["editFrame"], _G["editFrame"].editFrame
SLASH_GSEARCH1, SLASH_GSEARCH2 = "/gsearch", "/gs"
SlashCmdList.GSEARCH = function(msg)
	local str = ""
	local list = {}
	local color = E.classColorHexCurrent
	if E.classFilename == "PRIEST" then
		color = E.Class_Priest_Color_Alternative
	end
	DEFAULT_CHAT_FRAME:AddMessage (color..("GSEARCH:|r ") .. msg)
	for i, n in next, (_G) do
		if type(n) == "string" and n:find(msg) then
			str = str..color..i.. "|r - ".. n .."\n"
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