local GlobalAddonName, E =...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local AddonNotes = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Notes")
local AddonAuthor = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Author")
local AddonVersion = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Version")
local GBI_version, GBI_build, GBI_date, GBI_tocversion, GBI_localizedVersion, GBI_buildType = GetBuildInfo()
if PTR_IssueReporter then PTR_IssueReporter:Hide() end
if WeeklyRewardExpirationWarningDialog then WeeklyRewardExpirationWarningDialog:Hide() end
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local lsfdd = LibStub("LibSFDropDown-1.4")
--
E.Octo_Func.func_Octo_LoadAddOn("!BugGrabber")
E.Octo_Func.func_Octo_LoadAddOn("BugSack")
-- E.Octo_Func.func_Octo_LoadAddOn("Rarity")
-- E.Octo_Func.func_Octo_LoadAddOn("Rarity_Options")
E.Octo_Func.func_Octo_LoadAddOn("MountsJournal")
-- FRAMES
local Button = nil
local CF = nil
local Octo_ToDo_FIRST_Frame_Char_Frame = nil
local Octo_ToDo_FIRST_Frame_EventFrame = nil
local inspectScantip = nil
local Octo_ToDo_FIRST_Frame_Main_Frame = nil
local Octo_ToDo_FIRST_Frame_UPGRADERANKS_Frame = nil
local Octo_ToDo_FIRST_Frame_Close_Button = nil
local Octo_ToDo_FIRST_Frame_Options_Button = nil
local Octo_ToDo_FIRST_Frame_MarkOfHonor_Button = nil
local Octo_ToDo_FIRST_Frame_QuestFeast_Button = nil
local Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button = nil
local Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton = nil
--
local className, classFilename, classId = UnitClass("PLAYER")
local englishFaction, localizedFaction = UnitFactionGroup("PLAYER")
local Horde_Icon = E.Octo_Func.func_texturefromIcon(132485)-- "|T132485:16:16:::64:64:4:60:4:60|t"
local Alliance_Icon = E.Octo_Func.func_texturefromIcon(132486)-- "|T132486:16:16:::64:64:4:60:4:60|t"
local Kyrian_Icon = E.Octo_Func.func_texturefromIcon(3257748)-- "|T3257748:16:16:::64:64:4:60:4:60|t"
local Necrolord_Icon = E.Octo_Func.func_texturefromIcon(3257749)-- "|T3257749:16:16:::64:64:4:60:4:60|t"
local NightFae_Icon = E.Octo_Func.func_texturefromIcon(3257750)-- "|T3257750:16:16:::64:64:4:60:4:60|t"
local Venthyr_Icon = E.Octo_Func.func_texturefromIcon(3257751)-- "|T3257751:16:16:::64:64:4:60:4:60|t"
local WorldBoss_Icon = E.Octo_Func.func_texturefromIcon(3528312)-- "|T3528312:16:16:::64:64:4:60:4:60|t"
local Rares_Icon = E.Octo_Func.func_texturefromIcon(135903)-- "|T135903:16:16:::64:64:4:60:4:60|t"
local Unknown_Icon = E.Octo_Func.func_texturefromIcon(134400)-- "|T134400:16:16:::64:64:4:60:4:60|t"
local Token_Icon = E.Octo_Func.func_texturefromIcon(1120721)-- "|T1120721:16:16:::64:64:4:64:4:64|t"
local Money_Icon = E.Octo_Func.func_texturefromIcon(133784, 12)-- "|T133784:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T1418621:12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T".."Interface/AddOns/Octo_ToDo/Media/ElvUI/Mail0.tga"..":12:12:::64:64:4:64:4:64|t"
-- local MailBox_Icon = "|T1506457:12:12:::64:64:4:64:4:64|t"
local MailBox_Icon = E.Octo_Func.func_texturefromIcon("Interface/AddOns/"..GlobalAddonName.."/Media/ElvUI/Mail0.tga")
local classColor = C_ClassColor.GetClassColor(classFilename)
local r, g, b = classColor:GetRGB()
local fontObject9 = CreateFont("OctoFont9")
fontObject9:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 9, "OUTLINE")
local fontObject10 = CreateFont("OctoFont10")
fontObject10:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 10, "OUTLINE")
local fontObject11 = CreateFont("OctoFont11")
fontObject11:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 11, "OUTLINE")
local fontObject12 = CreateFont("OctoFont12")
fontObject12:SetFont("Interface\\Addons\\"..GlobalAddonName.."\\Media\\font\\01 Octo.TTF", 12, "OUTLINE")
local curCharName, _ = UnitFullName("PLAYER")
local curServer = GetRealmName()
local TotalTransAnima = 0
local TotalTransParacausalFlakes = 0
-- local E.Octo_Globals.NONE = E.Octo_Globals.Gray_Color.."None|r"
-- local E.Octo_Globals.DONE = E.Octo_Globals.Green_Color.."Done|r"
local isPlayerMaxLevel = GetMaxLevelForExpansionLevel(GetExpansionLevel())
local regionalWeeklyStart = 1668981600
local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8
local edgeFile = "Interface\\Buttons\\WHITE8X8"
local bgFile = "Interface\\Buttons\\WHITE8X8"
local AddonTexture_FIRST = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\AddonTexture_FIRST.tga"
local Meta_Table_0 = {__index = function() return 0 end}
local Meta_Table_1 = {__index = function() return 1 end}
local Meta_Table_false = {__index = function() return false end}
local Meta_Table_true = {__index = function() return true end}
local Meta_Table_DONE = {__index = function() return E.Octo_Globals.DONE end}
local Meta_Table_NONE = {__index = function() return E.Octo_Globals.NONE end}
local Meta_Table_Empty = {__index = function() return "" end}
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_Holiday)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_Reputation)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.OctoTable_itemID_DFMountsSkins)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.T3Items)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_itemID_ALL, E.Octo_Table.Dreamsurges_Items)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_currencyID_ALL, E.Octo_Table.OctoTable_Professions_currencyID)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.FirstAid)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Blacksmithing)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Leatherworking)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Alchemy)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Herbalism)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Cooking)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Mining)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Tailoring)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Engineering)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Enchanting)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Fishing)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Skinning)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Jewelcrafting)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Inscription)
E.Octo_Func.TableConcat(E.Octo_Table.ALL_Professions, E.Octo_Table.Archeology)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Holiday)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Recurring)
E.Octo_Func.TableConcat(E.Octo_Table.OctoTable_EventsIDs, E.Octo_Table.WorldEvents.Uncategorized)
local OctoTable_func_otrisovka_FIRST = {
}
local function Central_Frame_Mouse_OnEnter(self)
	-- if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
	-- 	ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Central_Frame_Mouse_OnEnter".."|r")
	-- end
	-- local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	local parent = Octo_ToDo_FIRST_Frame_Main_Frame["FrameLine"..self.index]
	parent:GetScript("OnEnter")(parent)
	if not self.tooltip then
		return
	end
	-- GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -10)
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
	-- if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
	-- 	ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Central_Frame_Mouse_OnLeave".."|r")
	-- end
	-- local parent = self:GetParent():GetParent()["FrameLine"..self.index]
	local parent = Octo_ToDo_FIRST_Frame_Main_Frame["FrameLine"..self.index]
	parent:GetScript("OnLeave")(parent)
	GameTooltip:Hide()
end
local function CheckReputationByRepID(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CheckReputationByRepID".."|r")
	end
	local vivod = ""
	local friendshipRank, friendshipMaxRank
	local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, _, _, isWatched, isChild, _, hasBonusRepGain, canBeLFGBonus = GetFactionInfoByID(self)
	local color = E.Octo_Globals.White_Color
	local r = "|r"
	local standingTEXT = ""
	if standingID == 1 then
		color = E.Octo_Globals.Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL1..")"
	elseif standingID == 2 then
		color = E.Octo_Globals.Red_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL2..")"
	elseif standingID == 3 then
		color = E.Octo_Globals.Orange_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL3..")"
	elseif standingID == 4 then
		color = E.Octo_Globals.Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL4..")"
	elseif standingID == 5 then
		color = E.Octo_Globals.Yellow_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL5..")"
	elseif standingID == 6 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL6..")"
	elseif standingID == 7 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL7..")"
	elseif standingID == 8 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL8..")"
	elseif standingID == 9 then
		color = E.Octo_Globals.Green_Color
		standingTEXT = " ("..FACTION_STANDING_LABEL9..")"
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(self or 0)
	if C_Reputation.IsFactionParagon(self) then
		local currentValue = C_Reputation.GetFactionParagonInfo(self) or 0
		local threshold = 1
		local _, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(self)
		if threshold then
			local value = currentValue % threshold
			vivod = E.Octo_Globals.Blue_Color..(value).."/"..(threshold)..r
			if hasRewardPending then
				vivod = E.Octo_Func.CheckCompletedByQuestID(rewardQuestID)
			end
		end
	elseif C_Reputation.IsMajorFaction(self) then
		local data = C_MajorFactions.GetMajorFactionData(self)
		local currentValue = data.renownReputationEarned
		local totalValue = data.renownLevelThreshold
		local standing = data.renownLevel
		vivod = (currentValue).."/"..(totalValue)..E.Octo_Globals.Green_Color.."("..(standing)..")|r"
		if standing == 0 then vivod = 0 end
	elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
		local friendshipFactionID = reputationInfo.friendshipFactionID or 0
		local reactionThreshold = reputationInfo.reactionThreshold or 0
		local nextThreshold = reputationInfo.nextThreshold or 0
		local standing = reputationInfo.standing or 0
		local name = reputationInfo.name
		local currentValue = standing-reactionThreshold
		local totalValue = nextThreshold-reactionThreshold
		local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
		local currentLevel, maxLevel
		if rankInfo then
			currentLevel = rankInfo.currentLevel or 0
			maxLevel = rankInfo.maxLevel or 0
		end
		standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
		vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
		if currentLevel == maxLevel then vivod = E.Octo_Globals.Green_Color.."Done|r" end
	else
		if barValue then
			local currentValue = barValue-barMin
			local totalValue = barMax-barMin
			vivod = color..(currentValue).."/"..(totalValue)..standingTEXT..r
			if currentValue == totalValue or nextThreshold == 0 then vivod = E.Octo_Globals.Green_Color.."Done|r" end
		end
	end
	return vivod
end
local function checkCharInfo(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."checkCharInfo".."|r")
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
							-- k это ИД инста
							-- Q это ИД сложности
						end
					end
				end
			end
		end
	end
	for k, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
		for q, w in pairs(v) do
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] or E.Octo_Globals.NONE
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] or E.Octo_Globals.NONE
			self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] = self["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] or E.Octo_Globals.NONE
		end
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
	self.curCovID = self.curCovID or 0
	self.CurrencyID = self.CurrencyID or {}
	self.CurrencyID_maxQuantity = self.CurrencyID_maxQuantity or {}
	self.CurrencyID_Total = self.CurrencyID_Total or {}
	self.curServer = self.curServer or "HZ"
	self.azeriteLVL = self.azeriteLVL or 0
	self.azeriteEXP = self.azeriteEXP or 0
	self.cloak_lvl = self.cloak_lvl or 0
	self.cloak_res = self.cloak_res or 0
	self.curServerShort = self.curServerShort or 0
	self.Faction = self.Faction or 0
	self.ItemsInBag = self.ItemsInBag or {}
	self.KnownSpell = self.KnownSpell or {}
	self.maxNumQuestsCanAccept = self.maxNumQuestsCanAccept or 0
	self.Name = self.Name or 0
	self.needResetDaily = self.needResetDaily or false
	self.needResetWeekly = self.needResetWeekly or false
	self.needResetMonth = self.needResetMonth or false
	self.numQuests = self.numQuests or 0
	self.RaceLocal = self.RaceLocal or 0
	self.RaceEnglish = self.RaceEnglish or 0
	self.raceID = self.raceID or 0
	self.currentXP = self.currentXP or 0
	self.UnitXPMax = self.UnitXPMax or 0
	self.UnitXPPercent = self.UnitXPPercent or 0
	self.numShownEntries = self.numShownEntries or 0
	self.Possible_Anima = self.Possible_Anima or 0
	self.Possible_CatalogedResearch = self.Possible_CatalogedResearch or 0
	self.loginDate = self.loginDate or 0
	self.loginDay = self.loginDay or 0
	self.loginHour = self.loginHour or 0
	self.PVP = self.PVP or {}
	self.OctoTable_QuestID = self.OctoTable_QuestID or {}
	self.reputationID = self.reputationID or {}
	self.Shadowland = self.Shadowland or {}
	self.totalSlots = self.totalSlots or 0
	self.UnitLevel = self.UnitLevel or 0
	self.Money = self.Money or 0
	self.MoneyOnLogin = self.MoneyOnLogin or 0
	self.usedSlots = self.usedSlots or 0
	self.HasAvailableRewards = self.HasAvailableRewards or false
	self.BindLocation = self.BindLocation or 0
	self.CurrentLocation = self.CurrentLocation or 0
	self.islandBfA = self.islandBfA or 0
	self.bounty_BfA1 = self.bounty_BfA1 or 0
	self.bounty_BfA2 = self.bounty_BfA2 or 0
	self.bounty_BfA3 = self.bounty_BfA3 or 0
	self.bounty_BfA1_end = self.bounty_BfA1_end or 0
	self.bounty_BfA2_end = self.bounty_BfA2_end or 0
	self.bounty_BfA3_end = self.bounty_BfA3_end or 0
	self.bounty_BfA1_questID = self.bounty_BfA1_questID or 0
	self.bounty_BfA2_questID = self.bounty_BfA2_questID or 0
	self.bounty_BfA3_questID = self.bounty_BfA3_questID or 0
	self.bounty_BfA1_icon = self.bounty_BfA1_icon or 0
	self.bounty_BfA2_icon = self.bounty_BfA2_icon or 0
	self.bounty_BfA3_icon = self.bounty_BfA3_icon or 0
	self.bounty_Legion1 = self.bounty_Legion1 or 0
	self.bounty_Legion2 = self.bounty_Legion2 or 0
	self.bounty_Legion3 = self.bounty_Legion3 or 0
	self.bounty_Legion1_end = self.bounty_Legion1_end or 0
	self.bounty_Legion2_end = self.bounty_Legion2_end or 0
	self.bounty_Legion3_end = self.bounty_Legion3_end or 0
	self.bounty_Legion1_questID = self.bounty_Legion1_questID or 0
	self.bounty_Legion2_questID = self.bounty_Legion2_questID or 0
	self.bounty_Legion3_questID = self.bounty_Legion3_questID or 0
	self.bounty_Legion1_icon = self.bounty_Legion1_icon or 0
	self.bounty_Legion2_icon = self.bounty_Legion2_icon or 0
	self.bounty_Legion3_icon = self.bounty_Legion3_icon or 0
	self.hasMail = self.hasMail or false
	self.MoneyOnLogin = self.Money
	self.RIO_Score = self.RIO_Score or 0
	self.RIO_weeklyBest = self.RIO_weeklyBest or 0
	self.GreatVault = self.GreatVault or {}
	for i = 1, 3 do
		self.GreatVault[i] = self.GreatVault[i] or {}
		self.GreatVault[i].progress = self.GreatVault[i].progress or 0
		self.GreatVault[i].threshold = self.GreatVault[i].threshold or 0
		self.GreatVault[i].hyperlink = self.GreatVault[i].hyperlink or {}
		self.GreatVault[i].hyperlink_STRING = self.GreatVault[i].hyperlink_STRING or 0
		self.GreatVault[i].hyperlink[1] = self.GreatVault[i].hyperlink[1] or 0
		self.GreatVault[i].hyperlink[2] = self.GreatVault[i].hyperlink[2] or 0
		self.GreatVault[i].hyperlink[3] = self.GreatVault[i].hyperlink[3] or 0
		if i == 1 then
			self.GreatVault[i].type = self.GreatVault[i].type or MYTHIC_DUNGEONS
		elseif i == 2 then
			self.GreatVault[i].type = self.GreatVault[i].type or CALENDAR_TYPE_PVP
		elseif i == 3 then
			self.GreatVault[i].type = self.GreatVault[i].type or RAIDS
		end
	end
	setmetatable(self, Meta_Table_0)
	setmetatable(self.CurrencyID_maxQuantity, Meta_Table_0)
	setmetatable(self.CurrencyID_Total, Meta_Table_0)
	setmetatable(self.CurrencyID, Meta_Table_0)
	setmetatable(self.ItemsInBag, Meta_Table_0)
	setmetatable(self.KnownSpell, Meta_Table_false)
	setmetatable(self.PVP, Meta_Table_0)
	setmetatable(self.OctoTable_QuestID, Meta_Table_NONE)
	setmetatable(self.reputationID, Meta_Table_0)
	setmetatable(self.Shadowland, Meta_Table_0)
	if (self.tmstp_Weekly or 0) < GetServerTime() and (self.GreatVault[1].hyperlink_STRING ~= 0 or self.GreatVault[2].hyperlink_STRING ~= 0 or self.GreatVault[3].hyperlink_STRING ~= 0) then
		self.HasAvailableRewards = true
		self.GreatVault = {}
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
		self.RIO_weeklyBest = 0
		for k, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Weekly_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
	end
	if (self.tmstp_Daily or 0) < GetServerTime() then
		self.tmstp_Daily = E.Octo_Func.tmstpDayReset(1)
		self.needResetDaily = true
		Octo_ToDo_SmartCollectNEW2.Holiday.Active = {}
		Octo_ToDoVars.config.AnotherAddonsCasual = false
		Octo_ToDoVars.config.AnotherAddonsRAID = false
		for k, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Daily_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
		self.LFGInstance = {}
		self.bounty_BfA1 = 0
		self.bounty_BfA2 = 0
		self.bounty_BfA3 = 0
		self.bounty_BfA1_end = 0
		self.bounty_BfA2_end = 0
		self.bounty_BfA3_end = 0
		self.bounty_BfA1_questID = 0
		self.bounty_BfA2_questID = 0
		self.bounty_BfA3_questID = 0
		self.bounty_BfA1_icon = 0
		self.bounty_BfA2_icon = 0
		self.bounty_BfA3_icon = 0
		self.bounty_Legion1 = 0
		self.bounty_Legion2 = 0
		self.bounty_Legion3 = 0
		self.bounty_Legion1_end = 0
		self.bounty_Legion2_end = 0
		self.bounty_Legion3_end = 0
		self.bounty_Legion1_questID = 0
		self.bounty_Legion2_questID = 0
		self.bounty_Legion3_questID = 0
		self.bounty_Legion1_icon = 0
		self.bounty_Legion2_icon = 0
		self.bounty_Legion3_icon = 0
	end
	for dungeonID, name in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
		self.LFGInstance[dungeonID] = self.LFGInstance[dungeonID] or {}
		self.LFGInstance[dungeonID].D_name = self.LFGInstance[dungeonID].D_name or name
		self.LFGInstance[dungeonID].donetoday = self.LFGInstance[dungeonID].donetoday or E.Octo_Globals.NONE
	end
	if (self.tmstp_Month or 0) < GetServerTime() then
		self.tmstp_Month = E.Octo_Func.tmstpDayReset(30)
		self.needResetMonth = true
		-- self.ItemsInBag[23247] = 0
		for k, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
			for q, w in pairs(v) do
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_name"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.NONE
				self["Octopussy_"..v.expansion.."_Month_"..v.desc..v.place..v.name_save.."_questID"] = E.Octo_Globals.NONE
			end
		end
	end
end
local function CreateFrameUsableItems_OnEnter(self)
	-- if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
	-- 	ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems_OnEnter".."|r")
	-- end
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 0)
	--
	local itemLink = select(2, GetItemInfo(self.itemID))
	if itemLink then
		GameTooltip:ClearLines()
		GameTooltip:SetHyperlink(itemLink)
		GameTooltip:Show()
	end
	self:SetBackdropBorderColor(r, g, b, 1)
end
local function CreateFrameUsableItems_OnLeave(self)
	-- if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
	-- 	ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems_OnLeave".."|r")
	-- end
	local hasToy = PlayerHasToy(self.itemID)
	local hasItem = GetItemCount(self.itemID, true, true, true) <= self.count
	if hasToy == true or hasItem == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	GameTooltip:ClearLines()
	GameTooltip:Hide()
	self:SetBackdropBorderColor(0, 0, 0, 1)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
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
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems_OnEvent".."|r"..event)
	end
	if (event == "TOYS_UPDATED"  or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
		local startTime, duration = C_Container.GetItemCooldown(self.itemID)
		local hasToy = PlayerHasToy(self.itemID)
		local hasItem = GetItemCount(self.itemID, true, true, true) <= self.count
		if hasToy == true or hasItem == true then
			self.icon:SetDesaturated(false)
			self.icon:SetAlpha(1)
		else
			self.icon:SetDesaturated(true)
			self.icon:SetAlpha(.5)
		end
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == false then
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
		self:SetParent(Octo_ToDo_FIRST_Frame_Main_Frame)
		self:SetPoint("BOTTOMLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableItems_OnMouseDown(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems_OnMouseDown".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, E.Octo_Globals.BGALPHA)
end
local function CreateFrameUsableItems_OnMouseUp(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems_OnMouseUp".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, 1)
end
local function CreateFrameUsableItems(itemID, Texture, count, Xpos, Ypos, r, g, b, spellID)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableItems".."|r")
	end
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.itemID = itemID
	Button.Texture = Texture
	Button.count = count
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	-- Button:SetPoint("TOPRIGHT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPLEFT", Xpos-1, Ypos)
	Button:SetPoint("BOTTOMLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- Button:SetBackdropBorderColor(r, g, b, 1)
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:HookScript("OnEvent", CreateFrameUsableItems_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableItems_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableItems_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableItems_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableItems_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/use item:"..itemID)
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	-- t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
--
local function CreateFrameUsableSpells_OnEnter(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells_OnEnter".."|r")
	end
	self.icon:SetVertexColor(1, 1, 1, 1)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 0, 0)
	--
	-- local startTime, duration = GetSpellCooldown(self.spellID)
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
	self:SetBackdropBorderColor(r, g, b, 1)
	local link = GetSpellLink(self.spellID)
	if link then
		GameTooltip:ClearLines()
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end
local function CreateFrameUsableSpells_OnLeave(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells_OnLeave".."|r")
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
	--
	-- local startTime, duration = GetSpellCooldown(self.spellID)
	-- if startTime ~= nil and startTime ~= 0 then
	-- 	GameTooltip:ClearLines()
	-- 	GameTooltip:Hide()
	-- 	-- self.icon:SetDesaturated(true)
	-- 	-- self.icon:SetAlpha(.5)
	-- else
	-- 	GameTooltip:ClearLines()
	-- 	GameTooltip:Hide()
	-- 	-- self.icon:SetDesaturated(false)
	-- 	-- self.icon:SetAlpha(1)
	-- end
	--
end
local function CreateFrameUsableSpells_OnEvent(self, event)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells_OnEvent".."|r")
	end
	if (event == "TOYS_UPDATED"  or event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" or event == "SPELLS_CHANGED" or event == "SPELL_UPDATE_CHARGES" or event == "SPELL_UPDATE_COOLDOWN" or event == "TRAINER_UPDATE") and not InCombatLockdown() then
		local startTime, duration = GetSpellCooldown(self.spellID)
		local isKnown = IsSpellKnown(self.spellID)
		if isKnown == true then
			self.icon:SetVertexColor(1, 1, 1, 1)
			-- self.icon:SetDesaturated(false)
			-- self.icon:SetAlpha(1)
		else
			self.icon:SetVertexColor(1, .5, .5, .3)
			-- self.icon:SetDesaturated(true)
			-- self.icon:SetAlpha(.5)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		self:SetParent(UIParent)
		self:ClearAllPoints()
		self:Hide()
	else
		self:SetParent(Octo_ToDo_FIRST_Frame_Main_Frame)
		self:SetPoint("BOTTOMLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPLEFT", self.Xpos, self.Ypos+1)
		self:Show()
	end
end
local function CreateFrameUsableSpells_OnMouseDown(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells_OnMouseDown".."|r")
	end
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end
local function CreateFrameUsableSpells_OnMouseUp(self)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells_OnMouseUp".."|r")
	end
	local isKnown = IsSpellKnown(self.spellID)
	if isKnown == true then
		self.icon:SetVertexColor(1, 1, 1, 1)
	else
		self.icon:SetVertexColor(1, .5, .5, .3)
	end
end
local function CreateFrameUsableSpells(spellID, Texture, Xpos, Ypos, r, g, b)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."CreateFrameUsableSpells".."|r")
	end
	local Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "SecureActionButtonTemplate, BackDropTemplate")
	Button.spellID = spellID
	Button.Texture = Texture
	Button.Ypos = Ypos
	Button.Xpos = Xpos
	Button.r = r
	Button.g = g
	Button.b = b
	Button.spellID = spellID
	Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
	Button:SetPoint("BOTTOMLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPLEFT", Xpos, Ypos+1)
	Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
	-- Button:SetBackdropBorderColor(r, g, b, 1)
	Button:SetBackdropBorderColor(0, 0, 0, 1)
	Button:RegisterEvent("PLAYER_REGEN_DISABLED")
	Button:RegisterEvent("PLAYER_REGEN_ENABLED")
	Button:HookScript("OnEvent", CreateFrameUsableSpells_OnEvent)
	Button:HookScript("OnEnter", CreateFrameUsableSpells_OnEnter)
	Button:HookScript("OnLeave", CreateFrameUsableSpells_OnLeave)
	Button:HookScript("OnMouseDown", CreateFrameUsableSpells_OnMouseDown)
	Button:HookScript("OnMouseUp", CreateFrameUsableSpells_OnMouseUp)
	Button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
	Button:SetAttribute("type", "macro")
	Button:SetAttribute("macrotext", "/cast "..GetSpellInfo(spellID))
	local t = Button:CreateTexture(nil, "BACKGROUND")
	Button.icon = t
	t:SetTexture(Texture)
	-- t:SetVertexColor(1, 1, 1, 1)
	t:SetAllPoints(Button)
	Button:GetScript("OnEvent")(Button, "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED" or "SPELLS_CHANGED" or "SPELL_UPDATE_COOLDOWN")
	return Button
end
function Collect_ALL_PlayerInfo()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_PlayerInfo()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	--
	local specId, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	local RaceLocal, RaceEnglish, raceID = UnitRace("PLAYER")
	local curServerShort = GetRealmName()
	local text = (curServerShort):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		curServerShort = E.Octo_Func.WA_Utf8Sub(a, 1)..E.Octo_Func.WA_Utf8Sub(b, 1):upper() else curServerShort = E.Octo_Func.WA_Utf8Sub(a, 3):lower()
	end
	if collect and not InCombatLockdown() then
		collect.curServerShort = curServerShort
		collect.Name = curCharName
		collect.curServer = curServer
		collect.className = className
		collect.classFilename = classFilename
		collect.classId = classId
		collect.GUID = curGUID
		collect.Faction = UnitFactionGroup("PLAYER")
		collect.specId = specId
		collect.specName = specName
		collect.specIcon = specIcon
		collect.classColor = classColor or {r = 0.5, g = 0.5, b = 0.5}
		collect.RaceLocal = RaceLocal
		collect.RaceEnglish = RaceEnglish
		collect.raceID = raceID
		collect.classColorHex = E.Octo_Func.func_rgb2hex(classColor.r, classColor.g, classColor.b)
	end
end
function Collect_Player_Level()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_Player_Level()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	--
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
function Collect_ALL_Mail()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_Mail()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local hasMail = HasNewMail()
	if collect and not InCombatLockdown() then
		collect.hasMail = hasMail
	end
end
function Collect_ALL_KnownSpell()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_KnownSpell()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	for k, v in ipairs(E.Octo_Table.OctoTable_SpellID) do
		local isKnown = IsSpellKnown(v)
		if collect and not InCombatLockdown() then
			collect.KnownSpell[v] = isKnown
		end
	end
	-- for k, v in ipairs(E.Octo_Table.OctoTable_Portals) do
	-- local isKnown = IsSpellKnown(v)
	-- if collect and not InCombatLockdown() then
	-- collect.KnownSpell[v] = isKnown
	-- end
	-- end
end
function Collect_BfA_Azerite()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_BfA_Azerite()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		if totalLevelXP and totalLevelXP ~= 0 then
			if collect and not InCombatLockdown() then
				collect.azeriteLVL = currentLevel
				collect.azeriteEXP = floor(xp / totalLevelXP * 100).."%, -"..E.Octo_Func.CompactNumberFormat(totalLevelXP - xp)
			end
		end
	end
end
function Collect_BfA_Cloaklvl()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_BfA_Cloaklvl()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
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
			inspectScantip:SetInventoryItem("player", 15)
			if inspectScantip:NumLines() > 0 then
				for j = 2, inspectScantip:NumLines() do
					local text = _G["OctoToDoScanningTooltipTextLeft"..j]:GetText()
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
			inspectScantip:ClearLines()
		end
	else
		collect.cloak_lvl = 0
		collect.cloak_res = 0
	end
end
-- function Collect_Legion_Artifact()
-- 	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
-- 		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_Legion_Artifact()".."|r")
-- 	end
-- 	local curGUID = UnitGUID("PLAYER")
-- 	local collect = Octo_ToDoLevels[curGUID]
-- 	local _, _, _, quantity1, reqQuantity1 = GetAchievementCriteriaInfo(11152, 1)
-- 	local _, _, _, quantity2, reqQuantity2 = GetAchievementCriteriaInfo(11153, 1)
-- 	local _, _, _, quantity3, reqQuantity3 = GetAchievementCriteriaInfo(11154, 1)
-- end
function Collect_ALL_LoginTime()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_LoginTime()".."|r")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	collect.loginDate = date("%d.%m.%Y %H:%M:%S")
	collect.loginDay = date("%d.%m.%Y")
	collect.loginHour = date("%H:%M")
	collect.needResetWeekly = false
	collect.needResetDaily = false
	collect.needResetMonth = false
end
function Collect_SL_CovenantAnima()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_SL_CovenantAnima()".."|r")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local CovenantNames = {
		[1] = "Kyrian",
		[2] = "Venthyr",
		[3] = "NightFae",
		[4] = "Necrolord",
	}
	local curCovID = C_Covenants.GetActiveCovenantID()
	local curCovName = CovenantNames[curCovID]
	local curCovLevel = C_CovenantSanctumUI.GetRenownLevel()
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(1813)
	local curAnimaAmount = currencyInfo.quantity
	if curCovID == 0 then return end
	if curCovID == 1 then
		collect.Shadowland[1] = curCovLevel or 0
		collect.Shadowland[2] = curAnimaAmount or 0
	elseif curCovID == 2 then
		collect.Shadowland[3] = curCovLevel or 0
		collect.Shadowland[4] = curAnimaAmount or 0
	elseif curCovID == 3 then
		collect.Shadowland[5] = curCovLevel or 0
		collect.Shadowland[6] = curAnimaAmount or 0
	elseif curCovID == 4 then
		collect.Shadowland[7] = curCovLevel or 0
		collect.Shadowland[8] = curAnimaAmount or 0
	end
	collect.curCovID = curCovID
end
function Collect_ALL_PVPRaitings()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_PVPRaitings()".."|r")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
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
	Octo_ToDoLevels[curGUID].PVP.rating2v2 = rating2v2
	Octo_ToDoLevels[curGUID].PVP.seasonBest2v2 = seasonBest2v2
	Octo_ToDoLevels[curGUID].PVP.winrate2v2 = winrate2v2
	Octo_ToDoLevels[curGUID].PVP.rating3v3 = rating3v3
	Octo_ToDoLevels[curGUID].PVP.seasonBest3v3 = seasonBest3v3
	Octo_ToDoLevels[curGUID].PVP.winrate3v3 = winrate3v3
	Octo_ToDoLevels[curGUID].PVP.ratingRBG = ratingRBG
	Octo_ToDoLevels[curGUID].PVP.seasonBestRBG = seasonBestRBG
	Octo_ToDoLevels[curGUID].PVP.winrateRBG = winrateRBG
end
function Collect_All_Professions()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Professions()".."|r")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if collect then
		collect.professions = {}
		-- collect.professions = collect.professions or {}
		--
		local chest_count = 0
		local craftOrder_count = 0
		local drops_count = 0
		local profQuest_count = 0
		local treatise_count = 0
		--
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
				collect.professions[skillLine].icon = E.Octo_Func.func_texturefromIcon(icon)
				collect.professions[skillLine].skillLevel = skillLevel
				collect.professions[skillLine].maxSkillLevel = maxSkillLevel
				collect.professions[skillLine].numAbilities = numAbilities
				collect.professions[skillLine].spelloffset = spelloffset
				collect.professions[skillLine].skillLine = skillLine
				collect.professions[skillLine].skillModifier = skillModifier
				collect.professions[skillLine].specializationIndex = specializationIndex
				collect.professions[skillLine].specializationOffset = specializationOffset
			end
			table[171] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66373, 66374}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 2, questID = {70511, 70504}},
				profQuest = {questReq = 2, questID = {70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937}},
				treatise = {questReq = 1, questID = {74108}},
			}
			table[164] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66381, 66382}},
				craftOrder = {questReq = 1, questID = {70589}},
				drops = {questReq = 2, questID = {70513, 70512}},
				profQuest = {questReq = 2, questID = {66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211}},
				treatise = {questReq = 1, questID = {74109}},
			}
			table[333] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66377, 66378}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 2, questID = {70515, 70514}},
				profQuest = {questReq = 2, questID = {66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423}},
				treatise = {questReq = 1, questID = {74110}},
			}
			table[202] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66379, 66380}},
				craftOrder = {questReq = 1, questID = {70591}},
				drops = {questReq = 2, questID = {70517, 70516}},
				profQuest = {questReq = 2, questID = {72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539}},
				treatise = {questReq = 1, questID = {74111}},
			}
			table[182] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {71857, 71858, 71859, 71860, 71861, 71864}},
				profQuest = {questReq = 1, questID = {70614, 70613, 70616, 70615}},
				treatise = {questReq = 1, questID = {74107}},
			}
			table[773] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66375, 66376}},
				craftOrder = {questReq = 1, questID = {70592}},
				drops = {questReq = 2, questID = {70519, 70518}},
				profQuest = {questReq = 2, questID = {66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438}},
				treatise = {questReq = 1, questID = {74105}},
			}
			table[755] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66388, 66389}},
				craftOrder = {questReq = 1, questID = {70593}},
				drops = {questReq = 2, questID = {70521, 70520}},
				profQuest = {questReq = 2, questID = {66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562}},
				treatise = {questReq = 1, questID = {74112}},
			}
			table[165] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66384, 66385}},
				craftOrder = {questReq = 1, questID = {70594}},
				drops = {questReq = 2, questID = {70523, 70522}},
				profQuest = {questReq = 2, questID = {66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363}},
				treatise = {questReq = 1, questID = {74113}},
			}
			table[186] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {72160, 72161, 72162, 72163, 72164, 72165}},
				profQuest = {questReq = 1, questID = {70617, 70618, 72157, 72156}},
				treatise = {questReq = 1, questID = {74106}},
			}
			table[393] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {}},
				craftOrder = {questReq = 0, questID = {}},
				drops = {questReq = 6, questID = {70381, 70383, 70384, 70385, 70386, 70389}},
				profQuest = {questReq = 4, questID = {70620, 72159, 70619, 72158}},
				treatise = {questReq = 1, questID = {74114}},
			}
			table[197] = {
				name = name,
				icon = "|T"..icon..":16:16:::64:64:4:60:4:60|t",
				chest = {questReq = 2, questID = {66386, 66387}},
				craftOrder = {questReq = 1, questID = {70595}},
				drops = {questReq = 2, questID = {70524, 70525}},
				profQuest = {questReq = 2, questID = {72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899}},
				treatise = {questReq = 1, questID = {74115}},
			}
			if E.Octo_Table.Octo_ProfessionsskillLine[skillLine] then
				for _, v in ipairs(table[skillLine].chest.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						chest_count = chest_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].craftOrder.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						craftOrder_count = craftOrder_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].drops.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						drops_count = drops_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].profQuest.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						profQuest_count = profQuest_count + 1
					end
				end
				for _, v in ipairs(table[skillLine].treatise.questID) do
					if C_QuestLog.IsQuestFlaggedCompleted(v) == true then
						treatise_count = treatise_count + 1
					end
				end
				collect.professions[skillLine].chest = {questReq = table[skillLine].chest.questReq, chest_count = chest_count}
				collect.professions[skillLine].craftOrder = {questReq = table[skillLine].craftOrder.questReq, craftOrder_count = craftOrder_count}
				collect.professions[skillLine].drops = {questReq = table[skillLine].drops.questReq, drops_count = drops_count}
				collect.professions[skillLine].profQuest = {questReq = table[skillLine].profQuest.questReq, profQuest_count = profQuest_count}
				collect.professions[skillLine].treatise = {questReq = table[skillLine].treatise.questReq, treatise_count = treatise_count}
			end
		end
	end
	return
end
function Collect_ALL_GreatVault()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_GreatVault".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	--
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
	collect.RIO_Score = C_ChallengeMode.GetOverallDungeonScore("PLAYER")
	collect.RIO_weeklyBest = currentWeekBestLevel
	--
	for _, i in pairs(Enum.WeeklyRewardChestThresholdType) do
		local test
		local hyperlink_STRING
		local activities = C_WeeklyRewards.GetActivities(i)
		for k = 1, 3 do
			local activityInfo = activities[k]
			if activityInfo then
				local type = activityInfo.type
				if collect and type ~= 0 and type ~= nil then
					collect.GreatVault[type] = collect.GreatVault[type] or {}
					collect.GreatVault[type].progress = activityInfo.progress
					collect.GreatVault[type].threshold = activityInfo.threshold
					local hyperlink = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					if hyperlink then
						collect.GreatVault[type].hyperlink[k] = hyperlink
					end
					if type == 1 then collect.GreatVault[type].type = MYTHIC_DUNGEONS end
					if type == 2 then collect.GreatVault[type].type = CALENDAR_TYPE_PVP end
					if type == 3 then collect.GreatVault[type].type = RAIDS end
					--
					hyperlink_STRING = GetDetailedItemLevelInfo(C_WeeklyRewards.GetExampleRewardItemHyperlinks(activityInfo.id))
					if hyperlink and type == 1 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
					if hyperlink and type == 2 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
					if hyperlink and type == 3 then
						test = test and test..", "..hyperlink_STRING or hyperlink_STRING
						if test ~= nil then
							collect.GreatVault[type].hyperlink_STRING = test
						end
					end
				end
			end
		end
	end
	--
end
local function func_coloredText(fontstring)
	if not fontstring then return nil end
	local text = fontstring:GetText()
	if not text then return nil end
	local r, g, b, a = fontstring:GetTextColor()
	return E.Octo_Func.func_rgb2hex(r, g, b, a)..text.."|r"
end
function Collect_All_Currency()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Currency()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	for k, v in ipairs(E.Octo_Table.OctoTable_currencyID_ALL) do
		local data = C_CurrencyInfo.GetCurrencyInfo(v)
		local quantity = data.quantity
		local maxQuantity = data.maxQuantity
		if v == 2167 and maxQuantity > 6 then maxQuantity = 6 end
		if collect and not InCombatLockdown() then
			collect.CurrencyID[v] = quantity
			collect.CurrencyID_maxQuantity[v] = maxQuantity
			if maxQuantity ~= 0 then
				if quantity ~= maxQuantity then
					if quantity ~= 0 then
						collect.CurrencyID_Total[v] = quantity.."/"..maxQuantity
					else
						collect.CurrencyID_Total[v] = E.Octo_Globals.Gray_Color..quantity.."/"..maxQuantity.."|r"
					end
				else
					collect.CurrencyID_Total[v] = E.Octo_Globals.Green_Color..quantity.."/"..maxQuantity.."|r"
				end
			else
				if quantity ~= 0 then
					collect.CurrencyID_Total[v] = quantity
				else
					collect.CurrencyID_Total[v] = E.Octo_Globals.Gray_Color..quantity.."|r"
				end
			end
		end
	end
end
function Collect_ALL_ItemsInBag()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_ItemsInBag()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	--
	local PlayerReagentnumSlots = C_Container.GetContainerNumSlots(BACKPACK_CONTAINER+NUM_BAG_SLOTS+1)
	local usedSlots = 0
	local totalSlots = 0
	local Possible_Anima = 0
	local Possible_CatalogedResearch = 0
	local Abbr_En_Name = E.Octo_Globals.NONE
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
				-- KeyLevel
				local stackCount = containerInfo.stackCount
				local itemID = containerInfo.itemID
				local quality = containerInfo.quality
				local hyperlink = containerInfo.hyperlink
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(hyperlink)
				if hyperlink:find("keystone:180653") or hyperlink:find("keystone:138019") or hyperlink:find("keystone:158923") then
					-- if hyperlink:find("Каражан") then
					-- hyperlink = hyperlink:gsub("^[^:]+: ", "Кара: ")
					-- elseif hyperlink:find("Мехагон") then
					-- hyperlink = hyperlink:gsub("^[^ ]+ ", "")
					-- end
					local dungeonID = select(3, strsplit(":", hyperlink)) -- COLLECT ИД ключа
					local lvl = select(4, strsplit(":", hyperlink)) -- COLLECT уровень ключа CurrentKeyLevel
					collect.CurrentKeyLevel = tonumber(lvl)
					collect.CurrentKeyFULL = C_ChallengeMode.GetMapUIInfo(dungeonID) -- COLLECT название ключа CurrentKeyFULL
					for k, v in ipairs(E.Octo_Table.OctoTable_KeystoneAbbr) do
						if v.mapChallengeModeID == tonumber(dungeonID) then
							collect.CurrentKey = E.Octo_Globals.Purple_Color..lvl.." "..v.abbreviation.."|r"
						end
					end
				end
				-- Cataloged Research
				for k, v in pairs(E.Octo_Table.OctoTable_itemID_Cataloged_Research) do
					if itemID == v.itemiD then
						Possible_CatalogedResearch = Possible_CatalogedResearch + v.count
					end
				end
				-- Possible Anima
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
			end
		end
	end
	if collect and not InCombatLockdown() then
		for k, v in ipairs(E.Octo_Table.OctoTable_itemID_ALL) do
			local count = GetItemCount(v, true, true, true)
			collect.ItemsInBag[v] = count
		end
		collect.Possible_Anima = Possible_Anima
		collect.Possible_CatalogedResearch = Possible_CatalogedResearch
		collect.PlayerReagentnumSlots = PlayerReagentnumSlots
		collect.usedSlots = usedSlots
		collect.totalSlots = totalSlots
		collect.HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
	end
	--
end
function Collect_ALL_Locations()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_Locations()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
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
function Collect_All_Reputations()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Reputations()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if collect and not InCombatLockdown() then
		for k, v in pairs(E.Octo_Table.OctoTable_reputation_ALL) do
			local rep = CheckReputationByRepID(v)
			collect.reputationID[v] = rep or 0
		end
	end
end
function Collect_All_Quests()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Quests()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
	local maxNumQuestsCanAccept = C_QuestLog.GetMaxNumQuestsCanAccept()
	for k, v in ipairs(E.Octo_Table.OctoTable_QuestID) do
		local questID = E.Octo_Func.CheckCompletedByQuestID(v)
		collect.OctoTable_QuestID[v] = questID or 0
	end
	if collect and not InCombatLockdown() then
		collect.numShownEntries = numShownEntries
		collect.numQuests = numQuests
		collect.maxNumQuestsCanAccept = maxNumQuestsCanAccept
	end
end
function Collect_BfA_Island()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_BfA_Island()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	if questID then
		if collect and not InCombatLockdown() then
			collect.islandBfA = E.Octo_Func.CheckCompletedByQuestID(questID)
		end
	end
end
function Collect_BfA_QuestsBounties()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_BfA_QuestsBounties()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
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
				collect["bounty_Legion"..i] = E.Octo_Func.CheckCompletedByQuestID(d.questID)
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
					collect["bounty_BfA"..i] = E.Octo_Func.CheckCompletedByQuestID(d.questID)
					collect["bounty_BfA"..i.."_icon"] = faction_icon
					collect["bounty_BfA"..i.."_questID"] = d.questID
					collect["bounty_BfA"..i.."_end"] = time() + secondsLeft * 60
				end
			end
		end
	end
end
function Collect_ALL_ItemLevel()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_ItemLevel()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
	if collect and not InCombatLockdown() then
		collect.avgItemLevel = math.floor(avgItemLevel)
		collect.avgItemLevelEquipped = math.floor(avgItemLevelEquipped)
		collect.avgItemLevelPvp = math.floor(avgItemLevelPvp)
	end
end
function Collect_ALL_UNIVERSALQuestUpdate()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_UNIVERSALQuestUpdate()".."|r")
	end
	local UnitLevel = UnitLevel("PLAYER")
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local IsOnQuest = false
	for k, v in pairs(E.Octo_Table.OctoTable_UniversalQuest) do
		for q, w in pairs(v) do
			local count = 0
			local vivod = ""
			for z, x in pairs(v.questID) do
				IsOnQuest = C_QuestLog.IsOnQuest(x)
				if v.max > 1 then
					if C_QuestLog.IsQuestFlaggedCompleted(x) == true then
						count = count + 1
					end
					vivod = count
				else
					local IsComplete = E.Octo_Func.CheckCompletedByQuestID(x)
					if IsComplete ~= E.Octo_Globals.NONE then
						vivod = IsComplete
					end
				end
				if IsOnQuest == true then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_questID"] = x or E.Octo_Globals.NONE
				end
			end
			if collect and not InCombatLockdown() then
				collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_name"] = v.name_quest or E.Octo_Globals.NONE
				if v.max == 1 then
					collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = vivod
				elseif v.max > 1 then
					if vivod == v.max and v.max > 1 then
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = E.Octo_Globals.DONE
					else
						collect["Octopussy_"..v.expansion.."_"..v.reset.."_"..v.desc..v.place..v.name_save.."_count"] = vivod.."/"..v.max
					end
				end
			end
		end
	end
end
function Collect_ALL_MoneyUpdate()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_MoneyUpdate()".."|r")
	end
	-- local curGUID = UnitGUID("PLAYER")
	Octo_ToDoLevels[UnitGUID("PLAYER")].Money = GetMoney()
	-- local Money = GetMoney()
	-- if collect and not InCombatLockdown() then
	-- 	collect.Money = Money
	-- end
end
function Collect_ALL_MoneyOnLogin()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_ALL_MoneyOnLogin()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local Money = GetMoney()
	if collect and not InCombatLockdown() then
		collect.MoneyOnLogin = Money
	end
end
function Collect_All_Legion_Transmoge()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Legion_Transmoge()".."|r")
	end
	-- local curGUID = UnitGUID("PLAYER")
	-- local collect = Octo_ToDoLevels[curGUID]
	--
	local _, playerClass, classID = UnitClass("player")
	for classFilename, v in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA) do -- classList
		for itemID in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename]) do -- artifactList
			local artifactData = E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename][itemID]
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
					local vivod = E.Octo_Globals.NONE
					if isCollected == true then
						vivod = E.Octo_Globals.DONE
					else
						vivod = E.Octo_Globals.Red_Color.."None|r"
					end
					if classFilename and itemID and visualID then
						if Octo_ToDoArtifact == nil then
							Octo_ToDoArtifact = {}
						end
						if Octo_ToDoArtifact[classFilename] == nil then
							Octo_ToDoArtifact[classFilename] = {}
						end
						if Octo_ToDoArtifact[classFilename][itemID] == nil then
							Octo_ToDoArtifact[classFilename][itemID] = {}
						end
						if Octo_ToDoArtifact[classFilename][itemID][visualID] == nil then
							Octo_ToDoArtifact[classFilename][itemID][visualID] = {}
						end
						setmetatable(Octo_ToDoArtifact[classFilename][itemID][visualID], Meta_Table_0)
						if Octo_ToDoArtifact[classFilename][itemID][visualID] then
							local collect_Artifact = Octo_ToDoArtifact[classFilename][itemID][visualID]
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
							if E.Octo_Globals.UNLOCK_DATA[data.unlock] then
								local unlock = E.Octo_Globals.UNLOCK_DATA[data.unlock].unlock
								local unlockOCto = E.Octo_Globals.UNLOCK_DATA[data.unlock].unlockOCto
								local unlockAchievementID = E.Octo_Globals.UNLOCK_DATA[data.unlock].AchievementID
								collect_Artifact.unlock = unlock
								collect_Artifact.unlockOCto = unlockOCto
								collect_Artifact.unlockAchievementID = unlockAchievementID
							end
						end
					end
				end
			end
		end
	end
end

local function function_setBackup()
	-- local backup = calendar.filterBackup
	-- backup.calendarShowHolidays = GetCVarBool("calendarShowHolidays")
	-- backup.calendarShowDarkmoon = GetCVarBool("calendarShowDarkmoon")
	-- backup.calendarShowLockouts = GetCVarBool("calendarShowLockouts")
	-- backup.calendarShowWeeklyHolidays = GetCVarBool("calendarShowWeeklyHolidays")
	-- backup.calendarShowBattlegrounds = GetCVarBool("calendarShowBattlegrounds")

	-- if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "1") end
	-- if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "1") end
	-- if backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "0") end
	-- if backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "0") end
	-- if backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "0") end

	-- self.dateBackup = C_Calendar.GetMonthInfo()
	-- if CalendarFrame then
	-- 	CalendarFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	-- 	CalendarEventPickerFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	-- end
end



local function function_restoreBackup()
	-- local backup = calendar.filterBackup
	-- if not backup.calendarShowHolidays then SetCVar("calendarShowHolidays", "0") end
	-- if not backup.calendarShowDarkmoon then SetCVar("calendarShowDarkmoon", "0") end
	-- if backup.calendarShowLockouts then SetCVar("calendarShowLockouts", "1") end
	-- if backup.calendarShowWeeklyHolidays then SetCVar("calendarShowWeeklyHolidays", "1") end
	-- if backup.calendarShowBattlegrounds then SetCVar("calendarShowBattlegrounds", "1") end

	-- C_Calendar.SetAbsMonth(self.dateBackup.month, self.dateBackup.year)
	-- if CalendarFrame then
	-- 	CalendarFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	-- 	CalendarEventPickerFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	-- end
end


function Collect_All_Holiday()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Holiday()".."|r")
	end
	function_setBackup()
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDo_SmartCollectNEW2.Holiday
	if not IsAddOnLoaded("Blizzard_Calendar") then
		LoadAddOn("Blizzard_Calendar")
		ShowUIPanel(CalendarFrame, true)
		HideUIPanel(CalendarFrame)
		-- Calendar_Toggle()
		-- CalendarFrame:Hide()
	end
	--
	local ShowALL = true
	local vivod = ""
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local month = 0
	local minute = currentCalendarTime.minute -- The current time in minutes [0-59]
	local hour = currentCalendarTime.hour -- The current time in hours [0-23]
	local weekday = currentCalendarTime.weekday -- The current day of the week (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
	local monthDay = currentCalendarTime.monthDay -- The current day of the month [1-31]
	-- local month = currentCalendarTime.month -- The current month [1-12]
	local year = currentCalendarTime.year -- The current year (e.g. 2019)
	local numDayEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	for i = 1, numDayEvents do
		local event = C_Calendar.GetDayEvent(month, monthDay, i)
		local id = event.eventID
		local title = event.title
		local sequenceType = event.sequenceType
		collect.Collect[id] = title
		-- collect.Collect[id] = collect.Collect[id] or {}
		-- collect.Collect[id].title = title
		-- collect.Collect[id].sequenceType = sequenceType or E.Octo_Globals.NONE
		local startTime = event.startTime
		local endTime = event.endTime
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
			if sequenceType ~= "END" then
				-- if E.Octo_Table.OctoTable_EventsIDs[title] then
				-- if title and E.Octo_Table.OctoTable_EventsIDs[id] then
				if collect.Active[id] == nil then
					collect.Active[id] = {}
				end
				collect.Active[id].id = id
				collect.Active[id].title = title
				collect.Active[id].sequenceType = sequenceType
				collect.Active[id].vivod = E.Octo_Globals.Yellow_Color..title.."|r до: "..endTime_monthDay.."/"..endTime_month.."/"..endTime_year
				collect.Active[id].startTime = startTime_monthDay.."/"..startTime_month.."/"..startTime_year
				collect.Active[id].endTime = endTime_monthDay.."/"..endTime_month.."/"..endTime_year
				if vivod ~= "" then
					vivod = vivod.."\n"
				end
				vivod = vivod..E.Octo_Globals.Yellow_Color..title.."|r до: "..endTime_monthDay.."/"..endTime_month.."/"..endTime_year
				-- end
			end
		end
	end
	function_restoreBackup()
end
local function IsInArray(arr, subj)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."IsInArray".."|r")
	end
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end
function Collect_All_journalInstance()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_journalInstance()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if not InCombatLockdown() then
		--
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
		--
		local numsaved = GetNumSavedInstances()
		local DiffAbbr = ""
		local instancesLastBoss = {}
		local ServerTime = GetServerTime()
		-- collect.journalInstance = {}
		-- local res = {}
		if collect.journalInstance == 0 then
			collect.journalInstance = {}
		end
		collect.journalInstance = collect.journalInstance or {}
		if numsaved > 0 then
			--
			for i = 1, numsaved do
				local instanceName, lockoutId, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, totalBosses, defeatedBosses, extendDisabled, instanceId = GetSavedInstanceInfo(i)
				collect.journalInstance[instanceId] = collect.journalInstance[instanceId] or {}
				collect.journalInstance[instanceId][instanceDifficulty] = collect.journalInstance[instanceId][instanceDifficulty] or {}
				if locked then
					--
					for k, v in ipairs(E.Octo_Table.OctoTable_journalInstanceID) do
						if instanceId == v then
							local _, _, lastBossDefeated = GetSavedInstanceEncounterInfo(i, instancesLastBoss[i] or totalBosses)
							if defeatedBosses == 0 and lastBossDefeated then
								lastBossDefeated = false
							end
							local color = E.Octo_Globals.Red_Color
							if lastBossDefeated then color = E.Octo_Globals.Yellow_Color end
							if defeatedBosses == totalBosses then color = E.Octo_Globals.Green_Color end
							--
							if instanceReset and instanceReset > 0 then
								instanceReset = instanceReset + time()
							else
								instanceReset = 0
							end
							--
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
							--
							--
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
							-- collect.journalInstance[instanceId][instanceDifficulty].link = GetSavedInstanceChatLink(i)
						end
					end
				end
			end
			--
		end
		--
		-- collect.LFGInstance = {} -- УДАЛЕНИЕ
		-- collect.LFGInstance = collect.LFGInstance or {}
		--
		for i=1, GetNumRandomDungeons() do
			local dungeonID, name = GetLFGRandomDungeonInfo(i)
			if dungeonID then
				Octo_ToDo_SmartCollectNEW2.LFGInstance[dungeonID] = name
			end
		end
		-- for dungeonID, name in pairs(E.Octo_Table.OctoTable_LFGDungeons) do
		-- 	local D_name = GetLFGDungeonInfo(dungeonID)
		-- 	local donetoday = GetLFGDungeonRewards(dungeonID)
		-- 	collect.LFGInstance[dungeonID] = collect.LFGInstance[dungeonID] or {}
		-- 	collect.LFGInstance[dungeonID].D_name = D_name
		-- 	if donetoday == true then
		-- 		collect.LFGInstance[dungeonID].donetoday = E.Octo_Globals.DONE
		-- 	end
		-- end
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
function Collect_AberrusTransmog()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_AberrusTransmog".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	if Octo_ToDoTransmog == nil then
		Octo_ToDoTransmog = {}
	end
	--
	local englishClass = select(2, UnitClass("PLAYER"))
	local color = E.Octo_Globals.White_Color
	for itemType, v in pairs(E.Octo_Globals.Aberrus_the_Shadowed_Crucible_DATA[englishClass]) do
		for difficultyName, sourceID in pairs(v) do
			if sourceID then
				local isCollected = select(5, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
				if Octo_ToDoTransmog[englishClass] == nil then
					Octo_ToDoTransmog[englishClass] = {}
				end
				if Octo_ToDoTransmog[englishClass][itemType] == nil then
					Octo_ToDoTransmog[englishClass][itemType] = {}
				end
				setmetatable(Octo_ToDoTransmog[englishClass][itemType], Meta_Table_0)
				if isCollected == true then
					color = E.Octo_Globals.Green_Color
					Octo_ToDoTransmog[englishClass][itemType][difficultyName] = color.."done|r"
					-- collect.AberrusTransmog[itemType][difficultyName] = color.."done|r"
				else
					color = E.Octo_Globals.Red_Color
					Octo_ToDoTransmog[englishClass][itemType][difficultyName] = color.."done|r"
					-- collect.AberrusTransmog[itemType][difficultyName] = color.."nope|r"
				end
			end
		end
	end
end
function Collect_All_Quest_Tooltip()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_All_Quest_Tooltip".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoLevels[curGUID]
	local qwid = 77414
	--
	collect.DreamsurgeInvestigation = E.Octo_Func.All_objectives(qwid)
end
function Collect_Token_Price()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Collect_Token_Price()".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local collect = Octo_ToDoOther
	--
	-- TOKEN_FILTER_LABEL
	-- ITEM_QUALITY8_DESC
	--
	-- if not IsAddOnLoaded("Blizzard_WowTokenUI") then
	-- 	LoadAddOn("Blizzard_WowTokenUI")
	-- 	-- return
	-- end
	-- if not IsAddOnLoaded("Blizzard_AuctionHouseShared") then
	-- 	LoadAddOn("Blizzard_AuctionHouseShared")
	-- 	-- return
	-- end
	-- if not IsAddOnLoaded("Blizzard_AuctionHouseUI") then
	-- 	LoadAddOn("Blizzard_AuctionHouseUI")
	-- 	-- return
	-- end
	-- if not IsAddOnLoaded("Blizzard_TokenUI") then
	-- 	LoadAddOn("Blizzard_TokenUI")
	-- 	-- return
	-- end
	-- if not IsAddOnLoaded("Blizzard_StoreUI") then
	-- 	LoadAddOn("Blizzard_StoreUI")
	-- 	return
	-- end
	--
	local TokenPrice = C_WowTokenPublic.GetCurrentMarketPrice()
	--
	if TokenPrice then
		collect.TokenPrice = TokenPrice or 0
	end
end
function Timer_Legion_Invasion()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_Legion_Invasion".."|r")
	end
	local TIMER = (1547586000-10800)
	local interval = 66600
	local duration = 21600
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_Legion_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_Legion_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_Legion_Invasion
end
function Timer_BfA_Invasion()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_BfA_Invasion".."|r")
	end
	local TIMER = (1547586000+3600)
	local interval = 68400
	local duration = 25200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Invasion = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Invasion = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Invasion
end
function Timer_BfA_Assault()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_BfA_Assault".."|r")
	end
	local TIMER = (1547586000+3600+3600+3600+3600+3600+3600+3600)
	local interval = 86400
	local duration = 86400
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_BfA_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_BfA_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_BfA_Assault
end
function Timer_DF_ToDragonbaneKeep()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_ToDragonbaneKeep".."|r")
	end
	local TIMER = 1670342460
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ToDragonbaneKeep = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ToDragonbaneKeep
end
function Timer_DF_GrandHunts()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_GrandHunts".."|r")
	end
	local TIMER = 1671307200
	local interval = 7200
	local duration = 7199
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_GrandHunts = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_GrandHunts = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_GrandHunts
end
function Timer_DF_CommunityFeast()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_CommunityFeast".."|r")
	end
	local TIMER = 1677168000
	local interval = 5400
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_CommunityFeast = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_CommunityFeast = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_CommunityFeast
end
function Timer_DF_PrimalStorms()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_PrimalStorms".."|r")
	end
	local TIMER = 1683804640
	local interval = 18000
	local duration = 7200
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_PrimalStorms = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_PrimalStorms = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_PrimalStorms
end
function Timer_DF_ResearchersUnderFire()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_ResearchersUnderFire".."|r")
	end
	local TIMER = 1683804640
	local interval = 3600
	local duration = 1500
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_ResearchersUnderFire = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_ResearchersUnderFire = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_ResearchersUnderFire
end
function Timer_DF_TimeRift()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_TimeRift".."|r")
	end
	local TIMER = 1689159620 -- начало в 16:00
	local interval = 60*60 -- каждый час
	local duration = 10*60 -- 10 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_TimeRift = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_TimeRift = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_TimeRift
end
function Timer_DF_Dreamsurges()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_DF_Dreamsurges".."|r")
	end
	local TIMER = 1689159620 -- начало в 16:00
	local interval = 30*60 -- каждые пол часа
	local duration = 5*60 -- 5 минут
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_DF_Dreamsurges = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_DF_Dreamsurges = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_DF_Dreamsurges
end
function Timer_SL_Maw_Assault()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_SL_Maw_Assault".."|r")
	end
	local TIMER = 3780
	local interval = 7200
	local duration = 900
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	local Timer_SL_Maw_Assault = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	if nextEventIn > (interval - duration) then
		nextEventIn = nextEventIn - (interval - duration)
		Timer_SL_Maw_Assault = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
	end
	return Timer_SL_Maw_Assault
end
function Timer_Daily_Reset()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_Daily_Reset".."|r")
	end
	local TIMER = 1687579264
	local interval = 86400
	local duration = 1
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Daily_Reset = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Daily_Reset = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Daily_Reset..E.Octo_Globals.Gray_Color.."Daily Reset|r"
	else
		return " "
	end
end
function Timer_Treasure_Goblin()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_Treasure_Goblin".."|r")
	end
	local TIMER = 1685001600
	local interval = 1800
	local duration = 300
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_Treasure_Goblin = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_Treasure_Goblin = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_Treasure_Goblin
	else
		return " "
	end
end
function Timer_ElementalStorm()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Timer_ElementalStorm".."|r")
	end
	local TIMER = 1689166820
	local interval = (3*60)*60 -- 3 часа
	local duration = (2*60)*60 -- 2 часа
	local nextEventIn = interval - mod(tonumber(GetServerTime()) - TIMER, interval)
	if (nextEventIn/60/60) < 24 then
		local Timer_ElementalStorm = E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		if nextEventIn > (interval - duration) then
			nextEventIn = nextEventIn - (interval - duration)
			Timer_ElementalStorm = E.Octo_Globals.Green_Color..E.Octo_Func.SecondsToClock(nextEventIn).."|r "
		end
		return Timer_ElementalStorm
	else
		return " "
	end
end
function Octo_ToDo_FIRST_OnLoad()
	if not Octo_ToDo_FIRST_Frame_EventFrame then
		Octo_ToDo_FIRST_Frame_EventFrame = CreateFrame("FRAME", AddonTitle..E.Octo_Func.GenerateUniqueID())
	end
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CALENDAR_CLOSE_EVENT")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CALENDAR_NEW_EVENT")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CALENDAR_OPEN_EVENT")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CALENDAR_UPDATE_EVENT")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_LOOT")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_SKILL")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("COVENANT_CHOSEN")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ENCOUNTER_END")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("HEARTHSTONE_BOUND")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ITEM_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ITEM_COUNT_CHANGED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ITEM_LOCKED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("ITEM_PUSH")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("LFG_COMPLETION_REWARD")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_INBOX_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_SEND_SUCCESS")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("MAIL_SHOW")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("NEW_TOY_ADDED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LOGIN")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LOGOUT")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_MONEY")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_ACCEPTED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_COMPLETE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_FINISHED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_REMOVED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("QUEST_TURNED_IN")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("READY_CHECK")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("SPELLS_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TOKEN_MARKET_PRICE_UPDATED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TOYS_UPDATED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TRAINER_UPDATE")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("UI_INFO_MESSAGE")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("UPDATE_PENDING_MAIL")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("VARIABLES_LOADED")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_XP_UPDATE")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("RECEIVED_ACHIEVEMENT_LIST")
	-- Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("CRITERIA_UPDATE")
	-- local group = Octo_ToDo_FIRST_Frame_EventFrame:CreateAnimationGroup()
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
	Octo_ToDo_FIRST_Frame_EventFrame:RegisterEvent("PLAYER_STOPPED_MOVING")
	Octo_ToDo_FIRST_Frame_EventFrame:SetScript("OnEvent", function(...)
			Octo_ToDo_FIRST_OnEvent(...)
	end)
	if not inspectScantip then
		inspectScantip = CreateFrame("GameTooltip", "OctoToDoScanningTooltip", nil, "GameTooltipTemplate")
		inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
	end
end
function O_otrisovka_FIRST()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."O_otrisovka_FIRST".."|r")
	end
	-- ИМЯ
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
				vivodCent = MailBox_Icon..vivodCent
			end
			if CharInfo.UnitLevel ~= 0 and CharInfo.UnitLevel ~= 70 then
				CL:SetFontObject(OctoFont10)
				vivodCent = CharInfo.UnitLevel.." "..vivodCent
			end
			if Octo_ToDoVars.config.ShowOnlyCurrentRealm == false then
				CL:SetFontObject(OctoFont9)
				vivodCent = vivodCent.."|n"..CharInfo.curServer
			end
			--
			local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
			if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal  then
				tooltip[#tooltip+1] = {CharInfo.classColorHex..CharInfo.Name.."("..CharInfo.curServer..")".."|r", E.Octo_Func.func_texturefromIcon(CharInfo.specIcon)..CharInfo.classColorHex..CharInfo.specName.."|r"}
				if CharInfo.UnitLevel ~= 70 and CharInfo.UnitXPPercent then
					tooltip[#tooltip+1] = {LEVEL..": "..CharInfo.UnitLevel.." "..CharInfo.UnitXPPercent.."%", CharInfo.classColorHex..CharInfo.RaceLocal.."|r"}
				else
					tooltip[#tooltip+1] = {" ", CharInfo.classColorHex..CharInfo.RaceLocal.."|r"}
				end
					tooltip[#tooltip+1] = {" "," "}
			end
			if CharInfo.BindLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
			end
			if CharInfo.CurrentLocation ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(132319)..L["Current Location"], CharInfo.CurrentLocation}
			end
			-- if CharInfo.maxNumQuestsCanAccept ~= 0 then
			-- 	tooltip[#tooltip+1] = {QUESTS_LABEL, CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept}
			-- end
			if CharInfo.totalSlots ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(133634)..L["Bags"], CharInfo.usedSlots.."/"..CharInfo.totalSlots}
			end
			if CharInfo.PlayerReagentnumSlots == 0 then
				tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(4549254)..E.Octo_Globals.Red_Color..L["No Reagent Bag"].."|r", " "}
			end
			if CharInfo.ItemsInBag[188152] == 0 then
				tooltip[#tooltip+1] = {" "," "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(188152)..E.Octo_Func.func_itemName(188152), CharInfo.ItemsInBag[188152]}
			end
			--
			vivodLeft = Timer_Daily_Reset()
			return vivodCent, vivodLeft
	end)
	-- ЭПОХАЛЬНЫЙ КЛЮЧ
	tinsert(OctoTable_func_otrisovka_FIRST,
		function(CharInfo, tooltip, CL, BG)
			local vivodCent, vivodLeft = "", ""
			vivodLeft = E.Octo_Func.func_texturefromIcon(4352494)..E.Octo_Globals.Purple_Color..L["Mythic Keystone"].."|r"
			if CharInfo.CurrentKeyFULL ~= 0 then
				tooltip[#tooltip+1] = {E.Octo_Globals.Purple_Color..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyFULL.."|r", ""}
			end
			if CharInfo.RIO_Score ~= 0 then
				tooltip[#tooltip+1] = {DUNGEON_SCORE, E.Octo_Globals.Orange_Color..CharInfo.RIO_Score.."|r"}
			end
			if CharInfo.RIO_weeklyBest ~= 0 then
				tooltip[#tooltip+1] = {"Weekly Best", E.Octo_Globals.Orange_Color..CharInfo.RIO_weeklyBest.."|r"}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
			end
			for i = 1, 3 do
				CharInfo.GreatVault[i] = CharInfo.GreatVault[i] or {}
				CharInfo.GreatVault[i].hyperlink_STRING = CharInfo.GreatVault[i].hyperlink_STRING or 0
				CharInfo.GreatVault[i].progress = CharInfo.GreatVault[i].progress or 0
				CharInfo.GreatVault[i].threshold = CharInfo.GreatVault[i].threshold or 0
				if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.Octo_Globals.Purple_Color..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
				elseif CharInfo.GreatVault[i].progress ~= 0 then
					tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
				end
			end
			if CharInfo.CurrentKey ~= 0 then
				vivodCent = CharInfo.CurrentKey
			end
			if CharInfo.HasAvailableRewards then
				vivodCent = vivodCent..E.Octo_Globals.Blue_Color..">Vault<|r"
			end
			if CharInfo.ItemsInBag[205225] ~= 0 or CharInfo.ItemsInBag[205999] ~= 0 or CharInfo.ItemsInBag[206046] ~= 0 or CharInfo.ItemsInBag[204843] ~= 0 then
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
			end
			if CharInfo.ItemsInBag[206046] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Purple_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(206046)..E.Octo_Globals.Purple_Color..E.Octo_Func.func_itemName_NOCOLOR(206046).."|r", CharInfo.ItemsInBag[206046]}
			end
			if CharInfo.ItemsInBag[204843] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Pink_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204843)..E.Octo_Globals.Pink_Color..E.Octo_Func.func_itemName_NOCOLOR(204843).."|r", CharInfo.ItemsInBag[204843]}
			end
			if CharInfo.ItemsInBag[205999] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.Orange_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(205999)..E.Octo_Globals.Orange_Color..E.Octo_Func.func_itemName_NOCOLOR(205999).."|r", CharInfo.ItemsInBag[205999]}
			end
			if CharInfo.ItemsInBag[205225] ~= 0 then
				vivodCent = vivodCent..E.Octo_Globals.LightGray_Color.."+|r"
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(205225)..E.Octo_Globals.LightGray_Color..E.Octo_Func.func_itemName_NOCOLOR(205225).."|r", CharInfo.ItemsInBag[205225]}
			end
			return vivodCent, vivodLeft
	end)
	-- tinsert(OctoTable_func_otrisovka_FIRST,
	-- function(CharInfo, tooltip, CL, BG)
	-- local vivodCent, vivodLeft = "", ""
	-- if CharInfo.RIO_Score ~= 0 then
	-- vivodCent = E.Octo_Globals.WOW_Artifact_Color..CharInfo.RIO_Score.."|r"
	-- end
	-- vivodLeft = DUNGEON_SCORE
	-- return vivodCent, vivodLeft
	-- end)
	-- tinsert(OctoTable_func_otrisovka_FIRST,
	-- function(CharInfo, tooltip, CL, BG)
	-- local vivodCent, vivodLeft = "", ""
	-- local test = 0
	-- for i = 1, 3 do
	-- if CharInfo.GreatVault[i].hyperlink_STRING ~= 0 then
	-- tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold.." "..E.Octo_Globals.Purple_Color..CharInfo.GreatVault[i].hyperlink_STRING.."|r"}
	-- elseif CharInfo.GreatVault[i].progress ~= 0 then
	-- tooltip[#tooltip+1] = {CharInfo.GreatVault[i].type, CharInfo.GreatVault[i].progress.."/"..CharInfo.GreatVault[i].threshold}
	-- end
	-- end
	-- for i = 1, 3 do
	-- if CharInfo.GreatVault[i].hyperlink[1] ~= 0 then
	-- test = test + 1
	-- end
	-- if CharInfo.GreatVault[i].hyperlink[2] ~= 0 then
	-- test = test + 1
	-- end
	-- if CharInfo.GreatVault[i].hyperlink[3] ~= 0 then
	-- test = test + 1
	-- end
	-- end
	-- if test ~= 0 then
	-- vivodCent = E.Octo_Globals.Orange_Color..test.."/9|r"
	-- end
	-- vivodLeft = GREAT_VAULT_REWARDS
	-- return vivodCent, vivodLeft
	-- end)
	if Octo_ToDoVars.config.ExpansionToShow == 1 then
		for k, v in ipairs(E.Octo_Table.OctoTable_reputation_Classic) do
			if Octo_ToDoVars.config.reputation[v.repID] == true then
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.reputationID[v.repID] then
							vivodCent = CharInfo.reputationID[v.repID]
						end
						vivodLeft = E.Octo_Func.func_reputationName(v.repID)
						return vivodCent, vivodLeft
				end)
			end
		end
	end
	if Octo_ToDoVars.config.ExpansionToShow == 2 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(23572)..E.Octo_Func.func_itemName(23572)
				if CharInfo.ItemsInBag[23572] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[23572]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(30183)..E.Octo_Func.func_itemName(30183)
				if CharInfo.ItemsInBag[30183] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[30183]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(32428)..E.Octo_Func.func_itemName(32428)
				if CharInfo.ItemsInBag[32428] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[32428]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(34664)..E.Octo_Func.func_itemName(34664)
				if CharInfo.ItemsInBag[34664] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[34664]
				end
				return vivodCent, vivodLeft
		end)
		for k, v in ipairs(E.Octo_Table.OctoTable_reputation_BC) do
			if Octo_ToDoVars.config.reputation[v.repID] == true then
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.reputationID[v.repID] then
							vivodCent = CharInfo.reputationID[v.repID]
						end
						vivodLeft = E.Octo_Func.func_reputationName(v.repID)
						return vivodCent, vivodLeft
				end)
			end
		end
	end
	if Octo_ToDoVars.config.ExpansionToShow == 3 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(43102)..E.Octo_Func.func_itemName(43102)
				if CharInfo.ItemsInBag[43102] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[43102]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(45087)..E.Octo_Func.func_itemName(45087)
				if CharInfo.ItemsInBag[45087] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[45087]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(47556)..E.Octo_Func.func_itemName(47556)
				if CharInfo.ItemsInBag[47556] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[47556]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(49908)..E.Octo_Func.func_itemName(49908)
				if CharInfo.ItemsInBag[49908] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[49908]
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 4 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(52078)..E.Octo_Func.func_itemName(52078)
				if CharInfo.ItemsInBag[52078] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[52078]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(69237)..E.Octo_Func.func_itemName(69237)
				if CharInfo.ItemsInBag[69237] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[69237]
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_itemTexture(71998)..E.Octo_Func.func_itemName(71998)
				if CharInfo.ItemsInBag[71998] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[71998]
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 5 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[697] then
					vivodCent = CharInfo.CurrencyID_Total[697]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(697)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(697)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[776] then
					vivodCent = CharInfo.CurrencyID_Total[776]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(776)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(776)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 6 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1129] then
					vivodCent = CharInfo.CurrencyID_Total[1129].."(+"..CharInfo.Octopussy_WoD_Weekly_coinsQuests_count..")"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1129)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1129)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1129] then
					vivodCent = CharInfo.CurrencyID_Total[994]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(994)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(994)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[823] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[823]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(823)..E.Octo_Func.func_currencyName(823)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1101] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1101]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1101)..E.Octo_Func.func_currencyName(1101)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[824] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[824]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(824)..E.Octo_Func.func_currencyName(824)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Draenor_Once_Garrison1_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison1_count
				end
				vivodLeft = L["Garrison 1 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Draenor_Once_Garrison2_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison2_count
				end
				vivodLeft = L["Garrison 2 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetFontObject(OctoFont1)
				if CharInfo.UnitLevel > 40 then
					if CharInfo.CurrencyID[824] < 2000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..CharInfo.CurrencyID[824]..E.Octo_Func.func_currencyicon(824)
					else
						vivodCent = vivodCent..CharInfo.CurrencyID[824]..E.Octo_Func.func_currencyicon(824).."|r"
					end
					if CharInfo.Money/10000 < 5000 then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000)
					else
						vivodCent = vivodCent..GetCoinTextureString(CharInfo.Money-CharInfo.Money%10000).."|r"
					end
					if CharInfo.Octopussy_Draenor_Once_Garrison3_count ~= E.Octo_Globals.NONE then
						CL:SetFontObject(OctoFont10)
						vivodCent = CharInfo.Octopussy_Draenor_Once_Garrison3_count
					end
				else
					vivodCent = E.Octo_Func.func_texturefromIcon(894556)..E.Octo_Globals.Red_Color..CharInfo.UnitLevel.."/40|r"
				end
				vivodLeft = L["Garrison 3 Level"]
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[38242] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[38242]
				end
				if CharInfo.ItemsInBag[122457] ~= 0 then
					vivodCent = vivodCent.."+"..CharInfo.ItemsInBag[122457]..E.Octo_Func.func_itemTexture(122457)
				end
				vivodLeft = E.Octo_Func.func_questName(38242).." (ап пета)"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.OctoTable_QuestID[39246] ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.OctoTable_QuestID[39246]
				end
				vivodLeft = E.Octo_Func.func_questName(39246)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 7 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Daily_InvasionQuests_count
					vivodLeft = Timer_Legion_Invasion()..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Daily_InvasionQuests_questID)}
				else
					vivodLeft = (Timer_Legion_Invasion().."Timer_Legion_Invasion")
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Weekly_WBALL_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Weekly_WBALL_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Weekly_WBALL_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB"
				end
				if CharInfo.Octopussy_Legion_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Weekly_WBALL_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_questID)
				else
					vivodLeft = ("Broken Shore - Armies of Legionfall")
				end
				if CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreArmiesofLegionfall_count
				end
				if CharInfo.OctoTable_QuestID[46246] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_questID)
				else
					vivodLeft = ("Broken Shore - Excavations")
				end
				if CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BrokenShoreExcavations_count
				end
				if CharInfo.OctoTable_QuestID[46666] == E.Octo_Globals.DONE then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID)}
					vivodLeft = E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_ArgusToArgus_questID)
				else
					vivodLeft = ("Broken Shore - ToArgus")
				end
				if CharInfo.Octopussy_Legion_Once_ArgusToArgus_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_ArgusToArgus_count
				end
				-- if CharInfo.OctoTable_QuestID[46666] == E.Octo_Globals.DONE then
				-- vivodCent = E.Octo_Globals.DONE
				-- end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_questID ~= E.Octo_Globals.NONE then
					vivodLeft = E.Octo_Func.func_questName(43533)..": "..E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BalanceofPower_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_Legion_Once_BalanceofPower_questID)}
				else
					vivodLeft = E.Octo_Func.func_questName(43533)
				end
				if CharInfo.Octopussy_Legion_Once_BalanceofPower_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_Legion_Once_BalanceofPower_count
				end
				if CharInfo.OctoTable_QuestID[43533] == "|cff4FFF79Done|r" then
					vivodCent = E.Octo_Globals.DONE
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1273] then
					vivodCent = CharInfo.CurrencyID_Total[1273].."(+"..CharInfo.Octopussy_Legion_Weekly_coinsQuests_count..")"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1273)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1273)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[1508] ~= 0 then
					vivodCent = CharInfo.CurrencyID_Total[1508]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1508)..E.Octo_Func.func_currencyName(1508)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1342] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1342]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1342)..E.Octo_Func.func_currencyName(1342)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1220] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1220]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1220)..E.Octo_Func.func_currencyName(1220)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1226] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1226]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1226)..E.Octo_Func.func_currencyName(1226)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1533] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1533]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1533)..E.Octo_Func.func_currencyName(1533)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1155] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1155]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1155)..E.Octo_Func.func_currencyName(1155)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[124124] ~= 0 then
					vivodCent = CharInfo.ItemsInBag[124124]
				end
				vivodLeft = E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemTexture(124124)..E.Octo_Func.func_itemName_NOCOLOR(124124).."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion1 ~= 0 and CharInfo.bounty_Legion1_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion1_icon..CharInfo.bounty_Legion1
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion1_end) or ""}
				end
				vivodLeft = "bounty_Legion1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion2 ~= 0 and CharInfo.bounty_Legion2_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion2_icon..CharInfo.bounty_Legion2
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion2_end) or ""}
				end
				vivodLeft = "bounty_Legion2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_Legion3 ~= 0 and CharInfo.bounty_Legion3_questID ~= 0 then
					vivodCent = CharInfo.bounty_Legion3_icon..CharInfo.bounty_Legion3
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_Legion3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_Legion3_end) or ""}
				end
				vivodLeft = "bounty_Legion3"
				return vivodCent, vivodLeft
		end)
		-- 1
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 1 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 2
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 2 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 3
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 3 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
		-- 4
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				local QWE = Octo_ToDoArtifact
				if CharInfo.classFilename == "WARRIOR" then
					tooltip[#tooltip+1] = {L["InDev"], " "}
					tooltip[#tooltip+1] = {" ", " "}
					for k, v in pairs(QWE.WARRIOR) do
						for q, w in pairs (v) do
							if QWE.WARRIOR[k][q].specIDnumber == 4 then
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARRIOR[k][q].specIcon) -- ..QWE.WARRIOR[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PALADIN[k][q].specIcon) -- ..QWE.PALADIN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.HUNTER[k][q].specIcon) -- ..QWE.HUNTER[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.ROGUE[k][q].specIcon) -- ..QWE.ROGUE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.PRIEST[k][q].specIcon) -- ..QWE.PRIEST[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEATHKNIGHT[k][q].specIcon) -- ..QWE.DEATHKNIGHT[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.SHAMAN[k][q].specIcon) -- ..QWE.SHAMAN[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MAGE[k][q].specIcon) -- ..QWE.MAGE[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.WARLOCK[k][q].specIcon) -- ..QWE.WARLOCK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.MONK[k][q].specIcon) -- ..QWE.MONK[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DRUID[k][q].specIcon) -- ..QWE.DRUID[k][q].specNameLocale
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
								vivodCent = E.Octo_Func.func_texturefromIcon(QWE.DEMONHUNTER[k][q].specIcon) -- ..QWE.DEMONHUNTER[k][q].specNameLocale
								tooltip[#tooltip+1] = {QWE.DEMONHUNTER[k][q].unlockOCto.."("..QWE.DEMONHUNTER[k][q].name..")", QWE.DEMONHUNTER[k][q].vivod}
							end
						end
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 8 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = (Timer_BfA_Invasion().."Timer_BfA_Invasion (PVP)")
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Daily_InvasionQuests_count
				end
				if CharInfo.Octopussy_BfA_Daily_InvasionQuests_questID ~= E.Octo_Globals.NONE then
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_InvasionQuests_questID)}
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID ~= E.Octo_Globals.NONE then
					vivodLeft = Timer_BfA_Assault()..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_questID)}
				else
					vivodLeft = (Timer_BfA_Assault().."Timer_BfA_Assault (N'zoth)")
				end
				if CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_BfA_Weekly_AssaultTheBlackEmpire_count
				end
				if CharInfo.ItemsInBag[174765] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174765]..E.Octo_Func.func_itemTexture(174765)
				end
				if CharInfo.ItemsInBag[174761] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174761]..E.Octo_Func.func_itemTexture(174761)
				end
				if CharInfo.ItemsInBag[174767] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174767]..E.Octo_Func.func_itemTexture(174767)
				end
				if CharInfo.ItemsInBag[174766] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174766]..E.Octo_Func.func_itemTexture(174766)
				end
				if CharInfo.ItemsInBag[174768] ~= 0 then
					vivodCent = vivodCent..CharInfo.ItemsInBag[174768]..E.Octo_Func.func_itemTexture(174768)
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174764)..CharInfo.ItemsInBag[174764].."/6", "Ульдум "..CharInfo.ItemsInBag[174765]..E.Octo_Func.func_itemTexture(174765)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174756)..CharInfo.ItemsInBag[174756].."/6", "Ульдум "..CharInfo.ItemsInBag[174761]..E.Octo_Func.func_itemTexture(174761)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174759)..CharInfo.ItemsInBag[174759].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174767]..E.Octo_Func.func_itemTexture(174767)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174760)..CharInfo.ItemsInBag[174760].."/6", "Вечноцветущий дол "..CharInfo.ItemsInBag[174766]..E.Octo_Func.func_itemTexture(174766)}
				tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(174758)..CharInfo.ItemsInBag[174758].."/6", "Вечноцветущий дол, Ульдум "..CharInfo.ItemsInBag[174768]..E.Octo_Func.func_itemTexture(174768)}
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Daily_miniVision_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Daily_miniVision_count)
				end
				vivodLeft = E.Octo_Globals.Purple_Color.."Mini Vision".."|r"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBALL_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBALL_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBALL_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBALL_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB: Nazjatar"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBNazjatar_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBAssault_count)
				end
				vivodLeft = WorldBoss_Icon.."World Boss: Assault"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID ~= E.Octo_Globals.NONE then
					vivodLeft = WorldBoss_Icon.."WB: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_questID)}
				else
					vivodLeft = WorldBoss_Icon.."WB: PVP"
				end
				if CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WBDarkshore_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID ~= E.Octo_Globals.NONE then
					vivodLeft = Rares_Icon.."Rares: "..E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID)
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_questID)}
				else
					vivodLeft = Rares_Icon.."Rares: Darkshore"
				end
				if CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Daily_DarkshoreRares_count)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1560] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1560]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1560)..E.Octo_Func.func_currencyName(1560)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1721] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1721]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1721)..E.Octo_Func.func_currencyName(1721)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1803] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1803]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1803)..E.Octo_Func.func_currencyName(1803)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1755] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1755]
				end
				if CharInfo.ItemsInBag[173363] ~= 0 then
					vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[173363]..E.Octo_Func.func_itemTexture(173363)
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1755)..E.Octo_Func.func_currencyName(1755)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1719] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1719]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1719)..E.Octo_Func.func_currencyName(1719)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1710] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1710]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1710)..E.Octo_Func.func_currencyName(1710)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1716] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1716]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1716)..E.Octo_Func.func_currencyName(1716)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID_Total[1718] ~= "|cff4040400|r" then
					vivodCent = CharInfo.CurrencyID_Total[1718]
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1718)..E.Octo_Func.func_currencyName(1718)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[158075] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no neck|r"
				end
				if CharInfo.ItemsInBag[158075] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = E.Octo_Func.Empty_Zero(E.Octo_Globals.Green_Color..CharInfo.azeriteLVL.."|r").."|n"..E.Octo_Globals.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				vivodLeft = E.Octo_Func.func_itemTexture(158075)..E.Octo_Func.func_itemName(158075)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[169223] == 0 then
					vivodCent = E.Octo_Globals.Red_Color.."no cloak|r"
				end
				if CharInfo.ItemsInBag[169223] ~= 0 then
					vivodCent = E.Octo_Globals.Orange_Color.."neeed to equip|r"
					if CharInfo.cloak_lvl ~= 0 then
						vivodCent = CharInfo.cloak_lvl.." lvl"
						if CharInfo.cloak_lvl == 15 then
							vivodCent = E.Octo_Globals.Green_Color..vivodCent.."|r"
						end
					end
					if CharInfo.cloak_res ~= 0 then
						CL:SetFontObject(OctoFont10)
						vivodCent = vivodCent.."|n"..CharInfo.cloak_res
					end
				end
				vivodLeft = E.Octo_Func.func_itemTexture(169223)..E.Octo_Func.func_itemName(169223)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.islandBfA then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.islandBfA)
				end
				vivodLeft = "Collect_BfA_Island"
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					vivodLeft = E.Octo_Func.func_questName(questID)
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront1_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront1_count)
				end
				vivodLeft = "Warfront: Stromgarde"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_Warfront2_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_Warfront2_count)
				end
				vivodLeft = "Warfront: Darkshore"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count ~= E.Octo_Globals.NONE then
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Octopussy_BfA_Weekly_WarfrontHC_count)
				end
				vivodLeft = "Warfront: Heroic"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA1 ~= 0 and CharInfo.bounty_BfA1_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA1_icon..CharInfo.bounty_BfA1
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA1_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA1_end) or ""}
				end
				vivodLeft = "bounty_BfA1"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA2 ~= 0 and CharInfo.bounty_BfA2_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA2_icon..CharInfo.bounty_BfA2
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA2_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA2_end) or ""}
				end
				vivodLeft = "bounty_BfA2"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.bounty_BfA3 ~= 0 and CharInfo.bounty_BfA3_questID ~= 0 then
					vivodCent = CharInfo.bounty_BfA3_icon..CharInfo.bounty_BfA3
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.bounty_BfA3_questID)}
					tooltip[#tooltip+1] = {L["Expire on"], date("%d/%m/%Y %H:%M:%S", CharInfo.bounty_BfA3_end) or ""}
				end
				vivodLeft = "bounty_BfA3"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[166846] ~= 0 or CharInfo.ItemsInBag[169610] ~= 0 or CharInfo.ItemsInBag[166970] ~= 0 or CharInfo.ItemsInBag[168327] ~= 0 or CharInfo.ItemsInBag[168832] ~= 0 or CharInfo.ItemsInBag[166971] ~= 0 or CharInfo.ItemsInBag[168946] ~= 0 or CharInfo.ItemsInBag[168215] ~= 0 or CharInfo.ItemsInBag[168216] ~= 0 or CharInfo.ItemsInBag[168217] ~= 0 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(166846)..E.Octo_Func.func_itemName(166846), CharInfo.ItemsInBag[166846]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(169610)..E.Octo_Func.func_itemName(169610), CharInfo.ItemsInBag[169610]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(166970)..E.Octo_Func.func_itemName(166970), CharInfo.ItemsInBag[166970]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168327)..E.Octo_Func.func_itemName(168327), CharInfo.ItemsInBag[168327]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168832)..E.Octo_Func.func_itemName(168832), CharInfo.ItemsInBag[168832]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(166971)..E.Octo_Func.func_itemName(166971), CharInfo.ItemsInBag[166971]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168946)..E.Octo_Func.func_itemName(168946), CharInfo.ItemsInBag[168946]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168215)..E.Octo_Func.func_itemName(168215), CharInfo.ItemsInBag[168215]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168216)..E.Octo_Func.func_itemName(168216), CharInfo.ItemsInBag[168216]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(168217)..E.Octo_Func.func_itemName(168217), CharInfo.ItemsInBag[168217]}
					vivodCent = "МЕХАГОН"
				end
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 9 then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = "Maw: Covenant Assault "..Timer_SL_Maw_Assault()
				if CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[1] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[1])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[7] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[7])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[5] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[5])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[3] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[3])
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color)
				if CharInfo.curCovID == 1 then
					BG:SetColorTexture(E.Octo_Globals.Kyrian_r_Color, E.Octo_Globals.Kyrian_g_Color, E.Octo_Globals.Kyrian_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[2] then
					vivodLeft = Kyrian_Icon..E.Octo_Globals.Kyrian_Color..L["Kyrian"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[2])
				end
				if CharInfo.Shadowland[2] and CharInfo.Shadowland[2] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 1 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color)
				if CharInfo.curCovID == 4 then
					BG:SetColorTexture(E.Octo_Globals.Necrolord_r_Color, E.Octo_Globals.Necrolord_g_Color, E.Octo_Globals.Necrolord_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[8] then
					vivodLeft = Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[8])
				end
				if CharInfo.Shadowland[8] and CharInfo.Shadowland[8] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 4 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color)
				if CharInfo.curCovID == 3 then
					BG:SetColorTexture(E.Octo_Globals.NightFae_r_Color, E.Octo_Globals.NightFae_g_Color, E.Octo_Globals.NightFae_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[6] then
					vivodLeft = NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[6])
				end
				if CharInfo.Shadowland[6] and CharInfo.Shadowland[6] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 3 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				CL:SetTextColor(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color)
				if CharInfo.curCovID == 2 then
					BG:SetColorTexture(E.Octo_Globals.Venthyr_r_Color, E.Octo_Globals.Venthyr_g_Color, E.Octo_Globals.Venthyr_b_Color, E.Octo_Globals.BGALPHA)
				else
					BG:SetColorTexture(0, 0, 0, 0)
				end
				if CharInfo.Shadowland[4] then
					vivodLeft = Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r"
					vivodCent = E.Octo_Func.Empty_Zero(CharInfo.Shadowland[4])
				end
				if CharInfo.Shadowland[4] and CharInfo.Shadowland[4] < 1000 then
					vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
				end
				if CharInfo.curCovID == 2 and CharInfo.Possible_Anima ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[2009])
				vivodLeft = E.Octo_Func.func_currencyicon(2009)..E.Octo_Func.func_currencyName(2009)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1906])
				vivodLeft = E.Octo_Func.func_currencyicon(1906)..E.Octo_Func.func_currencyName(1906)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1828])
				vivodLeft = E.Octo_Func.func_currencyicon(1828)..E.Octo_Func.func_currencyName(1828)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1979])
				vivodLeft = E.Octo_Func.func_currencyicon(1979)..E.Octo_Func.func_currencyName(1979)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Func.Empty_Zero(CharInfo.CurrencyID[1931])
				vivodLeft = E.Octo_Func.func_currencyicon(1931)..E.Octo_Func.func_currencyName(1931)
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					vivodCent = vivodCent..E.Octo_Globals.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ZMPatternsWithinPatterns_count
				end
				vivodLeft = E.Octo_Func.func_texturefromIcon(4074774)..E.Octo_Func.func_questName(66042)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_KorthiaShapingFate_count
				end
				vivodLeft = E.Octo_Func.func_texturefromIcon(4066373)..E.Octo_Func.func_questName(63949)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBALL_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBALL_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss"
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBZMAntros_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBZMAntros_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..E.Octo_Func.func_questName(65143)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count
				end
				vivodLeft = WorldBoss_Icon.."World Boss: "..E.Octo_Func.func_questName(64531)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count ~= E.Octo_Globals.NONE then
					vivodCent = CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count
				end
				vivodLeft = E.Octo_Func.func_currencyicon(1813)..E.Octo_Func.func_questName(61981)
				return vivodCent, vivodLeft
		end)
	end
	if Octo_ToDoVars.config.ExpansionToShow == 10 then
		-- Помощь союзу
		if Octo_ToDoVars.config.AidingtheAccord == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = E.Octo_Func.func_texturefromIcon(1603189)..L["Aiding the Accord"]
					if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count
						if CharInfo.Octopussy_DF_Weekly_AidingtheAccord_questID ~= E.Octo_Globals.NONE then
							tooltip[#tooltip+1] = {E.Octo_Func.func_questName(CharInfo.Octopussy_DF_Weekly_AidingtheAccord_questID), CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
						end
					end
					-- BG:SetColorTexture(.31, 1, .47, .1)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.CommunityFeast == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(629056)..Timer_DF_CommunityFeast()..L["Community Feast"])
					if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_CommunityFeast_count
					end
					if CharInfo.ItemsInBag[200652] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200652]..E.Octo_Func.func_itemTexture(200652)
					end
					if CharInfo.ItemsInBag[200095] ~= 0 then
						vivodCent = vivodCent.." +"..CharInfo.ItemsInBag[200095]..E.Octo_Func.func_itemTexture(200095)
					end
					if CharInfo.UnitLevel >= 58 and (CharInfo.KnownSpell[366253] == false or CharInfo.KnownSpell[366253] == 0) then
						vivodCent = vivodCent..E.Octo_Globals.Red_Color.."-|r"
					end
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.ResearchersUnderFire == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(236469)..Timer_DF_ResearchersUnderFire()..L["Researchers Under Fire"])
					if CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count ~= "0/4" then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_EPIC, CharInfo.OctoTable_QuestID[75630]} -- MAW_BUFF_QUALITY_STRING_EPIC Epic
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_RARE, CharInfo.OctoTable_QuestID[75629]} -- MAW_BUFF_QUALITY_STRING_RARE Rare
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_UNCOMMON, CharInfo.OctoTable_QuestID[75628]} -- MAW_BUFF_QUALITY_STRING_UNCOMMON Uncommon
						tooltip[#tooltip+1] = {MAW_BUFF_QUALITY_STRING_COMMON, CharInfo.OctoTable_QuestID[75627]} -- MAW_BUFF_QUALITY_STRING_COMMON Common
					end
					return vivodCent, vivodLeft
			end)
		end
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.ItemsInBag[204193] ~= 0 or CharInfo.ItemsInBag[204075] ~= 0 or CharInfo.CurrencyID[2409] ~= 0 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204075)..E.Octo_Globals.Green_Color..E.Octo_Func.func_itemName_NOCOLOR(204075).."|r"..E.Octo_Globals.Gray_Color.." LFR, M+1-5".."|r", CharInfo.ItemsInBag[204075]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2409].."/"..CharInfo.CurrencyID_maxQuantity[2409]..")|r"}
				end
				if CharInfo.ItemsInBag[204076] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204076)..E.Octo_Globals.Blue_Color..E.Octo_Func.func_itemName_NOCOLOR(204076).."|r"..E.Octo_Globals.Gray_Color.." Normal, M+6-10".."|r", CharInfo.ItemsInBag[204076]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2410].."/"..CharInfo.CurrencyID_maxQuantity[2410]..")|r"}
				end
				if CharInfo.ItemsInBag[204077] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204077)..E.Octo_Globals.Purple_Color..E.Octo_Func.func_itemName_NOCOLOR(204077).."|r"..E.Octo_Globals.Gray_Color.." Heroic, M+11-15".."|r", CharInfo.ItemsInBag[204077]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2411].."/"..CharInfo.CurrencyID_maxQuantity[2411]..")|r"}
				end
				if CharInfo.ItemsInBag[204078] >= 1 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204078)..E.Octo_Globals.Orange_Color..E.Octo_Func.func_itemName_NOCOLOR(204078).."|r"..E.Octo_Globals.Gray_Color.." Mythic, M+16+".."|r", CharInfo.ItemsInBag[204078]..E.Octo_Globals.Gray_Color.." ("..CharInfo.CurrencyID[2412].."/"..CharInfo.CurrencyID_maxQuantity[2412]..")|r"}
				end
				if CharInfo.ItemsInBag[204193] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Green_Color..CharInfo.ItemsInBag[204193].." |r"
				end
				if CharInfo.ItemsInBag[204195] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Blue_Color..CharInfo.ItemsInBag[204195].." |r"
				end
				if CharInfo.ItemsInBag[204196] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Purple_Color..CharInfo.ItemsInBag[204196].." |r"
				end
				if CharInfo.ItemsInBag[204194] >= 1 then
					vivodCent = vivodCent..E.Octo_Globals.Orange_Color..CharInfo.ItemsInBag[204194].." |r"
				end
				if CharInfo.CurrencyID[2409] ~= 0 and (CharInfo.CurrencyID[2409] == CharInfo.CurrencyID_maxQuantity[2409]) then
					vivodCent = vivodCent..E.Octo_Globals.Green_Color.."+|r"
				end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.CurrencyID[2245] ~= 0 then
					vivodCent = CharInfo.CurrencyID[2245].."/"..CharInfo.CurrencyID_maxQuantity[2245]
				end
				if CharInfo.CurrencyID[2245] == CharInfo.CurrencyID_maxQuantity[2245] then
					vivodCent = E.Octo_Globals.Green_Color..vivodCent.."|r"
				end
				vivodLeft = E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245)
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_currencyicon(2533)..E.Octo_Func.func_currencyName(2533)
				if CharInfo.CurrencyID[2533] ~= 0 then
					vivodCent = E.Octo_Globals.WOW_Legendary_Color..CharInfo.CurrencyID[2533].."|r"
				end
				-- if CharInfo.CurrencyID[2533] < (CharInfo.CurrencyID_maxQuantity[2533] or 8) and CharInfo.needResetWeekly == true then
				-- vivodCent = E.Octo_Globals.Red_Color..CharInfo.CurrencyID[2533].."|r"
				-- end
				return vivodCent, vivodLeft
		end)
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodLeft = E.Octo_Func.func_texturefromIcon(2065578)..E.Octo_Func.func_currencyName(2003)
				if CharInfo.CurrencyID[2003] ~= 0 then
					vivodCent = CharInfo.CurrencyID[2003]
				end
				return vivodCent, vivodLeft
		end)
		-- ТРАНСМОГ
		if Octo_ToDoVars.config.ShowTransmogrification == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(1673939).."Аберрий"
					-- vivodCent = CharInfo.classColorHex..CharInfo.classFilename.."|r"
					vivodCent = E.Octo_Func.func_texturefromIcon(1673939)
					if CharInfo.classFilename == "WARRIOR"
					or CharInfo.classFilename == "PALADIN"
					-- or CharInfo.classFilename == "HUNTER"
					or CharInfo.classFilename == "ROGUE"
					or CharInfo.classFilename == "PRIEST"
					-- or CharInfo.classFilename == "SHAMAN"
					-- or CharInfo.classFilename == "MAGE"
					-- or CharInfo.classFilename == "WARLOCK"
					or CharInfo.classFilename == "MONK"
					or CharInfo.classFilename == "DRUID"
					or CharInfo.classFilename == "DEMONHUNTER"
					-- or CharInfo.classFilename == "DEATHKNIGHT"
					-- or CharInfo.classFilename == "EVOKER"
					then
						tooltip[#tooltip+1] = {"Вроде работает", CharInfo.classColorHex.."LFR/Norm/Hero/Myth".."|r"}
					else
						tooltip[#tooltip+1] = {L["InDev"], CharInfo.classColorHex.."LFR/Norm/Hero/Myth".."|r"}
						vivodCent = vivodCent.."|cffFF0000".."*".."|r"
					end
					for _, classFilename in pairs(E.Octo_Table.OctoTable_EnglishClasses) do
						if classFilename == CharInfo.classFilename then
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Head"].."|r", Octo_ToDoTransmog[classFilename].Head.LFR.."/"..Octo_ToDoTransmog[classFilename].Head.Normal.."/"..Octo_ToDoTransmog[classFilename].Head.Heroic.."/"..Octo_ToDoTransmog[classFilename].Head.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Shoulder"].."|r", Octo_ToDoTransmog[classFilename].Shoulder.LFR.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Normal.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Heroic.."/"..Octo_ToDoTransmog[classFilename].Shoulder.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Back"].."|r", Octo_ToDoTransmog[classFilename].Back.LFR.."/"..Octo_ToDoTransmog[classFilename].Back.Normal.."/"..Octo_ToDoTransmog[classFilename].Back.Heroic.."/"..Octo_ToDoTransmog[classFilename].Back.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Chest"].."|r", Octo_ToDoTransmog[classFilename].Chest.LFR.."/"..Octo_ToDoTransmog[classFilename].Chest.Normal.."/"..Octo_ToDoTransmog[classFilename].Chest.Heroic.."/"..Octo_ToDoTransmog[classFilename].Chest.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Wrist"].."|r", Octo_ToDoTransmog[classFilename].Wrist.LFR.."/"..Octo_ToDoTransmog[classFilename].Wrist.Normal.."/"..Octo_ToDoTransmog[classFilename].Wrist.Heroic.."/"..Octo_ToDoTransmog[classFilename].Wrist.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Hands"].."|r", Octo_ToDoTransmog[classFilename].Hands.LFR.."/"..Octo_ToDoTransmog[classFilename].Hands.Normal.."/"..Octo_ToDoTransmog[classFilename].Hands.Heroic.."/"..Octo_ToDoTransmog[classFilename].Hands.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Waist"].."|r", Octo_ToDoTransmog[classFilename].Waist.LFR.."/"..Octo_ToDoTransmog[classFilename].Waist.Normal.."/"..Octo_ToDoTransmog[classFilename].Waist.Heroic.."/"..Octo_ToDoTransmog[classFilename].Waist.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Legs"].."|r", Octo_ToDoTransmog[classFilename].Legs.LFR.."/"..Octo_ToDoTransmog[classFilename].Legs.Normal.."/"..Octo_ToDoTransmog[classFilename].Legs.Heroic.."/"..Octo_ToDoTransmog[classFilename].Legs.Mythic}
							tooltip[#tooltip+1] = {CharInfo.classColorHex..L["Feet"].."|r", Octo_ToDoTransmog[classFilename].Feet.LFR.."/"..Octo_ToDoTransmog[classFilename].Feet.Normal.."/"..Octo_ToDoTransmog[classFilename].Feet.Heroic.."/"..Octo_ToDoTransmog[classFilename].Feet.Mythic}
						end
					end
					return vivodCent, vivodLeft
			end)
		end
		-- tinsert(OctoTable_func_otrisovka_FIRST,
		-- function(CharInfo, tooltip, CL, BG)
		-- local vivodCent, vivodLeft = "", ""
		-- vivodLeft = E.Octo_Func.func_texturefromIcon(2065622)..E.Octo_Func.func_texturefromIcon(237245)..E.Octo_Func.func_questName(77236)
		-- if CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count ~= E.Octo_Globals.NONE then
		-- vivodCent = vivodCent..CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count
		-- end
		-- if CharInfo.ItemsInBag[208951] ~= 0 then
		-- vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.."+|r"
		-- tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2065622)..E.Octo_Func.func_itemName(208951), CharInfo.ItemsInBag[208951]}
		-- end
		-- if CharInfo.ItemsInBag[208952] ~= 0 then
		-- vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.."+|r"
		-- tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(237245)..E.Octo_Func.func_itemName(208952), CharInfo.ItemsInBag[208952]}
		-- end
		-- BG:SetColorTexture(.64, .21, .93, .1)
		-- return vivodCent, vivodLeft
		-- end)
		if Octo_ToDoVars.config.TimeRift == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(628677)..Timer_DF_TimeRift()..L["TimeRift"])
					if CharInfo.Octopussy_DF_Weekly_TimeRift_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_TimeRift_count
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(2026009)..E.Octo_Func.func_itemName(207030)
					if CharInfo.ItemsInBag[207030] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[207030].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(1391676)..E.Octo_Func.func_itemName(207002)
					if CharInfo.ItemsInBag[207002] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.ItemsInBag[207002].."|r"
					end
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					if CharInfo.CurrencyID[2594] ~= 0 then
						if CharInfo.CurrencyID[2594] < 500 then
							vivodCent = E.Octo_Globals.Gray_Color..CharInfo.CurrencyID[2594].."|r"
						else
							vivodCent = CharInfo.CurrencyID[2594]
						end
					end
					if CharInfo.ItemsInBag[208945] ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.WOW_WoWToken_Color.." +"..CharInfo.ItemsInBag[208945].."|r"..E.Octo_Func.func_itemTexture(208945)
					end
					vivodLeft = E.Octo_Func.func_currencyicon(2594)..E.Octo_Globals.WOW_Rare_Color..L["Transferable Flakes"]..":|r "..E.Octo_Globals.White_Color..TotalTransParacausalFlakes.."|r"
					BG:SetColorTexture(.64, .21, .93, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		if Octo_ToDoVars.config.Dreamsurges == true then
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = (E.Octo_Func.func_texturefromIcon(134206)..Timer_DF_Dreamsurges()..L["Dreamsurges"])
					if CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count ~= E.Octo_Globals.NONE then
						vivodCent = CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count
					end
					if CharInfo.ItemsInBag[209419] ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1044087)..E.Octo_Globals.WOW_Rare_Color..L["Charred Elemental Remains"].."|r", CharInfo.ItemsInBag[209419]}
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					local vivodLeft = E.Octo_Func.func_texturefromIcon(134206)..E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(77414)
					vivodCent = CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count
					if CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= E.Octo_Globals.DONE and CharInfo.DreamsurgeInvestigation ~= 0 and CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count ~= "" then
						tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..E.Octo_Func.func_questName(77414).."|r", CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
						tooltip[#tooltip+1] = {CharInfo.DreamsurgeInvestigation, " "}
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(4643985)..E.Octo_Globals.WOW_Epic_Color..L["Dreamsurge Chrysalis"].."|r"
					if CharInfo.ItemsInBag[208153] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Epic_Color..CharInfo.ItemsInBag[208153].."|r"
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
			-- tinsert(OctoTable_func_otrisovka_FIRST,
			-- function(CharInfo, tooltip, CL, BG)
			-- local vivodCent, vivodLeft = "", ""
			-- vivodLeft = E.Octo_Func.func_texturefromIcon(1044087)..E.Octo_Globals.WOW_Rare_Color..L["Charred Elemental Remains"].."|r"
			-- if CharInfo.ItemsInBag[209419] ~= 0 then
			-- vivodCent = E.Octo_Globals.WOW_Rare_Color..CharInfo.ItemsInBag[209419].."|r"
			-- end
			-- BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
			-- return vivodCent, vivodLeft
			-- end)
			tinsert(OctoTable_func_otrisovka_FIRST,
				function(CharInfo, tooltip, CL, BG)
					local vivodCent, vivodLeft = "", ""
					vivodLeft = E.Octo_Func.func_texturefromIcon(132858)..E.Octo_Globals.WOW_Common_Color..L["Dreamsurge Coalescence"].."|r"
					if CharInfo.ItemsInBag[207026] ~= 0 then
						vivodCent = E.Octo_Globals.WOW_Common_Color..CharInfo.ItemsInBag[207026].."|r"
					end
					BG:SetColorTexture(.31, 1, .47, E.Octo_Globals.BGALPHA)
					return vivodCent, vivodLeft
			end)
		end
		-- События
		if Octo_ToDoVars.config.ShowEvents == true then
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[628] then -- Путешествие во времени по подземельям (Катазклизм)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(514016).."Cataclysm"
						if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
						if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542852)..L["Firelands"]
						if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_Cataclysm_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
						if CharInfo.CurrencyID[1166] ~= 0 then
							vivodCent = CharInfo.CurrencyID[1166]
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 628
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[622] then -- Путешествие во времени по подземельям (Burning Crusade)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(514016).."Burning Crusade"
						if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
						if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542852)..L["Black Temple"]
						if CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_RAIDS_BurningCrusade_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
						if CharInfo.CurrencyID[1166] ~= 0 then
							vivodCent = CharInfo.CurrencyID[1166]
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 622
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[1265] then -- Путешествие во времени по подземельям (Legion)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1379226).."Legion"
						if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
						if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
						if CharInfo.CurrencyID[1166] ~= 0 then
							vivodCent = CharInfo.CurrencyID[1166]
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 1265
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[652] then -- Путешествие во времени по подземельям (Mists of Pandaria)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1416740).."Mists of Pandaria"
						if CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS
						if CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(463446)..E.Octo_Func.func_currencyName(1166)
						if CharInfo.CurrencyID[1166] ~= 0 then
							vivodCent = CharInfo.CurrencyID[1166]
						end
						BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 1265
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[1352] then -- Подземелья Dragonfly
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(1542856)..DUNGEONS.." Dragonfly"
						if CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_EmissaryofWar_count
						end
						BG:SetColorTexture(.65, 1, 0, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 1352
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[1400] then -- Кубок Восточных королевств
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = Octo_ToDo_SmartCollectNEW2.Holiday.Collect[1400]
						if CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Month_TheEasternKingdomsCupBegins_count
						end
						BG:SetColorTexture(1, .79, .54, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(4638724)..E.Octo_Func.func_currencyName(2588)
						if CharInfo.CurrencyID[2588] ~= 0 then
							vivodCent = CharInfo.CurrencyID[2588]
						end
						BG:SetColorTexture(1, .79, .54, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 1400
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[479] then -- Ярмарка Новолуния (Darkmoon Faire)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(354435)..E.Octo_Globals.Blue_Color.."Daily |r"..Octo_ToDo_SmartCollectNEW2.Holiday.Collect[479]
						if CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count ~= "0/9" then
							vivodCent = CharInfo.Octopussy_DF_Daily_DarkmoonFaire_count
						end
						BG:SetColorTexture(.54, .12, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(134481)..E.Octo_Func.func_currencyName(515)
						if CharInfo.CurrencyID[515] ~= 0 then
							vivodCent = CharInfo.CurrencyID[515]
						end
						BG:SetColorTexture(.54, .12, 1, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				-- БИЛЕТЫ
				-- tinsert(OctoTable_func_otrisovka_FIRST,
				-- function(CharInfo, tooltip, CL, BG)
				-- local vivodCent, vivodLeft = "", ""
				-- vivodLeft = E.Octo_Func.func_texturefromIcon(134481)..E.Octo_Func.func_itemName(81055)
				-- if CharInfo.ItemsInBag[81055] ~= 0 then
				-- vivodCent = CharInfo.ItemsInBag[81055]
				-- end
				-- BG:SetColorTexture(.54, .12, 1, E.Octo_Globals.BGALPHA)
				-- return vivodCent, vivodLeft
				-- end)
			end -- for 479
		end
		-- События (PvP)
		if Octo_ToDoVars.config.ShowPVPEvents == true then
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[602] then -- "Бонус на полях боя",
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if englishFaction == "Horde" then
							vivodLeft = Horde_Icon
						else
							vivodLeft = Alliance_Icon
						end
						if CharInfo.Faction == "Horde" then
							BG:SetColorTexture(1, .3, .31, E.Octo_Globals.BGALPHA)
						else
							BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						end
						if CharInfo.Octopussy_DF_Weekly_ACalltoBattle_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_ACalltoBattle_count
						end
						vivodLeft = vivodLeft..Octo_ToDo_SmartCollectNEW2.Holiday.Collect[602]
						return vivodCent, vivodLeft
				end)
			end
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[1049] or Octo_ToDo_SmartCollectNEW2.Holiday.Active[671] or Octo_ToDo_SmartCollectNEW2.Holiday.Active[1244] or Octo_ToDo_SmartCollectNEW2.Holiday.Active[1169] then
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if englishFaction == "Horde" then
							vivodLeft = Horde_Icon
						else
							vivodLeft = Alliance_Icon
						end
						if CharInfo.Faction == "Horde" then
							BG:SetColorTexture(1, .3, .31, E.Octo_Globals.BGALPHA)
						else
							BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						end
						if CharInfo.Octopussy_DF_Weekly_SomethingDifferent_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_SomethingDifferent_count
						end
						vivodLeft = vivodLeft.."PvP-потасовка"
						return vivodCent, vivodLeft
				end)
			end
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[610] then -- "Бонус за стычки на арене",
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if englishFaction == "Horde" then
							vivodLeft = Horde_Icon
						else
							vivodLeft = Alliance_Icon
						end
						if CharInfo.Faction == "Horde" then
							BG:SetColorTexture(1, .3, .31, E.Octo_Globals.BGALPHA)
						else
							BG:SetColorTexture(0, .65, 1, E.Octo_Globals.BGALPHA)
						end
						if CharInfo.Octopussy_DF_Weekly_TheArenaCalls_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Weekly_TheArenaCalls_count
						end
						vivodLeft = vivodLeft..Octo_ToDo_SmartCollectNEW2.Holiday.Collect[610]
						return vivodCent, vivodLeft
				end)
			end
		end
		-- Праздники
		if Octo_ToDoVars.config.ShowHoliday == true then
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[341] then -- Summer Festival
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = "SummerFestival"
						if CharInfo.Octopussy_DF_Month_SummerFestival_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Month_SummerFestival_count.." ("..CharInfo.ItemsInBag[23247]..E.Octo_Func.func_itemTexture(23247)..")"
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 341
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[372] then -- BREWFEST
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.LFGInstance[287].D_name ~= E.Octo_Globals.NONE then
							vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..CharInfo.LFGInstance[287].D_name
						end
						if CharInfo.LFGInstance[287].donetoday ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.LFGInstance[287].donetoday
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST, -- EVENT ID 372 (Brewfest)
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Func.func_texturefromIcon(133784)..E.Octo_Func.func_itemName(37829)
						-- vivodLeft = E.Octo_Func.func_texturefromIcon(236701).."Brewfest"
						if CharInfo.ItemsInBag[37829] ~= 0 then
							vivodCent = CharInfo.ItemsInBag[37829] -- ..Money_Icon
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(77155)
						if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
							vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_count
						end
						-- 77155, 77152, 77153, 77747, 76531, 77099, 77745, 77095, 77746, 77096, 77744, 77097,
						if CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.NONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= E.Octo_Globals.DONE and CharInfo.Octopussy_DF_Month_Brewfest_count ~= "0/12" then
							tooltip[#tooltip+1] = {E.Octo_Globals.Orange_Color.."БЕРЕГА ПРОБУЖДЕНИЯ".."|r", " "}
							tooltip[#tooltip+1] = {"/way #2022 58.26 67.58", CharInfo.OctoTable_QuestID[76531]} -- /way #2022 58.26 67.58
							tooltip[#tooltip+1] = {"/way #2022 76.35 35.43", CharInfo.OctoTable_QuestID[77095]} -- /way #2022 76.35 35.43
							tooltip[#tooltip+1] = {"/way #2022 47.67 83.27", CharInfo.OctoTable_QuestID[77744]} -- /way #2022 47.67 83.27
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {E.Octo_Globals.Green_Color.."РАВНИНЫ ОНАРА".."|r", " "}
							tooltip[#tooltip+1] = {"/way #2023 59.77 38.73", CharInfo.OctoTable_QuestID[77152]} -- /way #2023 59.77 38.73
							tooltip[#tooltip+1] = {"/way #2023 28.61 60.45", CharInfo.OctoTable_QuestID[77099]} -- /way #2023 28.61 60.45
							tooltip[#tooltip+1] = {"/way #2023 85.81 35.34", CharInfo.OctoTable_QuestID[77745]} -- /way #2023 85.81 35.34
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {E.Octo_Globals.Necrolord_Color.."ЛАЗУРНЫЙ ПРОСТОР".."|r", " "}
							tooltip[#tooltip+1] = {"/way #2024 62.79 57.74", CharInfo.OctoTable_QuestID[77746]} -- /way #2024 62.79 57.74
							tooltip[#tooltip+1] = {"/way #2024 46.92 40.23", CharInfo.OctoTable_QuestID[77096]} -- /way #2024 46.92 40.23
							tooltip[#tooltip+1] = {"/way #2024 12.39 49.33", CharInfo.OctoTable_QuestID[77097]} -- /way #2024 12.39 49.33
							tooltip[#tooltip+1] = {" ", " "}
							tooltip[#tooltip+1] = {E.Octo_Globals.Blue_Color.."ТАЛЬДРАЗУС".."|r", " "}
							tooltip[#tooltip+1] = {"/way #2025 50.1 42.71", CharInfo.OctoTable_QuestID[77747]} -- верх -- /way #2025 50.1 42.71
							tooltip[#tooltip+1] = {"/way #2025 52.2 81.5", CharInfo.OctoTable_QuestID[77155]} -- низ -- /way #2025 52.2 81.5
							tooltip[#tooltip+1] = {"/way #2112 47.87 47.74", CharInfo.OctoTable_QuestID[77153]} -- таверна -- /way #2112 47.87 47.74
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Globals.Yellow_Color.."Once |r"..E.Octo_Func.func_questName(12492)
						if CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Month_Brewfest_DirebrewsDireBrew_count
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Globals.Blue_Color.."Daily |r"..E.Octo_Func.func_questName(76591)
						if CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BubblingBrews_count
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						vivodLeft = E.Octo_Func.func_texturefromIcon(236701)..E.Octo_Globals.Blue_Color.."Daily |r"..E.Octo_Func.func_questName(77208)
						if CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Daily_Brewfest_BarrelingDown_count
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 372
			if Octo_ToDo_SmartCollectNEW2.Holiday.Active[324] then -- Тыквовин
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.LFGInstance[285].D_name ~= E.Octo_Globals.NONE then
							vivodLeft = E.Octo_Func.func_texturefromIcon(133661)..CharInfo.LFGInstance[285].D_name
						end
						if CharInfo.LFGInstance[285].donetoday ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.LFGInstance[285].donetoday
						end
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.Octopussy_DF_Month_HallowsEnd_count ~= E.Octo_Globals.NONE then
							vivodCent = CharInfo.Octopussy_DF_Month_HallowsEnd_count
						end
						vivodLeft = E.Octo_Func.func_texturefromIcon(132940)..E.Octo_Func.func_itemName(37586)
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
				tinsert(OctoTable_func_otrisovka_FIRST,
					function(CharInfo, tooltip, CL, BG)
						local vivodCent, vivodLeft = "", ""
						if CharInfo.ItemsInBag[33226] ~= 0 then
							vivodCent = CharInfo.ItemsInBag[33226]
						end
						vivodLeft = E.Octo_Func.func_texturefromIcon(236546)..E.Octo_Func.func_itemName(33226)
						BG:SetColorTexture(1, .95, .44, E.Octo_Globals.BGALPHA)
						return vivodCent, vivodLeft
				end)
			end -- for 372
		end
	end
	-- Рейды тест Инсты
	if Octo_ToDoVars.config.InstanceTracker == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				-- if Octo_ToDoVars.config.ExpansionToShow == 10 then
				-- end
				local ServerTime = GetServerTime()
				for _, v in pairs(E.Octo_Table.OctoTable_journalInstanceID) do
					if CharInfo.journalInstance[v] ~= nil then
						for _, w in pairs(E.Octo_Table.OctoTable_instanceDifficulty) do
							if CharInfo.journalInstance[v][w] ~= nil then
								if CharInfo.journalInstance[v][w].vivod ~= nil and CharInfo.journalInstance[v][w].Time ~= nil then
									tooltip[#tooltip+1] = {CharInfo.journalInstance[v][w].instanceName.."("..CharInfo.journalInstance[v][w].difficultyName..") "..E.Octo_Globals.Red_Color..E.Octo_Func.SecondsToClock(CharInfo.journalInstance[v][w].instanceReset-ServerTime).."|r", CharInfo.journalInstance[v][w].vivod}
								end
							end
						end
					end
				end
				if #tooltip ~= 0 then
					-- vivodCent = E.Octo_Globals.Yellow_Color.."КД|r"
					vivodCent = E.Octo_Globals.Gray_Color..RAID_INFORMATION.."|r"
				end
				vivodLeft = "InstanceTracker"
				return vivodCent, vivodLeft
		end)
	end
	-- Валюта
	if Octo_ToDoVars.config.ShowCurrency == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2245)..E.Octo_Func.func_currencyName(2245), CharInfo.CurrencyID_Total[2245]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2594)..E.Octo_Func.func_currencyName(2594), CharInfo.CurrencyID_Total[2594]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2122)..E.Octo_Func.func_currencyName(2122), CharInfo.CurrencyID_Total[2122]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2118)..E.Octo_Func.func_currencyName(2118), CharInfo.CurrencyID_Total[2118]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2003)..E.Octo_Func.func_currencyName(2003), CharInfo.CurrencyID_Total[2003]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2009)..E.Octo_Func.func_currencyName(2009), CharInfo.CurrencyID_Total[2009]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1906)..E.Octo_Func.func_currencyName(1906), CharInfo.CurrencyID_Total[1906]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1828)..E.Octo_Func.func_currencyName(1828), CharInfo.CurrencyID_Total[1828]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1977)..E.Octo_Func.func_currencyName(1977), CharInfo.CurrencyID_Total[1977]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1813)..E.Octo_Func.func_currencyName(1813), CharInfo.CurrencyID_Total[1813]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1979)..E.Octo_Func.func_currencyName(1979), CharInfo.CurrencyID_Total[1979]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1904)..E.Octo_Func.func_currencyName(1904), CharInfo.CurrencyID_Total[1904]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1819)..E.Octo_Func.func_currencyName(1819), CharInfo.CurrencyID_Total[1819]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1931)..E.Octo_Func.func_currencyName(1931), CharInfo.CurrencyID_Total[1931]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1767)..E.Octo_Func.func_currencyName(1767), CharInfo.CurrencyID_Total[1767]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1885)..E.Octo_Func.func_currencyName(1885), CharInfo.CurrencyID_Total[1885]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1820)..E.Octo_Func.func_currencyName(1820), CharInfo.CurrencyID_Total[1820]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1816)..E.Octo_Func.func_currencyName(1816), CharInfo.CurrencyID_Total[1816]}
					if CharInfo.Possible_Anima == 0 and CharInfo.Possible_CatalogedResearch == 0 then
						vivodCent = E.Octo_Globals.Gray_Color..CURRENCY.."|r"
					end
					if CharInfo.Possible_Anima ~= 0 then
						vivodCent = vivodCent..E.Octo_Globals.Blue_Color..CharInfo.Possible_Anima.."|r"
					end
					if CharInfo.Possible_CatalogedResearch ~= 0 then
						vivodCent = vivodCent.." "..E.Octo_Globals.Rift_Color..CharInfo.Possible_CatalogedResearch.."|r"
					end
					if CharInfo.OctoTable_QuestID[64367] ~= E.Octo_Globals.Green_Color.."Done|r" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(187136)..E.Octo_Func.func_itemName(187136), E.Octo_Globals.Rift_Color.."(Korthia)|r".."Нужно купить +50%"..E.Octo_Func.func_currencyicon(1931)}
						vivodCent = vivodCent..E.Octo_Globals.Rift_Color.."-".."|r"
					end
					if CharInfo.OctoTable_QuestID[65282] ~= E.Octo_Globals.Green_Color.."Done|r" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(188793)..E.Octo_Func.func_itemName(188793), E.Octo_Globals.Cyan_Color.."(ZerethMortis)|r".."Нужно купить +50%"..E.Octo_Func.func_currencyicon(1979)}
						vivodCent = vivodCent..E.Octo_Globals.Cyan_Color.."-".."|r"
					end
					vivodLeft = L["Transferable Anima"]..": "..E.Octo_Globals.Blue_Color..TotalTransAnima.."|r"
				end
				if Octo_ToDoVars.config.ExpansionToShow == 8 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1580)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1580), CharInfo.CurrencyID_Total[1580].."(+"..CharInfo.Octopussy_BfA_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1803)..E.Octo_Func.func_currencyName(1803), CharInfo.CurrencyID_Total[1803]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1721)..E.Octo_Func.func_currencyName(1721), CharInfo.CurrencyID_Total[1721]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1587)..E.Octo_Func.func_currencyName(1587), CharInfo.CurrencyID_Total[1587]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1299)..E.Octo_Func.func_currencyName(1299), CharInfo.CurrencyID_Total[1299]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1565)..E.Octo_Func.func_currencyName(1565), CharInfo.CurrencyID_Total[1565]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1715)..E.Octo_Func.func_currencyName(1715), CharInfo.CurrencyID_Total[1715]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1755)..E.Octo_Func.func_currencyName(1755), CharInfo.CurrencyID_Total[1755]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1710)..E.Octo_Func.func_currencyName(1710), CharInfo.CurrencyID_Total[1710]}
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1716)..E.Octo_Func.func_currencyName(1716), CharInfo.CurrencyID_Total[1716]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1717)..E.Octo_Func.func_currencyName(1717), CharInfo.CurrencyID_Total[1717]}
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1560)..E.Octo_Func.func_currencyName(1560), CharInfo.CurrencyID_Total[1560]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1719)..E.Octo_Func.func_currencyName(1719), CharInfo.CurrencyID_Total[1719]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1718)..E.Octo_Func.func_currencyName(1718), CharInfo.CurrencyID_Total[1718]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 7 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1273)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1273), CharInfo.CurrencyID_Total[1273].."(+"..CharInfo.Octopussy_Legion_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1356)..E.Octo_Func.func_currencyName(1356), CharInfo.CurrencyID_Total[1356]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1275)..E.Octo_Func.func_currencyName(1275), CharInfo.CurrencyID_Total[1275]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1357)..E.Octo_Func.func_currencyName(1357), CharInfo.CurrencyID_Total[1357]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1508)..E.Octo_Func.func_currencyName(1508), CharInfo.CurrencyID_Total[1508]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1416)..E.Octo_Func.func_currencyName(1416), CharInfo.CurrencyID_Total[1416]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1342)..E.Octo_Func.func_currencyName(1342), CharInfo.CurrencyID_Total[1342]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1355)..E.Octo_Func.func_currencyName(1355), CharInfo.CurrencyID_Total[1355]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1154)..E.Octo_Func.func_currencyName(1154), CharInfo.CurrencyID_Total[1154]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1314)..E.Octo_Func.func_currencyName(1314), CharInfo.CurrencyID_Total[1314]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1149)..E.Octo_Func.func_currencyName(1149), CharInfo.CurrencyID_Total[1149]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1533)..E.Octo_Func.func_currencyName(1533), CharInfo.CurrencyID_Total[1533]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1226)..E.Octo_Func.func_currencyName(1226), CharInfo.CurrencyID_Total[1226]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1155)..E.Octo_Func.func_currencyName(1155), CharInfo.CurrencyID_Total[1155]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1220)..E.Octo_Func.func_currencyName(1220), CharInfo.CurrencyID_Total[1220]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1268)..E.Octo_Func.func_currencyName(1268), CharInfo.CurrencyID_Total[1268]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 6 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1129)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(1129), CharInfo.CurrencyID_Total[1129].."(+"..CharInfo.Octopussy_WoD_Weekly_coinsQuests_count..")"}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(994)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(994), CharInfo.CurrencyID_Total[994]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(823)..E.Octo_Func.func_currencyName(823), CharInfo.CurrencyID_Total[823]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(824)..E.Octo_Func.func_currencyName(824), CharInfo.CurrencyID_Total[824]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1101)..E.Octo_Func.func_currencyName(1101), CharInfo.CurrencyID_Total[1101]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(980)..E.Octo_Func.func_currencyName(980), CharInfo.CurrencyID_Total[980]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1017)..E.Octo_Func.func_currencyName(1017), CharInfo.CurrencyID_Total[1017]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(910)..E.Octo_Func.func_currencyName(910), CharInfo.CurrencyID_Total[910]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(944)..E.Octo_Func.func_currencyName(944), CharInfo.CurrencyID_Total[944]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1008)..E.Octo_Func.func_currencyName(1008), CharInfo.CurrencyID_Total[1008]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1020)..E.Octo_Func.func_currencyName(1020), CharInfo.CurrencyID_Total[1020]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(999)..E.Octo_Func.func_currencyName(999), CharInfo.CurrencyID_Total[999]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Mists of Pandaria".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(697)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(697), CharInfo.CurrencyID_Total[697]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(776)..E.Octo_Globals.Blue_Color.."("..L["Coins"]..") |r"..E.Octo_Func.func_currencyName(776), CharInfo.CurrencyID_Total[776]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(777)..E.Octo_Func.func_currencyName(777), CharInfo.CurrencyID_Total[777]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(738)..E.Octo_Func.func_currencyName(738), CharInfo.CurrencyID_Total[738]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(752)..E.Octo_Func.func_currencyName(752), CharInfo.CurrencyID_Total[752]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(789)..E.Octo_Func.func_currencyName(789), CharInfo.CurrencyID_Total[789]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Cataclysm".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(416)..E.Octo_Func.func_currencyName(416), CharInfo.CurrencyID_Total[416]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(361)..E.Octo_Func.func_currencyName(361), CharInfo.CurrencyID_Total[361]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(615)..E.Octo_Func.func_currencyName(615), CharInfo.CurrencyID_Total[615]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(614)..E.Octo_Func.func_currencyName(614), CharInfo.CurrencyID_Total[614]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Wrath of the Lich King".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(241)..E.Octo_Func.func_currencyName(241), CharInfo.CurrencyID_Total[241]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(61)..E.Octo_Func.func_currencyName(61), CharInfo.CurrencyID_Total[61]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 2 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."The Burning Crusade".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1704)..E.Octo_Func.func_currencyName(1704), CharInfo.CurrencyID_Total[1704]}
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient(GROUP_FINDER, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), ""}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1166)..E.Octo_Func.func_currencyName(1166), CharInfo.CurrencyID_Total[1166]}
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."PvP".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1602)..E.Octo_Func.func_currencyName(1602), CharInfo.CurrencyID_Total[1602]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1792)..E.Octo_Func.func_currencyName(1792), CharInfo.CurrencyID_Total[1792]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2123)..E.Octo_Func.func_currencyName(2123), CharInfo.CurrencyID_Total[2123]}
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(391)..E.Octo_Func.func_currencyName(391), CharInfo.CurrencyID_Total[391]}
				end
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Other"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2032)..E.Octo_Func.func_currencyName(2032), E.Octo_Func.func_currencyquantity(2032)} -- все персы
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(2588)..E.Octo_Func.func_currencyName(2588), CharInfo.CurrencyID_Total[2588]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(1379)..E.Octo_Func.func_currencyName(1379), CharInfo.CurrencyID_Total[1379]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(515)..E.Octo_Func.func_currencyName(515), CharInfo.CurrencyID_Total[515]}
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(402)..E.Octo_Func.func_currencyName(402), CharInfo.CurrencyID_Total[402]}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_currencyicon(81)..E.Octo_Func.func_currencyName(81), CharInfo.CurrencyID_Total[81]}
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..CURRENCY.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- РЕПУТАЦИЯ
	if Octo_ToDoVars.config.ShowReputation == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for k, v in ipairs (E.Octo_Table.OctoTable_itemID_Reputation) do
					if CharInfo.ItemsInBag[v] ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v), CharInfo.ItemsInBag[v]}
					end
				end
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2507), CharInfo.reputationID[2507]} -- Драконья экспедиция
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2503), CharInfo.reputationID[2503]} -- Кентавры Маруук
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2511), CharInfo.reputationID[2511]} -- Искарские клыкарры
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2510), CharInfo.reputationID[2510]} -- Союз Вальдраккена
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2553), CharInfo.reputationID[2553]} -- Соридорми
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zaralek Cavern"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2564), CharInfo.reputationID[2564]} -- Лоаммские ниффы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2568), CharInfo.reputationID[2568]} -- Гонщик Мерцающего Огга
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["The Forbidden Reach"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2523), CharInfo.reputationID[2523]}
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2524), CharInfo.reputationID[2524]}
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Other"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2517), CharInfo.reputationID[2517]} -- Гневион
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2518), CharInfo.reputationID[2518]} -- Сабеллиан
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2550), CharInfo.reputationID[2550]} -- Кобальтовая ассамблея
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2544), CharInfo.reputationID[2544]} -- Консорциум ремесленников – филиал на Драконьих островах
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2526), CharInfo.reputationID[2526]} -- Фурболги из клана Зимней Шкуры
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2478), CharInfo.reputationID[2478]} -- Просветленные
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2470), CharInfo.reputationID[2470]} -- Легион Смерти
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2472), CharInfo.reputationID[2472]} -- Кодекс архивариуса
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2432), CharInfo.reputationID[2432]} -- Ве'нари
					tooltip[#tooltip+1] = {Kyrian_Icon..E.Octo_Func.func_reputationName(2407), CharInfo.reputationID[2407]} -- Перерожденные
					tooltip[#tooltip+1] = {Necrolord_Icon..E.Octo_Func.func_reputationName(2410), CharInfo.reputationID[2410]} -- Неумирающая армия
					tooltip[#tooltip+1] = {NightFae_Icon..E.Octo_Func.func_reputationName(2465), CharInfo.reputationID[2465]} -- Дикая Охота
					tooltip[#tooltip+1] = {Venthyr_Icon..E.Octo_Func.func_reputationName(2413), CharInfo.reputationID[2413]} -- Двор Жнецов
					tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2439), CharInfo.reputationID[2439]} -- Нераскаявшиеся
					if CharInfo.curCovID == 4 then -- 4Necrolord
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..Necrolord_Icon..E.Octo_Globals.Necrolord_Color..L["Necrolord"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2462), CharInfo.reputationID[2462]} -- Штопальщики
					end
					if CharInfo.curCovID == 3 then -- 3NightFae
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..NightFae_Icon..E.Octo_Globals.NightFae_Color..L["Night Fae"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2464), CharInfo.reputationID[2464]} -- Двор Ночи
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2463), CharInfo.reputationID[2463]} -- Чесночник
					end
					if CharInfo.curCovID == 2 then -- 2Venthyr
						if #tooltip > 0 then
							tooltip[#tooltip+1] = {" ", " "}
						end
						tooltip[#tooltip+1] = {" "..Venthyr_Icon..E.Octo_Globals.Venthyr_Color..L["Venthyr"].."|r", " "}
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2445), CharInfo.reputationID[2445]} -- Пепельный двор
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2449), CharInfo.reputationID[2449]} -- Графиня
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2455), CharInfo.reputationID[2455]} -- Хранитель склепа Каззир
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2457), CharInfo.reputationID[2457]} -- Великий мастер Воул
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2450), CharInfo.reputationID[2450]} -- Александрос Могрейн
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2456), CharInfo.reputationID[2456]} -- Дроман Алиот
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2446), CharInfo.reputationID[2446]} -- Баронесса Вайш
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2469), CharInfo.reputationID[2469]} -- Понимание фракталов
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2460), CharInfo.reputationID[2460]} -- Камнелоб
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2458), CharInfo.reputationID[2458]} -- Клейя и Пелагий
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2447), CharInfo.reputationID[2447]} -- Леди Лунная Ягода
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2454), CharInfo.reputationID[2454]} -- Чуфа
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2459), CharInfo.reputationID[2459]} -- Сика
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2448), CharInfo.reputationID[2448]} -- Миканикос
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2461), CharInfo.reputationID[2461]} -- Изобретатель чумы Марилет
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2451), CharInfo.reputationID[2451]} -- Капитан-егерь Корейн
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2452), CharInfo.reputationID[2452]} -- Полемарх Адрест
						tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2453), CharInfo.reputationID[2453]} -- Рендл и Дуборыл
					end
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2422), CharInfo.reputationID[2422]} -- Ночной народец
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2479), CharInfo.reputationID[2479]} -- Просветленные (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2442), CharInfo.reputationID[2442]} -- Двор Жнецов (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2471), CharInfo.reputationID[2471]} -- Легион Смерти (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2441), CharInfo.reputationID[2441]} -- Перерожденные (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2444), CharInfo.reputationID[2444]} -- Дикая Охота (Идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2474), CharInfo.reputationID[2474]} -- Ве'нари (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2473), CharInfo.reputationID[2473]} -- Кодекс архивариуса (идеал)
					-- tooltip[#tooltip+1] = { E.Octo_Func.func_reputationName(2440), CharInfo.reputationID[2440]} -- Неумирающая армия (Идеал)
				end
				if Octo_ToDoVars.config.ExpansionToShow == 8 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2024073)..Horde_Icon..E.Octo_Func.func_reputationName(2157), CharInfo.reputationID[2157]} -- Армия Чести
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2015853)..Horde_Icon..E.Octo_Func.func_reputationName(2103), CharInfo.reputationID[2103]} -- Империя Зандалари
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2057295)..Horde_Icon..E.Octo_Func.func_reputationName(2158), CharInfo.reputationID[2158]} -- Жители Вол'дуна
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2821776)..Horde_Icon..E.Octo_Func.func_reputationName(2373), CharInfo.reputationID[2373]} -- Освобожденные
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2043330)..Horde_Icon..E.Octo_Func.func_reputationName(2156), CharInfo.reputationID[2156]} -- Экспедиция Таланджи
						-- tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2111), CharInfo.reputationID[2111]} -- Зандаларские динозавры
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2024072)..Alliance_Icon..E.Octo_Func.func_reputationName(2159), CharInfo.reputationID[2159]} -- 7-й легион
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2921024)..Alliance_Icon..E.Octo_Func.func_reputationName(2400), CharInfo.reputationID[2400]} -- Клинки Волн
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2012312)..Alliance_Icon..E.Octo_Func.func_reputationName(2161), CharInfo.reputationID[2161]} -- Орден Пылающих Углей
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2027009)..Alliance_Icon..E.Octo_Func.func_reputationName(2162), CharInfo.reputationID[2162]} -- Орден Возрождения Шторма
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2395), CharInfo.reputationID[2395]} -- Улей Медокрылов
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2160), CharInfo.reputationID[2160]} -- Адмиралтейство Праудмуров
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2120), CharInfo.reputationID[2120]} -- Кул-Тирас - Тирагард
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2264), CharInfo.reputationID[2264]} -- Кул-Тирас - Друствар
						-- tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2265), CharInfo.reputationID[2265]} -- Кул-Тирас - долина Штормов
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(3204478)..E.Octo_Func.func_reputationName(2417), CharInfo.reputationID[2417]} -- Ульдумский союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(3204479)..E.Octo_Func.func_reputationName(2415), CharInfo.reputationID[2415]} -- Раджани
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2921023)..E.Octo_Func.func_reputationName(2391), CharInfo.reputationID[2391]} -- Ржавоболтское сопротивление
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2029406)..E.Octo_Func.func_reputationName(2164), CharInfo.reputationID[2164]} -- Защитники Азерот
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(2065717)..E.Octo_Func.func_reputationName(2163), CharInfo.reputationID[2163]} -- Тортолланские искатели
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Bodyguards"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2389), CharInfo.reputationID[2389]} -- Нери Остроерш
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2388), CharInfo.reputationID[2388]} -- Поэн Солежабрик
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2390), CharInfo.reputationID[2390]} -- Вим Соленодух
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2375), CharInfo.reputationID[2375]} -- Мастер охоты Акана
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2376), CharInfo.reputationID[2376]} -- Оракул Ори
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2377), CharInfo.reputationID[2377]} -- Мастер клинка Иновари
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Pet".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2427), CharInfo.reputationID[2427]} -- Молодой акир
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2370), CharInfo.reputationID[2370]} -- Обучение динозавров – Дикорог
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2233), CharInfo.reputationID[2233]} -- Dino Training - Pterrodax
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2416), CharInfo.reputationID[2416]} -- Раджани (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2392), CharInfo.reputationID[2392]} -- Ржавоболтское сопротивление (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2385), CharInfo.reputationID[2385]} -- Армия Чести (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2384), CharInfo.reputationID[2384]} -- 7-й легион (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2381), CharInfo.reputationID[2381]} -- Орден Возрождения Шторма (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2379), CharInfo.reputationID[2379]} -- Адмиралтейство Праудмуров (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2378), CharInfo.reputationID[2378]} -- Империя Зандалари (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2382), CharInfo.reputationID[2382]} -- Жители Вол'дуна (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2383), CharInfo.reputationID[2383]} -- Орден Пылающих Углей (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2387), CharInfo.reputationID[2387]} -- Тортолланские искатели (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2386), CharInfo.reputationID[2386]} -- Защитники Азерот (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2380), CharInfo.reputationID[2380]} -- Экспедиция Таланджи (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2418), CharInfo.reputationID[2418]} -- Ульдумский союз (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2374), CharInfo.reputationID[2374]} -- Освобожденные (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2401), CharInfo.reputationID[2401]} -- Анкоа из клана Клинков Волн (идеал)
				end
				if Octo_ToDoVars.config.ExpansionToShow == 7 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1585245)..E.Octo_Func.func_reputationName(2045), CharInfo.reputationID[2045]} -- Армия погибели Легиона
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1608729)..E.Octo_Func.func_reputationName(2165), CharInfo.reputationID[2165]} -- Армия Света
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447608)..E.Octo_Func.func_reputationName(1859), CharInfo.reputationID[1859]} -- Помраченные
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447611)..E.Octo_Func.func_reputationName(1948), CharInfo.reputationID[1948]} -- Валарьяры
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447607)..E.Octo_Func.func_reputationName(1900), CharInfo.reputationID[1900]} -- Двор Фарондиса
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1708511)..E.Octo_Func.func_reputationName(2170), CharInfo.reputationID[2170]} -- Защитники Аргуса
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447612)..E.Octo_Func.func_reputationName(1828), CharInfo.reputationID[1828]} -- Племена Крутогорья
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447613)..E.Octo_Func.func_reputationName(1894), CharInfo.reputationID[1894]} -- Стражи
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1447610)..E.Octo_Func.func_reputationName(1883), CharInfo.reputationID[1883]} -- Ткачи Снов
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1975), CharInfo.reputationID[1975]} -- Кудесник Маргосс
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2135), CharInfo.reputationID[2135]} -- Хроми
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2018), CharInfo.reputationID[2018]} -- Отмщение Когтя
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1899), CharInfo.reputationID[1899]} -- Лунные стражи
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2097), CharInfo.reputationID[2097]} -- Илиссия Водная
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2098), CharInfo.reputationID[2098]} -- Хранительница Рейна
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2102), CharInfo.reputationID[2102]} -- Бесс
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2101), CharInfo.reputationID[2101]} -- Ша'лет
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2099), CharInfo.reputationID[2099]} -- Акуле Речной Рог
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2100), CharInfo.reputationID[2100]} -- Корбин
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1984), CharInfo.reputationID[1984]} -- Спасатели
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1862), CharInfo.reputationID[1862]} -- Жажда магии Окулета
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1919), CharInfo.reputationID[1919]} -- Жажда магии Вальтруа
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1860), CharInfo.reputationID[1860]} -- Жажда магии Талисры
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1815), CharInfo.reputationID[1815]} -- Выжившие из Гилнеаса
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1947), CharInfo.reputationID[1947]} -- Иллидари
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1989), CharInfo.reputationID[1989]} -- Лунные стражи
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1888), CharInfo.reputationID[1888]} -- Яндвикские врайкулы
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2089), CharInfo.reputationID[2089]} -- Помраченные (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2086), CharInfo.reputationID[2086]} -- Валарьяры (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2085), CharInfo.reputationID[2085]} -- Племена Крутогорья (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2090), CharInfo.reputationID[2090]} -- Стражи (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2087), CharInfo.reputationID[2087]} -- Двор Фарондиса (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2091), CharInfo.reputationID[2091]} -- Армия погибели Легиона (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2166), CharInfo.reputationID[2166]} -- Армия Света (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(2088), CharInfo.reputationID[2088]} -- Ткачи Снов (идеал)
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1861), CharInfo.reputationID[1861]} -- Arcane Thirst (Silgryn) DEPRECATED
				end
				if Octo_ToDoVars.config.ExpansionToShow == 6 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1052654)..E.Octo_Func.func_reputationName(1711), CharInfo.reputationID[1711]} -- Археологическое общество Хитрой Шестеренки
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1240656)..E.Octo_Func.func_reputationName(1849), CharInfo.reputationID[1849]} -- Орден Пробудившихся
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1042646)..E.Octo_Func.func_reputationName(1515), CharInfo.reputationID[1515]} -- Араккоа-изгои
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1240657)..E.Octo_Func.func_reputationName(1850), CharInfo.reputationID[1850]} -- Охотники за саблеронами
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1044164)..Horde_Icon..E.Octo_Func.func_reputationName(1445), CharInfo.reputationID[1445]} -- Клан Северного Волка
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1043559)..Horde_Icon..E.Octo_Func.func_reputationName(1708), CharInfo.reputationID[1708]} -- Клан Веселого Черепа
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1848), CharInfo.reputationID[1848]} -- Охотники за головами
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1042739)..Alliance_Icon..E.Octo_Func.func_reputationName(1710), CharInfo.reputationID[1710]} -- Защитники Ша'тар
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(1048727)..Alliance_Icon..E.Octo_Func.func_reputationName(1731), CharInfo.reputationID[1731]} -- Совет экзархов
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1847), CharInfo.reputationID[1847]} -- Длань Пророка
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if #tooltip > 0 then tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Bodyguards"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "} end
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1735), CharInfo.reputationID[1735]} -- Телохранители из казарм
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1737), CharInfo.reputationID[1737]} -- Жрец Когтя Ишааль
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1741), CharInfo.reputationID[1741]} -- Леорадж
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1736), CharInfo.reputationID[1736]} -- Тормок
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1740), CharInfo.reputationID[1740]} -- Аеда Ясная Заря
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1739), CharInfo.reputationID[1739]} -- Вивианна
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1738), CharInfo.reputationID[1738]} -- Защитница Иллона
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1733), CharInfo.reputationID[1733]} -- Делвар Железный Кулак
					end
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1520), CharInfo.reputationID[1520]} -- Изгнанники клана Призрачной Луны
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1732), CharInfo.reputationID[1732]} -- Дренорcкая Экспедиция Хитрой Шестеренки
				end
				if Octo_ToDoVars.config.ExpansionToShow == 5 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Mists of Pandaria".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(838811)..E.Octo_Func.func_reputationName(1435), CharInfo.reputationID[1435]} -- Натиск Шадо-Пан
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645203)..E.Octo_Func.func_reputationName(1341), CharInfo.reputationID[1341]} -- Небожители
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(643874)..E.Octo_Func.func_reputationName(1302), CharInfo.reputationID[1302]} -- Рыболовы
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(643910)..E.Octo_Func.func_reputationName(1269), CharInfo.reputationID[1269]} -- Золотой Лотос
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645198)..E.Octo_Func.func_reputationName(1272), CharInfo.reputationID[1272]} -- Земледельцы
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(645204)..E.Octo_Func.func_reputationName(1270), CharInfo.reputationID[1270]} -- Шадо-Пан
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(646324)..E.Octo_Func.func_reputationName(1271), CharInfo.reputationID[1271]} -- Орден Облачного Змея
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(646377)..E.Octo_Func.func_reputationName(1337), CharInfo.reputationID[1337]} -- Клакси
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(617219)..E.Octo_Func.func_reputationName(1345), CharInfo.reputationID[1345]} -- Хранители истории
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(838819)..Horde_Icon..E.Octo_Func.func_reputationName(1388), CharInfo.reputationID[1388]} -- Войска Похитителей Солнца
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1228), CharInfo.reputationID[1228]} -- Лесные хозены
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1375), CharInfo.reputationID[1375]} -- Армия Покорителей
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(801132)..Alliance_Icon..E.Octo_Func.func_reputationName(1387), CharInfo.reputationID[1387]} -- Армия Кирин-Тора
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1242), CharInfo.reputationID[1242]} -- Цзинь-юй Жемчужного Плавника
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1376), CharInfo.reputationID[1376]} -- Операция "Заслон"
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1492), CharInfo.reputationID[1492]} -- Император Шаохао
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1359), CharInfo.reputationID[1359]} -- Черный принц
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1358), CharInfo.reputationID[1358]} -- Нат Пэгл
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1278), CharInfo.reputationID[1278]} -- Шо
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1277), CharInfo.reputationID[1277]} -- Чи-Чи
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1216), CharInfo.reputationID[1216]} -- Академия Шан Си
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1283), CharInfo.reputationID[1283]} -- Фермер Фун
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1276), CharInfo.reputationID[1276]} -- Старик Горная Лапа
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1273), CharInfo.reputationID[1273]} -- Йогу Пьяный
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1275), CharInfo.reputationID[1275]} -- Элла
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1279), CharInfo.reputationID[1279]} -- Хаохань Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1281), CharInfo.reputationID[1281]} -- Джина Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1282), CharInfo.reputationID[1282]} -- Рыба Тростниковая Шкура
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1280), CharInfo.reputationID[1280]} -- Тина Грязный Коготь
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1440), CharInfo.reputationID[1440]} -- Восстание Черного Копья
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1351), CharInfo.reputationID[1351]} -- Хмелевары
				end
				if Octo_ToDoVars.config.ExpansionToShow == 4 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Cataclysm".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456567)..E.Octo_Func.func_reputationName(1135), CharInfo.reputationID[1135]} -- Служители Земли
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456570)..E.Octo_Func.func_reputationName(1158), CharInfo.reputationID[1158]} -- Стражи Хиджала
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456574)..E.Octo_Func.func_reputationName(1173), CharInfo.reputationID[1173]} -- Рамкахены
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456572)..E.Octo_Func.func_reputationName(1171), CharInfo.reputationID[1171]} -- Теразан
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456571)..Horde_Icon..E.Octo_Func.func_reputationName(1178), CharInfo.reputationID[1178]} -- Батальон Адского Крика
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456565)..Horde_Icon..E.Octo_Func.func_reputationName(1172), CharInfo.reputationID[1172]} -- Клан Драконьей Пасти
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456575)..Alliance_Icon..E.Octo_Func.func_reputationName(1174), CharInfo.reputationID[1174]} -- Клан Громового Молота
						tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(456564)..Alliance_Icon..E.Octo_Func.func_reputationName(1177), CharInfo.reputationID[1177]} -- Защитники Тол Барада
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1204), CharInfo.reputationID[1204]} -- Хиджальские мстители
				end
				if Octo_ToDoVars.config.ExpansionToShow == 3 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Wrath of the Lich King".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1073), CharInfo.reputationID[1073]} -- Калу'ак
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1098), CharInfo.reputationID[1098]} -- Рыцари Черного Клинка
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1156), CharInfo.reputationID[1156]} -- Пепельный союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1106), CharInfo.reputationID[1106]} -- Серебряный Авангард
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1091), CharInfo.reputationID[1091]} -- Драконий союз
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1090), CharInfo.reputationID[1090]} -- Кирин-Тор
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1104), CharInfo.reputationID[1104]} -- Племя Бешеного Сердца
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1105), CharInfo.reputationID[1105]} -- Оракулы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1119), CharInfo.reputationID[1119]} -- Сыны Ходира
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1052), CharInfo.reputationID[1052]} -- Экспедиция Орды
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1067), CharInfo.reputationID[1067]} -- Карающая Длань
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1124), CharInfo.reputationID[1124]} -- Похитители Солнца
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1085), CharInfo.reputationID[1085]} -- Армия Песни Войны
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1117), CharInfo.reputationID[1117]} -- Низина Шолазар
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1064), CharInfo.reputationID[1064]} -- Таунка
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1126), CharInfo.reputationID[1126]} -- Зиморожденные
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1094), CharInfo.reputationID[1094]} -- Серебряный Союз
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1050), CharInfo.reputationID[1050]} -- Экспедиция Отважных
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1037), CharInfo.reputationID[1037]} -- Авангард Альянса
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1068), CharInfo.reputationID[1068]} -- Лига исследователей
					end
				end
				if Octo_ToDoVars.config.ExpansionToShow == 2 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."The Burning Crusade".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(936), CharInfo.reputationID[936]} -- Город Шаттрат
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1031), CharInfo.reputationID[1031]} -- Стражи небес Ша'тар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1077), CharInfo.reputationID[1077]} -- Армия Расколотого Солнца
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(935), CharInfo.reputationID[935]} -- Ша'тар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1011), CharInfo.reputationID[1011]} -- Нижний Город
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(934), CharInfo.reputationID[934]} -- Провидцы
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(932), CharInfo.reputationID[932]} -- Алдоры
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					if CharInfo.Faction == "Horde" then
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(947), CharInfo.reputationID[947]} -- Траллмар
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(941), CharInfo.reputationID[941]} -- Маг'хары
					else
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(978), CharInfo.reputationID[978]} -- Куренай
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(946), CharInfo.reputationID[946]} -- Оплот Чести
					end
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(922), CharInfo.reputationID[922]} -- Транквиллион
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(942), CharInfo.reputationID[942]} -- Кенарийская экспедиция
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(970), CharInfo.reputationID[970]} -- Спореггар
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(933), CharInfo.reputationID[933]} -- Консорциум
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(989), CharInfo.reputationID[989]} -- Хранители Времени
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1038), CharInfo.reputationID[1038]} -- Огри'ла
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(967), CharInfo.reputationID[967]} -- Аметистовое Око
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1012), CharInfo.reputationID[1012]} -- Пеплоусты-служители
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(990), CharInfo.reputationID[990]} -- Песчаная Чешуя
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(1015), CharInfo.reputationID[1015]} -- Крылья Пустоты
				end
				if Octo_ToDoVars.config.ExpansionToShow == 1 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Classic".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.Faction == "Alliance" then
						-- Alliance
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(469), CharInfo.reputationID[469]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(891), CharInfo.reputationID[891]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1353), CharInfo.reputationID[1353]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(72), CharInfo.reputationID[72]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(69), CharInfo.reputationID[69]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(47), CharInfo.reputationID[47]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(54), CharInfo.reputationID[54]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1134), CharInfo.reputationID[1134]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(930), CharInfo.reputationID[930]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(509), CharInfo.reputationID[509]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1682), CharInfo.reputationID[1682]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(890), CharInfo.reputationID[890]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(730), CharInfo.reputationID[730]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1419), CharInfo.reputationID[1419]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(1691), CharInfo.reputationID[1691]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2011), CharInfo.reputationID[2011]}
						tooltip[#tooltip+1] = {Alliance_Icon..E.Octo_Func.func_reputationName(2371), CharInfo.reputationID[2371]}
					end
					if CharInfo.Faction == "Horde" then
						-- Horde
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(67), CharInfo.reputationID[67]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(892), CharInfo.reputationID[892]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1352), CharInfo.reputationID[1352]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(911), CharInfo.reputationID[911]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(76), CharInfo.reputationID[76]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(530), CharInfo.reputationID[530]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1133), CharInfo.reputationID[1133]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(81), CharInfo.reputationID[81]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(68), CharInfo.reputationID[68]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(510), CharInfo.reputationID[510]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1681), CharInfo.reputationID[1681]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(889), CharInfo.reputationID[889]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(729), CharInfo.reputationID[729]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1374), CharInfo.reputationID[1374]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(1690), CharInfo.reputationID[1690]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2010), CharInfo.reputationID[2010]}
						tooltip[#tooltip+1] = {Horde_Icon..E.Octo_Func.func_reputationName(2372), CharInfo.reputationID[2372]}
					end
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(349), CharInfo.reputationID[349]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(87), CharInfo.reputationID[87]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(749), CharInfo.reputationID[749]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(529), CharInfo.reputationID[529]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(21), CharInfo.reputationID[21]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(169), CharInfo.reputationID[169]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(70), CharInfo.reputationID[70]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(369), CharInfo.reputationID[369]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(609), CharInfo.reputationID[609]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(576), CharInfo.reputationID[576]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(577), CharInfo.reputationID[577]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(59), CharInfo.reputationID[59]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(470), CharInfo.reputationID[470]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(910), CharInfo.reputationID[910]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(270), CharInfo.reputationID[270]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(809), CharInfo.reputationID[809]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(92), CharInfo.reputationID[92]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(909), CharInfo.reputationID[909]}
					tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(93), CharInfo.reputationID[93]}
					-- tooltip[#tooltip+1] = {E.Octo_Func.func_reputationName(589), CharInfo.reputationID[589]}
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..REPUTATION.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Задания
	if Octo_ToDoVars.config.ShowQuests == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoVars.config.ExpansionToShow == 10 then
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {WorldBoss_Icon..L["World Boss"], CharInfo.Octopussy_DF_Weekly_WBALL_count}
					tooltip[#tooltip+1] = {Timer_DF_ToDragonbaneKeep()..L["Siege on Dragonbane Keep"], CharInfo.Octopussy_DF_Weekly_DragonbaneKeep_count}
					tooltip[#tooltip+1] = {Timer_DF_GrandHunts()..L["Grand Hunt"], CharInfo.Octopussy_DF_Weekly_TheGrandHunt_count}
					tooltip[#tooltip+1] = {Timer_DF_CommunityFeast()..L["Community Feast"], CharInfo.Octopussy_DF_Weekly_CommunityFeast_count}
					tooltip[#tooltip+1] = {L["Aiding the Accord"], CharInfo.Octopussy_DF_Weekly_AidingtheAccord_count}
					tooltip[#tooltip+1] = {L["Keys of Loyalty"], CharInfo.Octopussy_DF_Weekly_KeysofLoyalty_count}
					tooltip[#tooltip+1] = {L["PvP"], CharInfo.Octopussy_DF_Weekly_PVP_count}
					-- tooltip[#tooltip+1] = {L["PLAYER_DIFFICULTY_TIMEWALKER"].." (500)", CharInfo.Octopussy_DF_Weekly_Timewalk_500CURRENCY_count}
					-- tooltip[#tooltip+1] = {L["PLAYER_DIFFICULTY_TIMEWALKER"].." (5 dungeons)", CharInfo.Octopussy_DF_Weekly_Timewalk5DUNGEONS_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.7".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_Dreamsurges()..L["Dreamsurges"], CharInfo.Octopussy_DF_Once_DreamsurgeInvestigation_count}
					tooltip[#tooltip+1] = {L["Shaping the Dreamsurge"], CharInfo.Octopussy_DF_Weekly_ShapingtheDreamsurge_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Tyr's Fall"]..")", CharInfo.Octopussy_DF_Once_TyrsFall_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Reforging the Tyr's Guard"]..")", CharInfo.Octopussy_DF_Once_ReforgingtheTyrsGuard_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Coalition of Flames"]..")", CharInfo.Octopussy_DF_Once_TheCoalitionofFlames_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Seeing Red"]..")", CharInfo.Octopussy_DF_Once_SeeingRed_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Green_Color..L["Storyline"].."|r".." (".."Rumiastrasza"..")", CharInfo.Octopussy_DF_Once_Rumiastrasza_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."10.1.5".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {E.Octo_Func.func_questName(77236), CharInfo.Octopussy_DF_Weekly_WhenTimeNeedsMending_count}
					tooltip[#tooltip+1] = {Timer_DF_TimeRift()..L["TimeRift"], CharInfo.Octopussy_DF_Weekly_TimeRift_count}
					tooltip[#tooltip+1] = {L["Temporal Acquisitions Specialist"], CharInfo.Octopussy_DF_Once_TemporalAcquisitionsSpecialist_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Dawn of the Infinites"]..")", CharInfo.Octopussy_DF_Once_DawnoftheInfinitesStorylines_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zaralek Cavern"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_ResearchersUnderFire()..L["Researchers Under Fire"], CharInfo.Octopussy_DF_Weekly_ResearchersUnderFire_count}
					tooltip[#tooltip+1] = {WorldBoss_Icon..E.Octo_Func.func_questName(74892), CharInfo.Octopussy_DF_Weekly_WBZaralekCavernZaqaliElders_count}
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(5062638)..E.Octo_Func.func_questName(75694), CharInfo.Octopussy_DF_Once_AberrustheShadowedCrucibleSarkareth_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["Zaralek Cavern"]..")", CharInfo.Octopussy_DF_Once_ZaralekCavernStorylines_count}
					tooltip[#tooltip+1] = {E.Octo_Globals.Yellow_Color..L["Storyline"].."|r".." ("..L["The Veiled Ossuary"]..")", CharInfo.Octopussy_DF_Once_TheVeiledOssuary_count}
					tooltip[#tooltip+1] = {L["A Worthy Ally: Loamm Niffen"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernAWorthyAllyLoammNiffen_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking"] , CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseeking_count}
					tooltip[#tooltip+1] = {L["Sniffenseeking (items)"], CharInfo.Octopussy_DF_Weekly_ZaralekCavernSniffenseekingItems_count}
					tooltip[#tooltip+1] = {"Events", CharInfo.Octopussy_DF_Weekly_ZaralekCavernEvents_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_ZaralekCavernRares_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {L["Fighting is Its Own Reward"], CharInfo.Octopussy_DF_Weekly_FightingisItsOwnReward_count}
					tooltip[#tooltip+1] = {L["Fyrakk Asssaults"], CharInfo.Octopussy_DF_Weekly_FyrakkAssaults_count}
					tooltip[#tooltip+1] = {L["Disciple of Fyrakk"], CharInfo.Octopussy_DF_Weekly_DiscipleofFyrakk_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_texturefromIcon(4643981)..E.Octo_Func.func_questName(66847), CharInfo.Octopussy_DF_Once_VaultoftheIncarnatesFuryoftheStormEater_count}
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["The Forbidden Reach"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {Timer_DF_PrimalStorms()..L["The Storm's Fury"], CharInfo.Octopussy_DF_Weekly_StormsFury_count}
					tooltip[#tooltip+1] = {"Rares", CharInfo.Octopussy_DF_Weekly_TheForbiddenReachRares_count}
					tooltip[#tooltip+1] = {L["Storm-Bound Chest"], CharInfo.Octopussy_DF_Weekly_StormBoundChest_count}
				end
				if Octo_ToDoVars.config.ExpansionToShow == 9 then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_name, CharInfo.Octopussy_SL_Weekly_ReplenishtheReservoir_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_name, CharInfo.Octopussy_SL_Weekly_ReturnLostSouls_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_TradingFavors_name, CharInfo.Octopussy_SL_Weekly_TradingFavors_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBALL_name, CharInfo.Octopussy_SL_Weekly_WBALL_count}
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Zereth Mortis"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
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
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Korthia"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
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
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Maw"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_name, CharInfo.Octopussy_SL_Weekly_WBMawMorgeth_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_name, CharInfo.Octopussy_SL_Weekly_MawContainingtheHelsworn_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawQuest_name, CharInfo.Octopussy_SL_Daily_MawQuest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Daily_MawHelswornChest_name, CharInfo.Octopussy_SL_Daily_MawHelswornChest_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_name, CharInfo.Octopussy_SL_Weekly_MawCovenantAssault_count}
					tooltip[#tooltip+1] = {CharInfo.Octopussy_SL_Weekly_MawTorghast_name, CharInfo.Octopussy_SL_Weekly_MawTorghast_count}
				end
				if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" or CharInfo.classFilename == "WARLOCK" then
					if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
					tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Class quests"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
					if CharInfo.classFilename == "WARRIOR" or CharInfo.classFilename == "PALADIN" or CharInfo.classFilename == "DEATHKNIGHT" then
						tooltip[#tooltip+1] = {L["Shadowmourne"], CharInfo.Octopussy_WotLK_Once_Shadowmourne_count}
						if CharInfo.OctoTable_QuestID[24547] ~= E.Octo_Globals.NONE and CharInfo.OctoTable_QuestID[24547] ~= E.Octo_Globals.DONE then
							tooltip[#tooltip+1] = {E.Octo_Func.func_questName(24547), CharInfo.OctoTable_QuestID[24547]}
						end
					end
					if CharInfo.classFilename == "WARLOCK" then
						tooltip[#tooltip+1] = {L["Some Wicked Things"], CharInfo.Octopussy_DF_Once_Warlock_SomeWickedThings_count}
						local vivod = ""
						if CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count == E.Octo_Globals.DONE then
							if CharInfo.KnownSpell[101508] == true then
								vivod = " ("..E.Octo_Globals.Green_Color..L["ON"].."|r"..")"
							else
								vivod = " ("..E.Octo_Globals.Red_Color..L["OFF"].."|r"..")"
							end
						end
						tooltip[#tooltip+1] = {L["Green Fire"]..vivod, CharInfo.Octopussy_MoP_Once_Warlock_GreenFire_count}
					end
				end
				for k, v in ipairs(E.Octo_Table.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Race quests"].."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
						-- tooltip[#tooltip+1] = {CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_name"], CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmor_count"]}
					end
				end
				for k, v in ipairs(E.Octo_Table.OctoTable_Race) do
					if CharInfo.RaceEnglish == v.RaceEnglish and CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"] ~= 0 then
						if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
						tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»"..L["Allied Races Quests"] .."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
						-- tooltip[#tooltip+1] = {CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_name"], CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"]}
						tooltip[#tooltip+1] = {v.RaceEnglish, CharInfo["Octopussy_DF_Once_"..v.RaceEnglish.."HeritageArmorAllied_count"]}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..QUESTS_LABEL.." ("..CharInfo.numQuests..")|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- ПРОХОДКИ
	if Octo_ToDoVars.config.ShowSkips == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				vivodCent = E.Octo_Globals.Gray_Color..L["ShowSkips"].."|r"
				-- ДРЕНОР
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Warlords of Draenor".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37029]} -- NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37030]} -- NE NADO
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(37029)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[37031]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39502)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39502]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39504)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39504]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39505)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39505]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39499)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39499]} -- NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39500)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39500]} -- NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(39501)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[39501]} -- NE NADO
				tooltip[#tooltip+1] = {"", ""}
				-- ЛЕГИОН
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Legion".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44283)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44283]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44284)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44284]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(44285)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[44285]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45381)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45381]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45382)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45382]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(45383)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[45383]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47725)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47725]} -- NE NADO
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47726)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47726]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(47727)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[47727]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49133)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49133]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49134)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49134]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49135)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49135]}
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49032)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49032]} -- NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49075)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49075]} -- NE NADO
				-- tooltip[#tooltip+1] = {E.Octo_Func.func_questName(49076)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[49076]} -- NE NADO
				-- БФА
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Battle for Azeroth".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58373)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58373]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58374)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58374]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(58375)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[58375]}
				-- ШЛ
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Shadowlands".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62054)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62054]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62055)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62055]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(62056)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[62056]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64597)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64597]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64598)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64598]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(64599)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[64599]}
				-- ДФ
				if #tooltip > 0 then tooltip[#tooltip+1] = {" ", " "} end
				tooltip[#tooltip+1] = {E.Octo_Func.func_Gradient("»".."Dragonflight".."«", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), " "}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71018)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71018]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71019)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71019]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(71020)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[71020]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76083)..E.Octo_Globals.Green_Color.." "..PLAYER_DIFFICULTY1..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76083]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76085)..E.Octo_Globals.Blue_Color.." "..PLAYER_DIFFICULTY2..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76085]}
				tooltip[#tooltip+1] = {E.Octo_Func.func_questName(76086)..E.Octo_Globals.Purple_Color.." "..PLAYER_DIFFICULTY6..FONT_COLOR_CODE_CLOSE, CharInfo.OctoTable_QuestID[76086]}
				return vivodCent, vivodLeft
		end)
	end
	-- ПРЕДМЕТЫ
	if Octo_ToDoVars.config.ShowItems == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				for k, v in ipairs(E.Octo_Table.OctoTable_itemID_ALL) do
					local count = tonumber(CharInfo.ItemsInBag[v])
					if count ~= 0 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v), count}
					end
				end
				if #tooltip ~= 0 then
					vivodCent = E.Octo_Globals.Gray_Color..ITEMS.."|r"
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Профессии
	if Octo_ToDoVars.config.ShowProfessions == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if CharInfo.Octopussy_DF_Once_CatchingUp_count ~= E.Octo_Globals.DONE and CharInfo.UnitLevel >= 70 then
					tooltip[#tooltip+1] = {E.Octo_Globals.Red_Color.."Нужно сделать квест: |r"..CharInfo.Octopussy_DF_Once_CatchingUp_name.." /way 60, 72", CharInfo.Octopussy_DF_Once_CatchingUp_count}
				end
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(CharInfo.professions[k].icon)..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
						if CharInfo.UnitLevel >= 70 then
							tooltip[#tooltip+1] = {"Сундуки", CharInfo.professions[k].chest.chest_count.."/"..CharInfo.professions[k].chest.questReq}
							tooltip[#tooltip+1] = {"Лут", CharInfo.professions[k].drops.drops_count.."/"..CharInfo.professions[k].drops.questReq}
							tooltip[#tooltip+1] = {"Квест", CharInfo.professions[k].profQuest.profQuest_count.."/"..CharInfo.professions[k].profQuest.questReq}
							tooltip[#tooltip+1] = {"Трактаты", CharInfo.professions[k].treatise.treatise_count.."/"..CharInfo.professions[k].treatise.questReq}
							tooltip[#tooltip+1] = {"Крафт", CharInfo.professions[k].craftOrder.craftOrder_count.."/"..CharInfo.professions[k].craftOrder.questReq}
							tooltip[#tooltip+1] = {" ", " "}
						end
						if CharInfo.professions[k].icon then
							vivodCent = vivodCent..CharInfo.professions[k].icon.." "
						end
					end
				end
				for k, v in pairs(E.Octo_Table.Octo_ProfessionsskillLine_Other) do
					if CharInfo.professions[k] then
						if CharInfo.professions[k].icon and CharInfo.professions[k].name and CharInfo.professions[k].skillLevel and CharInfo.professions[k].maxSkillLevel then
							tooltip[#tooltip+1] = {E.Octo_Func.Empty_Zero(CharInfo.professions[k].icon)..E.Octo_Globals.Orange_Color..E.Octo_Func.Empty_Zero(CharInfo.professions[k].name).."|r "..CharInfo.professions[k].skillLevel.."/"..CharInfo.professions[k].maxSkillLevel}
						end
					end
				end
				if CharInfo.UnitLevel >= 70 then
					tooltip[#tooltip+1] = {" ", " "}
					if CharInfo.ItemsInBag[199197] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(199197)..E.Octo_Func.func_itemName(199197), CharInfo.ItemsInBag[199197]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(199197)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(199197).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[199197].."|r"}
					end
					if CharInfo.ItemsInBag[190453] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190453)..E.Octo_Func.func_itemName(190453), CharInfo.ItemsInBag[190453]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190453)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(190453).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[190453].."|r"}
					end
					if CharInfo.ItemsInBag[191784] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(191784)..E.Octo_Func.func_itemName(191784).." /way 52, 33", CharInfo.ItemsInBag[191784]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(191784)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(191784).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[191784].."|r"}
					end
					if CharInfo.ItemsInBag[190456] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190456)..E.Octo_Func.func_itemName(190456), CharInfo.ItemsInBag[190456]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(190456)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(190456).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[190456].."|r"}
					end
					tooltip[#tooltip+1] = {" 10.1.0", ""}
					if CharInfo.ItemsInBag[204985] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204985)..E.Octo_Func.func_itemName(204985), CharInfo.ItemsInBag[204985]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204985)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204985).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204985].."|r"}
					end
					if CharInfo.ItemsInBag[204715] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204715)..E.Octo_Func.func_itemName(204715), CharInfo.ItemsInBag[204715]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204715)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204715).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204715].."|r"}
					end
					if CharInfo.ItemsInBag[204681] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204681)..E.Octo_Func.func_itemName(204681), CharInfo.ItemsInBag[204681]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204681)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204681).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204681].."|r"}
					end
					if CharInfo.ItemsInBag[204682] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204682)..E.Octo_Func.func_itemName(204682), CharInfo.ItemsInBag[204682]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204682)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204682).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204682].."|r"}
					end
					if CharInfo.ItemsInBag[204697] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204697)..E.Octo_Func.func_itemName(204697), CharInfo.ItemsInBag[204697]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204697)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204697).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204697].."|r"}
					end
					if CharInfo.ItemsInBag[204717] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204717)..E.Octo_Func.func_itemName(204717), CharInfo.ItemsInBag[204717]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204717)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204717).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204717].."|r"}
					end
					if CharInfo.ItemsInBag[204440] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204440)..E.Octo_Func.func_itemName(204440), CharInfo.ItemsInBag[204440]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204440)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204440).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204440].."|r"}
					end
					tooltip[#tooltip+1] = {" PVP", ""}
					if CharInfo.ItemsInBag[204186] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204186)..E.Octo_Func.func_itemName(204186), CharInfo.ItemsInBag[204186]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204186)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204186).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204186].."|r"}
					end
					if CharInfo.ItemsInBag[204187] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204187)..E.Octo_Func.func_itemName(204187), CharInfo.ItemsInBag[204187]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204187)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204187).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204187].."|r"}
					end
					if CharInfo.ItemsInBag[204188] >= 1 then
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204188)..E.Octo_Func.func_itemName(204188), CharInfo.ItemsInBag[204188]}
					else
						tooltip[#tooltip+1] = {E.Octo_Func.func_itemTexture(204188)..E.Octo_Globals.Gray_Color..E.Octo_Func.func_itemName_NOCOLOR(204188).."|r", E.Octo_Globals.Gray_Color..CharInfo.ItemsInBag[204188].."|r"}
					end
				end
				return vivodCent, vivodLeft
		end)
	end
	-- Деньги
	if Octo_ToDoVars.config.ShowMoney == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				-- CL:SetFontObject(OctoFont10)
				-- if CharInfo.Money then
				--     vivodLeft = curServerShort..": "..E.Octo_Globals.Yellow_Color..E.Octo_Func.CompactNumberFormat(TotalMoney/10000).."|r"..Money_Icon
				-- end
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
				return E.Octo_Globals.Yellow_Color..vivodCent.."|r", vivodLeft
		end)
	end
	-- Уровень предметов
	if Octo_ToDoVars.config.ShowItemLevel == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				-- vivodLeft = LFG_LIST_ITEM_LEVEL_INSTR_SHORT
				local pvpcolor = E.Octo_Globals.Red_Color
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					if CharInfo.avgItemLevelEquipped >= 440 then
						pvpcolor = E.Octo_Globals.Green_Color
					elseif CharInfo.avgItemLevelEquipped >= 400 then
						pvpcolor = E.Octo_Globals.Yellow_Color
					end
				end
				if CharInfo.avgItemLevelEquipped and CharInfo.avgItemLevel then
					vivodCent = pvpcolor..CharInfo.avgItemLevelEquipped
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
	-- Дата выхода
	if Octo_ToDoVars.config.ShowLogoutTime == true then
		tinsert(OctoTable_func_otrisovka_FIRST,
			function(CharInfo, tooltip, CL, BG)
				local vivodCent, vivodLeft = "", ""
				if Octo_ToDoOther.TokenPrice and Octo_ToDoOther.TokenPrice ~= 0 then
					vivodLeft = Token_Icon..TOKEN_FILTER_LABEL.." "..E.Octo_Globals.Yellow_Color..E.Octo_Func.CompactNumberFormat(Octo_ToDoOther.TokenPrice/10000)..Money_Icon.."|r"
				end
				if CharInfo.loginDay ~= 0 and CharInfo.loginDay ~= 0 then
					CL:SetFontObject(OctoFont10)
					vivodCent = CharInfo.loginHour.."\n"..CharInfo.loginDay
					if CharInfo.needResetWeekly == true then
						vivodCent = E.Octo_Globals.Gray_Color..vivodCent.."|r"
					elseif CharInfo.needResetDaily == true then
						vivodCent = E.Octo_Globals.Red_Color..vivodCent.."|r"
					end
				end
				return vivodCent, vivodLeft
		end)
	end
end
local function TotalMoneyCurServerOnShow()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."TotalMoneyCurServerOnShow".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local TotalMoneyCurServer = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
		if curServer == CharInfo.curServer and CharInfo.Money ~= 0 then
			TotalMoneyCurServer = TotalMoneyCurServer + CharInfo.Money
		end
	end
	return E.Octo_Func.CompactNumberFormat(TotalMoneyCurServer/10000)..Money_Icon
end
local function TotalMoneyAllServerOnShow()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."TotalMoneyAllServerOnShow".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local TotalMoneyAllServer = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
		TotalMoneyAllServer = TotalMoneyAllServer + CharInfo.Money
	end
	return E.Octo_Func.CompactNumberFormat(TotalMoneyAllServer/10000)..Money_Icon
end
function Octo_ToDo_FIRST_CreateAltFrame()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Octo_ToDo_FIRST_CreateAltFrame".."|r")
	end
	if not Octo_ToDo_FIRST_Frame_Main_Frame then
		-- Octo_ToDo_FIRST_Frame_Main_Frame = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_FIRST_Frame_Main_FrameПИЗДА", UIParent, "BackdropTemplate")
		Octo_ToDo_FIRST_Frame_Main_Frame = CreateFrame("BUTTON", "Octo_ToDo_FIRST_Frame_Main_FramePIZDA", UIParent, "BackdropTemplate")
		Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		--
		--
		--
		--
		local ScrollFrame = CreateFrame("ScrollFrame", "ScrollFrame"..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame)
		local ScrollBar = CreateFrame("EventFrame", nil, ScrollFrame, "MinimalScrollBar")
		ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", 6, 0)
		ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", 6, 0)
		local scrollChild = CreateFrame("Frame", nil, ScrollFrame)
		ScrollFrame:SetScrollChild(scrollChild)
		ScrollFrame:SetAllPoints()
		scrollChild:SetSize(1, 1)
		scrollChild:SetPoint("TOPRIGHT")
		-- ScrollFrame:SetClipsChildren(true)
		-- ScrollFrame это "содержимое" фрейм ивентов (база)
		-- ScrollBar что бы скрыть скроллбар
		-- scrollChild на что вешать (parent)
		ScrollUtil.InitScrollFrameWithScrollBar(ScrollFrame, ScrollBar)
		local OnMouseWheel = ScrollFrame:GetScript("OnMouseWheel")
		ScrollFrame:SetScript("OnMouseWheel", function(self, ...)
				if ScrollBar:IsShown() then
					OnMouseWheel(self, ...)
				end
		end)
		Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild = scrollChild
		Octo_ToDo_FIRST_Frame_Main_Frame.ScrollBar = ScrollBar
		--
		--
		--
		--
	end
	Octo_ToDo_FIRST_Frame_Main_Frame:SetClampedToScreen(false)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetFrameStrata("HIGH")
	Octo_ToDo_FIRST_Frame_Main_Frame:SetPoint("TOP", 0, -257*E.Octo_Globals.scale)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetBackdrop({
			bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
			edgeSize = 1,
	})
	Octo_ToDo_FIRST_Frame_Main_Frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetBackdropBorderColor(0, 0, 0, 1) -- бордер
	Octo_ToDo_FIRST_Frame_Main_Frame:SetScript("OnShow", function()
			Octo_ToDo_FIRST_AddDataToAltFrame()
	end)
	Octo_ToDo_FIRST_Frame_Main_Frame:EnableMouse(true)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetMovable(true)
	Octo_ToDo_FIRST_Frame_Main_Frame:RegisterForDrag("LeftButton")
	Octo_ToDo_FIRST_Frame_Main_Frame:SetScript("OnDragStart", Octo_ToDo_FIRST_Frame_Main_Frame.StartMoving)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetScript("OnDragStop", function() Octo_ToDo_FIRST_Frame_Main_Frame:StopMovingOrSizing() end)
	Octo_ToDo_FIRST_Frame_Main_Frame:RegisterForClicks("RightButtonUp")
	Octo_ToDo_FIRST_Frame_Main_Frame:SetScript("OnClick", function(self) self:Hide() end)
	Octo_ToDo_FIRST_Frame_Main_Frame:SetHeight(50)
	--
	if Octo_ToDoVars.config.ShowMoney then
		--
		if not Octo_Frame_TotalMoneyCurServer then
			Octo_Frame_TotalMoneyCurServer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
			Octo_Frame_TotalMoneyCurServer:SetSize(400, E.Octo_Globals.curHeight)
			Octo_Frame_TotalMoneyCurServer:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "BOTTOMLEFT", 4, -2)
			Octo_Frame_TotalMoneyCurServer:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_Frame_TotalMoneyCurServer:SetBackdropBorderColor(1, 0, 0, 0)
			Octo_Frame_TotalMoneyCurServer:HookScript("OnShow", TotalMoneyCurServerOnShow)
			local text = Octo_Frame_TotalMoneyCurServer:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			text:SetAllPoints()
			text:SetFontObject(OctoFont11)
			text:SetJustifyV("MIDDLE")
			text:SetJustifyH("LEFT")
			text:SetTextColor(1, 1, 1, 1)
			text:SetText(E.Octo_Func.func_CurServerShort(curServer)..": "..TotalMoneyCurServerOnShow())
		end
		--
		if TotalMoneyAllServerOnShow() ~= TotalMoneyCurServerOnShow() then
			if not Octo_Frame_TotalMoneyAllServer then
				Octo_Frame_TotalMoneyAllServer = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
				Octo_Frame_TotalMoneyAllServer:SetSize(400, E.Octo_Globals.curHeight)
				Octo_Frame_TotalMoneyAllServer:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "BOTTOMLEFT", 4, -22)
				Octo_Frame_TotalMoneyAllServer:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
				Octo_Frame_TotalMoneyAllServer:SetBackdropBorderColor(1, 0, 0, 0)
				Octo_Frame_TotalMoneyAllServer:HookScript("OnShow", TotalMoneyAllServerOnShow)
				local text = Octo_Frame_TotalMoneyAllServer:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
				text:SetAllPoints()
				text:SetFontObject(OctoFont11)
				text:SetJustifyV("MIDDLE")
				text:SetJustifyH("LEFT")
				text:SetTextColor(1, 1, 1, 1)
				text:SetText(L["Total"]..": "..TotalMoneyAllServerOnShow())
			end
		end
		--
	end
	--
	if not Octo_ToDo_FIRST_Frame_Close_Button then
		Octo_ToDo_FIRST_Frame_Close_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
		Octo_ToDo_FIRST_Frame_Close_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		Octo_ToDo_FIRST_Frame_Close_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", E.Octo_Globals.curHeight, 1)
		Octo_ToDo_FIRST_Frame_Close_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_FIRST_Frame_Close_Button:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_FIRST_Frame_Close_Button:SetScript("OnEnter", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(CLOSE)
				GameTooltip:Show()
		end)
		Octo_ToDo_FIRST_Frame_Close_Button:SetScript("OnLeave", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		Octo_ToDo_FIRST_Frame_Close_Button:SetScript("OnMouseDown", function(self)
				-- self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_FIRST_Frame_Close_Button:SetScript("OnClick", function()
				Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		end)
		local t = Octo_ToDo_FIRST_Frame_Close_Button:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_FIRST_Frame_Close_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
		-- t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(Octo_ToDo_FIRST_Frame_Close_Button)
		Octo_ToDo_FIRST_Frame_Close_Button:SetScript("OnKeyDown", function(self, key)
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:GetParent():Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
		end)
	end
	if Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST == true then
		--
		if not Octo_ToDo_FIRST_Frame_Options_Button then
			Octo_ToDo_FIRST_Frame_Options_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
			Octo_ToDo_FIRST_Frame_Options_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
			Octo_ToDo_FIRST_Frame_Options_Button:SetPoint("BOTTOMRIGHT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", (-E.Octo_Globals.curHeight)*1, 1)
			Octo_ToDo_FIRST_Frame_Options_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_ToDo_FIRST_Frame_Options_Button:SetBackdropBorderColor(1, 0, 0, 0)
			Octo_ToDo_FIRST_Frame_Options_Button:SetScript("OnEnter", function(self)
					-- self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
					GameTooltip:AddLine(OPTIONS)
					GameTooltip:Show()
			end)
			Octo_ToDo_FIRST_Frame_Options_Button:SetScript("OnLeave", function(self)
					-- self:SetBackdropBorderColor(1, 0, 0, 0)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:Hide()
			end)
			Octo_ToDo_FIRST_Frame_Options_Button:SetScript("OnMouseDown", function(self)
					-- self:SetBackdropBorderColor(1, 0, 0, .5)
					self.icon:SetVertexColor(1, 0, 0, .5)
			end)
			Octo_ToDo_FIRST_Frame_Options_Button:SetScript("OnClick", function()
					-- if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then
					--     Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
					-- end
					if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
						Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
					end
					if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
						Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
					end
					if SettingsPanel:IsVisible() and self:IsVisible() then
						HideUIPanel(SettingsPanel)
					else
						Settings.OpenToCategory(AddonTitle, true)
					end
			end)
			local t = Octo_ToDo_FIRST_Frame_Options_Button:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_Options_Button.icon = t
			t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\AddonTexture_FIRST.tga")
			-- t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Octo_ToDo_FIRST_Frame_Options_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_MarkOfHonor_Button then
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -60)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetBackdropBorderColor(0, .44, .98, 1)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDoLevels) do
						local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
						if (CharInfo.ItemsInBag[137642] ~= 0) then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(1322720)..CharInfo.ItemsInBag[137642], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[202196] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(4909720)..CharInfo.ItemsInBag[202196], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[86547] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(237230)..CharInfo.ItemsInBag[86547], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[183616] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(133291)..CharInfo.ItemsInBag[183616], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[166751] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(967526)..CharInfo.ItemsInBag[166751], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[122457] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(667491)..CharInfo.ItemsInBag[122457], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[190189] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine(E.Octo_Func.func_texturefromIcon(519378)..CharInfo.ItemsInBag[190189], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[204464] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(5009042)..CharInfo.ItemsInBag[204464], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[201325] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(4644002)..CharInfo.ItemsInBag[201325], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[12811] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_texturefromIcon(134122)..CharInfo.ItemsInBag[12811], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
						if CharInfo.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_itemTexture(200652)..CharInfo.ItemsInBag[200652], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, .44, .98, 1)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, .5)
					self.icon:SetVertexColor(1, 0, 0, .5)
			end)
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:SetScript("OnClick", function()
					Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
			end)
			local t = Octo_ToDo_FIRST_Frame_MarkOfHonor_Button:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_MarkOfHonor_Button.icon = t
			t:SetTexture(133784)
			-- t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Octo_ToDo_FIRST_Frame_MarkOfHonor_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_QuestFeast_Button then
			Octo_ToDo_FIRST_Frame_QuestFeast_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -90)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetBackdropBorderColor(.64, .21, .93, 1)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetScript("OnEnter", function(self)
					local i = 0
					self:SetBackdropBorderColor(1, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					for k, CharInfo in pairs(Octo_ToDoLevels) do
						local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
						if CharInfo.Octopussy_DF_Weekly_CommunityFeast_count ~= E.Octo_Globals.DONE and CharInfo.UnitLevel >= 60 then
							i = i +1
							GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"), CharInfo.Octopussy_DF_Weekly_CommunityFeast_count)
						end
						if CharInfo.ItemsInBag[200652] ~= 0 then
							i = i + 1
							GameTooltip:AddDoubleLine("$$$"..E.Octo_Func.func_itemTexture(200652)..CharInfo.ItemsInBag[200652], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
						end
					end
					if i == 0 then
						GameTooltip:AddLine(E.Octo_Globals.Green_Color.."All done|r")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, .44, .98, 1)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, .5)
					self.icon:SetVertexColor(1, 0, 0, .5)
			end)
			Octo_ToDo_FIRST_Frame_QuestFeast_Button:SetScript("OnClick", function()
					Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
			end)
			local t = Octo_ToDo_FIRST_Frame_QuestFeast_Button:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_QuestFeast_Button.icon = t
			t:SetTexture(629056)
			-- t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Octo_ToDo_FIRST_Frame_QuestFeast_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_Events_Button then
			Octo_ToDo_FIRST_Frame_Events_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
			Octo_ToDo_FIRST_Frame_Events_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
			Octo_ToDo_FIRST_Frame_Events_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -120)
			Octo_ToDo_FIRST_Frame_Events_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
			Octo_ToDo_FIRST_Frame_Events_Button:SetBackdropBorderColor(0, 0, 0, 1)
			Octo_ToDo_FIRST_Frame_Events_Button:SetScript("OnEnter", function(self)
					local countLines = 0
					self:SetBackdropBorderColor(0, 0, 0, 1)
					self.icon:SetVertexColor(1, 0, 0, 1)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(" ", " ")
					-- local currentDay = date("%d.%m.%Y")
					local classFilename = UnitClassBase("PLAYER")
					local rPerc, gPerc, bPerc = GetClassColor(classFilename)
					local classcolor = CreateColor(rPerc, gPerc, bPerc)
					GameTooltip:AddDoubleLine(classcolor:WrapTextInColorCode(L["Current Date"]), classcolor:WrapTextInColorCode(date("%d/%m/%Y")))
					GameTooltip:AddDoubleLine(" ", " ")
					for eventID, v in pairs(Octo_ToDo_SmartCollectNEW2.Holiday.Active) do
						GameTooltip:AddDoubleLine(E.Octo_Globals.Yellow_Color..Octo_ToDo_SmartCollectNEW2.Holiday.Active[eventID].title.."|r"..E.Octo_Globals.Gray_Color.." (id: "..Octo_ToDo_SmartCollectNEW2.Holiday.Active[eventID].id..")|r", Octo_ToDo_SmartCollectNEW2.Holiday.Active[eventID].startTime.." - "..Octo_ToDo_SmartCollectNEW2.Holiday.Active[eventID].endTime)
					end
					if i == 0 then
						GameTooltip:AddLine("No Data")
					end
					GameTooltip:AddDoubleLine(" ", " ")
					GameTooltip:Show()
			end)
			Octo_ToDo_FIRST_Frame_Events_Button:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, 1)
					self.icon:SetVertexColor(1, 1, 1, 1)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			Octo_ToDo_FIRST_Frame_Events_Button:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, .5)
					self.icon:SetVertexColor(1, 0, 0, .5)
			end)
			Octo_ToDo_FIRST_Frame_Events_Button:SetScript("OnClick", function()
					Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
			end)
			local t = Octo_ToDo_FIRST_Frame_Events_Button:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_Events_Button.icon = t
			t:SetTexture(237579) -- 298591)
			-- t:SetVertexColor(1, 1, 1, 1)
			t:SetAllPoints(Octo_ToDo_FIRST_Frame_Events_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_Phylacterweave_Button then
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -150)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetBackdropBorderColor(0, .44, .98, 1)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetScript("OnEnter", function(self)
		            local i = 0
		            self:SetBackdropBorderColor(1, 0, 0, 1)
		            self.icon:SetVertexColor(1, 0, 0, 1)
		            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
		            GameTooltip:ClearLines()
		            GameTooltip:AddDoubleLine(" ", " ")
		            for k, CharInfo in pairs(Octo_ToDoLevels) do
		                local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		                for _, v in pairs(E.Octo_Table.T3Items) do
		                    if (CharInfo.ItemsInBag[v] ~= 0) then
		                        i = i + 1
		                        GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
		                    end
		                end
		            end
		            if i == 0 then
		                GameTooltip:AddLine("No Data")
		            end
		            GameTooltip:AddDoubleLine(" ", " ")
		            GameTooltip:Show()
		    end)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetScript("OnLeave", function(self)
		            self:SetBackdropBorderColor(0, .44, .98, 1)
		            self.icon:SetVertexColor(1, 1, 1, 1)
		            GameTooltip:ClearLines()
		            GameTooltip:Hide()
		    end)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetScript("OnMouseDown", function(self)
		            self:SetBackdropBorderColor(1, 0, 0, .5)
		            self.icon:SetVertexColor(1, 0, 0, .5)
		    end)
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button:SetScript("OnClick", function()
		            Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		    end)
		    local t = Octo_ToDo_FIRST_Frame_Phylacterweave_Button:CreateTexture(nil, "BACKGROUND")
		    Octo_ToDo_FIRST_Frame_Phylacterweave_Button.icon = t
		    t:SetTexture(135331)
		    -- t:SetVertexColor(1, 1, 1, 1)
		    t:SetAllPoints(Octo_ToDo_FIRST_Frame_Phylacterweave_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_Dreamsurges_Button then
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -180)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetBackdropBorderColor(0, .44, .98, 1)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetScript("OnEnter", function(self)
		            local i = 0
		            self:SetBackdropBorderColor(1, 0, 0, 1)
		            self.icon:SetVertexColor(1, 0, 0, 1)
		            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
		            GameTooltip:ClearLines()
		            GameTooltip:AddDoubleLine(" ", " ")
		            for k, CharInfo in pairs(Octo_ToDoLevels) do
		                local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		                for _, v in ipairs(E.Octo_Table.Dreamsurges_Items) do
		                    if (CharInfo.ItemsInBag[v] ~= 0) then
		                        i = i + 1
		                        GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(v)..E.Octo_Func.func_itemName(v).." "..CharInfo.ItemsInBag[v], classcolor:WrapTextInColorCode(CharInfo.Name.."("..CharInfo.curServerShort..")"))
		                    end
		                end
		            end
		            if i == 0 then
		                GameTooltip:AddLine("No Data")
		            end
		            GameTooltip:AddDoubleLine(" ", " ")
		            GameTooltip:Show()
		    end)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetScript("OnLeave", function(self)
		            self:SetBackdropBorderColor(0, .44, .98, 1)
		            self.icon:SetVertexColor(1, 1, 1, 1)
		            GameTooltip:ClearLines()
		            GameTooltip:Hide()
		    end)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetScript("OnMouseDown", function(self)
		            self:SetBackdropBorderColor(1, 0, 0, .5)
		            self.icon:SetVertexColor(1, 0, 0, .5)
		    end)
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button:SetScript("OnClick", function()
		            Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		    end)
		    local t = Octo_ToDo_FIRST_Frame_Dreamsurges_Button:CreateTexture(nil, "BACKGROUND")
		    Octo_ToDo_FIRST_Frame_Dreamsurges_Button.icon = t
		    t:SetTexture(134206)
		    -- t:SetVertexColor(1, 1, 1, 1)
		    t:SetAllPoints(Octo_ToDo_FIRST_Frame_Dreamsurges_Button)
		end
		--
		if not Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button then
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "TOPRIGHT", 24, -210)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetBackdropBorderColor(0, .44, .98, 1)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetScript("OnEnter", function(self)
		            self:SetBackdropBorderColor(1, 0, 0, 1)
		            self.icon:SetVertexColor(1, 0, 0, 1)
		            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
		            GameTooltip:ClearLines()
		            GameTooltip:AddDoubleLine(" ", " ")
		            GameTooltip:AddDoubleLine(GREAT_VAULT_REWARDS)
		            GameTooltip:AddDoubleLine(" ", " ")
		            GameTooltip:Show()
		    end)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetScript("OnLeave", function(self)
		            self:SetBackdropBorderColor(0, .44, .98, 1)
		            self.icon:SetVertexColor(1, 1, 1, 1)
		            GameTooltip:ClearLines()
		            GameTooltip:Hide()
		    end)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetScript("OnMouseDown", function(self)
		            self:SetBackdropBorderColor(1, 0, 0, .5)
		            self.icon:SetVertexColor(1, 0, 0, .5)
		    end)
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:SetScript("OnClick", function()
		            Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		            if not WeeklyRewardsFrame then
		                WeeklyRewards_LoadUI()
		            end
		            if not WeeklyRewardsFrame:IsVisible() then
		                ShowUIPanel(WeeklyRewardsFrame, true)
		                WeeklyRewardsFrame:SetScale(0.9)
		            end
		    end)
		    local t = Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button:CreateTexture(nil, "BACKGROUND")
		    Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button.icon = t
		    for k, CharInfo in pairs(Octo_ToDoLevels) do
		        local curGUID = UnitGUID("PLAYER")
		        if k == curGUID then
		            for i = 1, 3 do
		                if CharInfo.GreatVault[i].hyperlink[i] ~= 0 then
		                    t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\WeeklyRewardsFrame_ON.tga")
		                else
		                    t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\WeeklyRewardsFrame_OFF.tga")
		                end
		            end
		        end
		    end
		    -- t:SetVertexColor(1, 1, 1, 1)
		    t:SetAllPoints(Octo_ToDo_FIRST_Frame_WeeklyRewardsFrame_Button)
		end
		--
	end
	local function CurrentNumQuests()
		local numQuests = select(2, C_QuestLog.GetNumQuestLogEntries())
		return numQuests
	end
	if not Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button then
		local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
		StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
			text = E.Octo_Globals.Red_Color.."!!! ACHTUNG !!!|r\n".."Отменить все задания?",
			button1 = YES,
			button2 = NO,
			hideOnEscape = 1,
			whileDead = 1,
			OnAccept = function()
				C_Timer.After(1, function()
						for i = 1, numShownEntries do
							if numQuests ~= 0 then
								local questInfo = C_QuestLog.GetInfo(i)
								if questInfo then
									if (not questInfo.isHeader and not questInfo.isHidden) then
										ChatFrame1:AddMessage(E.Octo_Func.func_Gradient(L["Abandon"], E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)..questInfo.title)
										C_QuestLog.SetSelectedQuest(questInfo.questID)
										C_QuestLog.SetAbandonQuest()
										C_QuestLog.AbandonQuest()
									end
								end
							end
						end
						ChatFrame1:AddMessage(E.Octo_Globals.DONE)
				end)
			end,
		}
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button = CreateFrame("Button", AddonTitle..E.Octo_Func.GenerateUniqueID(), Octo_ToDo_FIRST_Frame_Main_Frame, "BackDropTemplate")
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetSize(E.Octo_Globals.curHeight, E.Octo_Globals.curHeight)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetPoint("BOTTOMLEFT", Octo_ToDo_FIRST_Frame_Main_Frame, "BOTTOMRIGHT", 24, 0)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetBackdrop({ edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga", edgeSize = 1})
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 1)
				self.icon:SetVertexColor(1, 0, 0, 1)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(L["Abandon All Quests"].." ("..CurrentNumQuests()..")")
				GameTooltip:Show()
		end)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetScript("OnLeave", function(self)
				self:SetBackdropBorderColor(1, 0, 0, 0)
				self.icon:SetVertexColor(1, 1, 1, 1)
				GameTooltip:ClearLines()
				GameTooltip:Hide()
		end)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetScript("OnMouseDown", function(self)
				self:SetBackdropBorderColor(1, 0, 0, .5)
				self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:SetScript("OnClick", function()
				StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
		end)
		local t = Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button.icon = t
		t:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\SadKitty.tga")
		-- t:SetVertexColor(1, 1, 1, 1)
		t:SetAllPoints(Octo_ToDo_FIRST_Frame_AbandonAllQuests_Button)
	end
	--
	if Octo_ToDoVars.config.Portals == true then
		local Xpos = 0
		local Ypos = -21
		local prof1, prof2 = GetProfessions()
		local prof1 = prof1 and select(7, GetProfessionInfo(prof1))
		local prof2 = prof2 and select(7, GetProfessionInfo(prof2))
		local className, classFilename, classId = UnitClass("PLAYER")
		local Faction = UnitFactionGroup("PLAYER")
		if prof1 == 202 or prof2 == 202 then
			-- (itemID, Texture, count, Xpos, Ypos, r, g, b, spellID)
			CreateFrameUsableItems(198156, 4548860, 1, Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 366254) -- Генератор червоточин: Драконьи острова
			CreateFrameUsableItems(172924, 3610528, 1, Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 310542) -- Генератор червоточин: Темные Земли
			if Faction == "Horde" then
				CreateFrameUsableItems(168808, 2000840, 1, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 265807) -- Генератор червоточин: Зандалар
				CreateFrameUsableItems(168807, 2000841, 1, Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 265807) -- Генератор червоточин: Кул-Тирас
			else
				CreateFrameUsableItems(168808, 2000840, 1, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 264492) -- Генератор червоточин: Зандалар
				CreateFrameUsableItems(168807, 2000841, 1, Xpos*3+Ypos*1, Ypos*4, 0, .43, .86, 264492) -- Генератор червоточин: Кул-Тирас
			end
			CreateFrameUsableItems(151652, 237560, 1, Xpos*4+Ypos*1, Ypos*5, 0, .43, .86, 264490) -- Генератор червоточин: Аргус -- 264491
			CreateFrameUsableItems(112059, 892831, 1, Xpos*5+Ypos*1, Ypos*6, 0, .43, .86, 264487) -- Центрифуга червоточины
			CreateFrameUsableItems(87215, 651094, 1, Xpos*6+Ypos*1, Ypos*7, 0, .43, .86, 264485) -- Генератор червоточин: Пандария
			CreateFrameUsableItems(48933, 135778, 1, Xpos*7+Ypos*1, Ypos*8, 0, .43, .86, 264481) -- Генератор червоточин: Нордскол
			-- ЕСТЬ ИНЖА
			CreateFrameUsableItems(110560, 1041860, 1, Xpos*8+Ypos*1, Ypos*9, 0, .43, .86, 6603) -- Камень возвращения в гарнизон
			CreateFrameUsableItems(6948, 134414, 1, Xpos*9+Ypos*1, Ypos*10, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			CreateFrameUsableItems(140192, 1444943, 1, Xpos*10+Ypos*1, Ypos*11, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, select(3, GetSpellInfo(193753)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Сноходец
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, select(3, GetSpellInfo(50977)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Врата смерти
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, select(3, GetSpellInfo(556)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Астральное возвращение
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, select(3, GetSpellInfo(126892)), Xpos*12+Ypos*1, Ypos*12, 0, .43, .86) -- Духовное путешествие
			end
		else
			-- НЕТ ИНЖИ
			CreateFrameUsableItems(110560, 1041860, 1, Xpos*0+Ypos*1, Ypos*1, 0, .43, .86, 6603) -- Камень возвращения в гарнизон
			CreateFrameUsableItems(6948, 134414, 1, Xpos*1+Ypos*1, Ypos*2, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			CreateFrameUsableItems(140192, 1444943, 1, Xpos*2+Ypos*1, Ypos*3, 0, .43, .86, 6603) -- Камень возвращения в Даларан
			if classFilename == "DRUID" then
				CreateFrameUsableSpells(193753, select(3, GetSpellInfo(193753)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Сноходец
			end
			if classFilename == "DEATHKNIGHT" then
				CreateFrameUsableSpells(50977, select(3, GetSpellInfo(50977)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Врата смерти
			end
			if classFilename == "SHAMAN" then
				CreateFrameUsableSpells(556, select(3, GetSpellInfo(556)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Астральное возвращение
			end
			if classFilename == "MONK" then
				CreateFrameUsableSpells(126892, select(3, GetSpellInfo(126892)), Xpos*4+Ypos*1, Ypos*4, 0, .43, .86) -- Духовное путешествие
			end
		end
		local UnitLevel = UnitLevel("PLAYER")
		if UnitLevel >= 20 then
			-- (spellID, Texture, Xpos, Ypos, r, g, b)
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_MoP) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*2, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_WoD) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*3, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_Legion) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*4, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_BfA) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*5, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_SL) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*6, (Ypos*k), 0, .43, .86)
			end
			for k, v in pairs(E.Octo_Table.OctoTable_Portals_DF) do
				CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*7, (Ypos*k), 0, .43, .86)
			end
			if classFilename == "MAGE" and Faction == "Horde" then
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Horde) do
					CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Horde) do
					CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
				end
			end
			if classFilename == "MAGE" and Faction == "Alliance" then
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Solo_Alliance) do
					CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*8, (Ypos*k), 0, .43, .86)
				end
				for k, v in pairs(E.Octo_Table.OctoTable_Portals_Mage_Group_Alliance) do
					CreateFrameUsableSpells(v, select(3, GetSpellInfo(v)), Xpos*(k-1)+Ypos*9, (Ypos*k), 0, .43, .86)
				end
			end
			-- (itemID, Texture, count, Xpos, Ypos, r, g, b, spellID)
		else
			local  count = 0
			for k, v in pairs(E.Octo_Table.OctoTable_ScoutingMap) do
				if v.faction == englishFaction or v.faction == "Both" then
					count = count + 1
					CreateFrameUsableItems(v.toyID, v.icon, 1, Xpos*0+Ypos*2, (Ypos*count), 0, .43, .86, 6603) -- Камень возвращения в гарнизон
				end
			end
		end
	end
	local function FrameLine_OnEnter(self)
		self.BG:SetColorTexture(r, g, b, E.Octo_Globals.BGALPHA*2)
		Octo_ToDo_FIRST_Frame_Main_Frame:SetAlpha(1)
	end
	local function FrameLine_OnLeave(self)
		self.BG:SetColorTexture(0, 0, 0, 0)
	end
	for i = 1, #OctoTable_func_otrisovka_FIRST do -- БЭКГРАУНД
		local fname, f
		fname = "FrameLine"..i
		Octo_ToDo_FIRST_Frame_Main_Frame[fname] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."FrameLine"..i, Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild, "BackdropTemplate")
		f = Octo_ToDo_FIRST_Frame_Main_Frame[fname]
		f:SetHeight(E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild, "TOPLEFT", 0, -E.Octo_Globals.curHeight*(i-1))
		f:SetPoint("RIGHT")
		f:SetScript("OnEnter", FrameLine_OnEnter)
		f:SetScript("OnLeave", FrameLine_OnLeave)
		f:SetMouseClickEnabled(false)
		f.BG = f:CreateTexture(nil, "BACKGROUND")
		f.BG:SetHeight(E.Octo_Globals.curHeight)
		f.BG:SetAllPoints()
		fname = "TextLeft"..i
		Octo_ToDo_FIRST_Frame_Main_Frame[fname] = Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		f = Octo_ToDo_FIRST_Frame_Main_Frame[fname]
		f:SetSize(E.Octo_Globals.curWidthTitle, E.Octo_Globals.curHeight)
		f:SetPoint("TOPLEFT", Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild, "TOPLEFT", 6, -E.Octo_Globals.curHeight*(i-1))
		f:SetFontObject(OctoFont11)
		f:SetJustifyV("MIDDLE")
		f:SetJustifyH("LEFT")
		f:SetTextColor(1, 1, 1, 1)
	end
	Octo_ToDo_FIRST_AddDataToAltFrame()
	Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
end
function Octo_ToDo_FIRST_AddDataToAltFrame()
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Octo_ToDo_FIRST_AddDataToAltFrame".."|r")
	end
	local curGUID = UnitGUID("PLAYER")
	local UnitLevel = UnitLevel("PLAYER")
	local ShowOnlyCurrentRealm = Octo_ToDoVars.config.ShowOnlyCurrentRealm
	local LevelToShow = Octo_ToDoVars.config.LevelToShow
	local LevelToShowMAX = Octo_ToDoVars.config.LevelToShowMAX
	local itemLevelToShow = Octo_ToDoVars.config.itemLevelToShow
	Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames = {}
	local sorted = {}
	TotalTransAnima = 0
	TotalTransParacausalFlakes = 0
	for curCharGUID, CharInfo in pairs(Octo_ToDoLevels) do
		if ((ShowOnlyCurrentRealm == true and (CharInfo.curServer == GetRealmName())) and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= Octo_ToDoVars.config.LevelToShow) and (CharInfo.UnitLevel <= Octo_ToDoVars.config.LevelToShowMAX))
			or (ShowOnlyCurrentRealm == false and (CharInfo.avgItemLevel >= itemLevelToShow) and (CharInfo.UnitLevel >= Octo_ToDoVars.config.LevelToShow) and (CharInfo.UnitLevel <= Octo_ToDoVars.config.LevelToShowMAX))
			or (curGUID == CharInfo.GUID) then
			sorted[#sorted+1] = CharInfo
			if CharInfo.Shadowland[2] >= 1000 or CharInfo.Shadowland[4] >= 1000 or CharInfo.Shadowland[6] >= 1000 or CharInfo.Shadowland[8] >= 1000 then
				TotalTransAnima = TotalTransAnima +
				math.floor(CharInfo.Shadowland[2]/1000)*1000 +
				math.floor(CharInfo.Shadowland[4]/1000)*1000 +
				math.floor(CharInfo.Shadowland[6]/1000)*1000 +
				math.floor(CharInfo.Shadowland[8]/1000)*1000
			end
			if CharInfo.CurrencyID[2594] >= 500 then
				TotalTransParacausalFlakes = TotalTransParacausalFlakes + math.floor(CharInfo.CurrencyID[2594]/500)*500
			end
		end
	end
	sort(sorted, function(a, b)
			if a and b then
				return
				a.curServer < b.curServer or a.curServer == b.curServer
				and
				a.UnitLevel < b.UnitLevel or a.UnitLevel == b.UnitLevel
				and
				a.UnitXPPercent < b.UnitXPPercent or a.UnitXPPercent == b.UnitXPPercent
				and
				a.avgItemLevel < b.avgItemLevel or a.avgItemLevel == b.avgItemLevel
				and
				b.Name < a.Name
			end
	end)
	for i, CharInfo in pairs(sorted) do
		local classcolor = CreateColor(CharInfo.classColor.r, CharInfo.classColor.g, CharInfo.classColor.b)
		local curCharGUID = CharInfo.GUID
		-- if CharInfo.classFilename == "DEATHKNIGHT" then
		-- 	if not MEME_FRAME then
		-- 		MEME_FRAME = CreateFrame("Frame")
		-- 		MEME_FRAME:Hide()
		-- 	end
		-- 	if not MEME_FRAME[curCharGUID] then
		-- 		MEME_FRAME[curCharGUID] = CreateFrame("Frame", "MEME_FRAME[curCharGUID]"..curCharGUID, Octo_ToDo_FIRST_Frame_Main_Frame, "BackdropTemplate")
		-- 		MEME_FRAME[curCharGUID]:SetPoint("BOTTOM", Octo_ToDo_FIRST_Frame_Char_Frame, "TOP", 0, 0)
		-- 		MEME_FRAME[curCharGUID]:SetSize(E.Octo_Globals.curWidth*E.Octo_Globals.scale, E.Octo_Globals.curHeight/2*E.Octo_Globals.scale)
		-- 		MEME_FRAME[curCharGUID]:SetFrameStrata("LOW")
		-- 		MEME_FRAME[curCharGUID]:SetBackdrop({
		-- 				bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- 				edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		-- 				edgeSize = 1,
		-- 		})
		-- 		MEME_FRAME[curCharGUID]:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
		-- 		MEME_FRAME[curCharGUID]:SetBackdropBorderColor(0, 0, 0, 1)
		-- 		MEME_FRAME[curCharGUID].icon = MEME_FRAME[curCharGUID]:CreateTexture(nil, "ARTWORK")
		-- 		MEME_FRAME[curCharGUID].icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Melli.tga")
		-- 		MEME_FRAME[curCharGUID].icon:SetAllPoints(MEME_FRAME[curCharGUID])
		-- 		MEME_FRAME[curCharGUID]:Show()
		-- 		local model = CreateFrame("PlayerModel", "model"..curCharGUID, MEME_FRAME[curCharGUID])
		-- 		model:SetPoint("BOTTOM", Octo_ToDo_FIRST_Frame_Char_Frame, "TOP", 0, 0)
		-- 		model:SetSize(220, 220)
		-- 		-- model:SetPoint("TOPLEFT", 25, 20)
		-- 		model:SetDisplayInfo(39490) --
		-- 		model:SetRotation(.4)
		-- 		model:PlayAnimKit(1371)
		-- 		-- 39490 chaika
		-- 		-- 63509 arrow
		-- 		-- 49585 garrosh
		-- 		-- 55907 juk
		-- 		-- [65309] = "creature/dhmaletank/dhmaletank.m2",
		-- 		-- [66406] = "creature/dhmaletank/dhmaletank.m2",
		-- 		-- [68671] = "creature/dhmaletank/dhmaletank.m2",
		-- 		-- [70373] = "creature/dhmaletank/dhmaletank.m2",
		-- 						-- murloccostume.m2 21723
		-- 	end
		-- end
		if not Octo_ToDo_FIRST_Frame_Main_Frame[curCharGUID] then
			Octo_ToDo_FIRST_Frame_Main_Frame[curCharGUID] = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."Octo_ToDo_FIRST_Frame_Main_Frame[curCharGUID]", Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild, "BackdropTemplate")
			Octo_ToDo_FIRST_Frame_Char_Frame = Octo_ToDo_FIRST_Frame_Main_Frame[curCharGUID]
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("BOTTOM", 0, 0)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG = Octo_ToDo_FIRST_Frame_Char_Frame:CreateTexture(nil, "BACKGROUND")
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:Hide()
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetPoint("TOPLEFT", 0, -E.Octo_Globals.curHeight) -- ФОН ЗАЛОГИНЕНОГО ПЕРСОНАЖА (рога - желтый)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetPoint("BOTTOMRIGHT", 0, 0)
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetColorTexture(r, g, b, 1)
			for i = 1, #OctoTable_func_otrisovka_FIRST do
				CharInfo.GUID = curCharGUID
				local CF = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID().."CF"..i, Octo_ToDo_FIRST_Frame_Char_Frame)
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i] = CF
				CF.index = i
				CF:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
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
				Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i.."BG"]:SetColorTexture(r, g, b, 0)
				CF.CL = CL
			end
		else
			Octo_ToDo_FIRST_Frame_Char_Frame = Octo_ToDo_FIRST_Frame_Main_Frame[curCharGUID]
		end
		Octo_ToDo_FIRST_Frame_Char_Frame:SetSize(E.Octo_Globals.curWidth, E.Octo_Globals.curHeight)
		if #Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames == 0 then
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("TOPRIGHT", 0, 0)
		else
			Octo_ToDo_FIRST_Frame_Char_Frame:SetPoint("TOPRIGHT", Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames], "TOPLEFT", 0, 0)
		end
		Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames[#Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames + 1] = Octo_ToDo_FIRST_Frame_Char_Frame
		if curGUID == curCharGUID then
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:Show()
			Octo_ToDo_FIRST_Frame_Char_Frame.BG:SetAlpha(E.Octo_Globals.BGALPHA*2)
		end
		for i = 1, #OctoTable_func_otrisovka_FIRST do
			local TEXTLEFT = Octo_ToDo_FIRST_Frame_Main_Frame["TextLeft"..i]
			local TEXTCENT = Octo_ToDo_FIRST_Frame_Char_Frame["CenterLines"..i]
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
		--
		if not Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton then
			Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton = CreateFrame("Frame")
			Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton:Hide()
		end
		if not Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID] then
			Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID] = CreateFrame("BUTTON", "Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]"..i, Octo_ToDo_FIRST_Frame_Char_Frame, "BackDropTemplate")
		end
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetSize(16, 10)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetPoint("TOP", Octo_ToDo_FIRST_Frame_Char_Frame, "BOTTOM", 0, -4)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetBackdrop({
		edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
		edgeSize = 1,
		})
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetBackdropBorderColor(1, 0, 0, 0)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetScript("OnEnter", function(self)
		self:SetBackdropBorderColor(1, 0, 0, 1)
		self.icon:SetVertexColor(1, 0, 0, 1)
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
		GameTooltip:ClearLines()
		GameTooltip:SetText(DELETE)
		GameTooltip:Show()
		end)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetScript("OnLeave", function(self)
		self:SetBackdropBorderColor(1, 0, 0, 0)
		self.icon:SetVertexColor(1, 1, 1, 1)
		GameTooltip:ClearLines()
		GameTooltip:Hide()
		end)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetScript("OnMouseDown", function(self)
		self:SetBackdropBorderColor(1, 0, 0, .5)
		self.icon:SetVertexColor(1, 0, 0, .5)
		end)
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:SetScript("OnClick", function()
		Octo_ToDoDeleteChar(curCharGUID)
		end)
		local t = Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID]:CreateTexture(nil, "BACKGROUND")
		Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID].icon = t
		t:SetTexture("Interface\\Addons\\"..GlobalAddonName.."\\Media\\closeWHITE.tga")
		t:SetAllPoints(Octo_ToDo_FIRST_Frame_Char_FrameDeleteButton[curCharGUID])
	end -- if
	local curAltFrameWidth = #Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames * E.Octo_Globals.curWidth/2
	local width = curAltFrameWidth*2+E.Octo_Globals.curWidthTitle
	local height = E.Octo_Globals.curHeight*(#OctoTable_func_otrisovka_FIRST)
	Octo_ToDo_FIRST_Frame_Main_Frame.scrollChild:SetSize(width, height)
	if height > E.Octo_Globals.Addon_Height then
		height = E.Octo_Globals.Addon_Height
		Octo_ToDo_FIRST_Frame_Main_Frame.ScrollBar:Show()
	else
		Octo_ToDo_FIRST_Frame_Main_Frame.ScrollBar:Hide()
	end
	Octo_ToDo_FIRST_Frame_Main_Frame:SetSize(width, height) -- ТУТ БЫЛА ЗАЛУПА
end
function Octo_ToDoDeleteChar(curGUID)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Octo_ToDoDeleteChar".."|r")
	end
	Octo_ToDoLevels[curGUID] = nil
	for X, Y in pairs(Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames) do
		if Y == Octo_ToDo_FIRST_Frame_Main_Frame[curGUID] then
			Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames[X].parent = nil
			Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames[X]:Hide()
			Octo_ToDo_FIRST_Frame_Main_Frame.AllCharFrames[X] = nil
		end
	end
	Octo_ToDo_FIRST_AddDataToAltFrame()
end
function Octo_ToDo_FIRST_OnEvent(self, event, ...)
	-- if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
	-- 	if not InCombatLockdown() then
	-- 		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."Octo_ToDo_FIRST_OnEvent".."|r")
	-- 	else
	-- 		ChatFrame1:AddMessage(E.Octo_Globals.Gray_Color.."Octo_ToDo_FIRST_OnEvent".."|r")
	-- 	end
	-- end
	if Octo_ToDoVars.config.Octo_debug_Event_FIRST == true then
		if not InCombatLockdown() then
			ChatFrame1:AddMessage(E.Octo_Globals.Event_Color..event.."|r")
		else
			ChatFrame1:AddMessage(E.Octo_Globals.Gray_Color..event.."|r")
		end
	end
	if (event == "VARIABLES_LOADED") and not InCombatLockdown() then
		if Octo_ToDo_SmartCollectNEW2 == nil then Octo_ToDo_SmartCollectNEW2 = {} end
		if Octo_Achi_MAIN == nil then Octo_Achi_MAIN = {} end
		if Octo_ToDoLevels == nil then Octo_ToDoLevels = {} end
		if Octo_ToDoVars == nil then Octo_ToDoVars = {} end
		if Octo_ToDoVars.config == nil then Octo_ToDoVars.config = {} end
		if Octo_ToDoArtifact == nil then Octo_ToDoArtifact = {} end
		if Octo_ToDoOther == nil then Octo_ToDoOther = {} end
		-- if Octo_ToDoOther.default_bindings_set == nil then
		-- E.Octo_Func.HandleDefaultBindings("Quick Link (wowhead.com)", "CTRL-C")
		-- E.Octo_Func.HandleDefaultBindings("Quick Link (raider.io)", "CTRL-SHIFT-C")
		-- SaveBindings(GetCurrentBindingSet())
		-- Octo_ToDoOther.default_bindings_set = true
		-- end
		if Octo_ToDoTransmog == nil then Octo_ToDoTransmog = {} end
		if Octo_ToDoVars.config.reputation == nil then Octo_ToDoVars.config.reputation = {} end
		for k, repID in ipairs(E.Octo_Table.OctoTable_reputation_ALL) do
			Octo_ToDoVars.config.reputation[repID] = Octo_ToDoVars.config.reputation[repID] or false
		end
		if Octo_ToDoVars.config.CVar == nil then Octo_ToDoVars.config.CVar = false end
		if Octo_ToDoVars.config.SORTING == nil then Octo_ToDoVars.config.SORTING = false end
		if Octo_ToDoVars.config.InputDelete == nil then Octo_ToDoVars.config.InputDelete = true end
		if Octo_ToDoVars.config.UsableItems == nil then Octo_ToDoVars.config.UsableItems = true end
		if Octo_ToDoVars.config.AutoOpen == nil then Octo_ToDoVars.config.AutoOpen = true end
		if Octo_ToDoVars.config.AutoGossip == nil then Octo_ToDoVars.config.AutoGossip = true end
		if Octo_ToDoVars.config.Hide_ObjectivesInInstance == nil then Octo_ToDoVars.config.Hide_ObjectivesInInstance = false end
		if Octo_ToDoVars.config.ChallengesKeystoneFrame == nil then Octo_ToDoVars.config.ChallengesKeystoneFrame = false end
		if Octo_ToDoVars.config.TalkingHeadFrame == nil then Octo_ToDoVars.config.TalkingHeadFrame = true end
		if Octo_ToDoVars.config.LootFrame == nil then Octo_ToDoVars.config.LootFrame = false end
		if Octo_ToDoVars.config.HideZoneText == nil then Octo_ToDoVars.config.HideZoneText = true end
		if Octo_ToDoVars.config.Covenant == nil then Octo_ToDoVars.config.Covenant = true end
		if Octo_ToDoVars.config.UIErrorsFramePosition == nil then Octo_ToDoVars.config.UIErrorsFramePosition = true end
		if Octo_ToDoVars.config.RaidBossEmoteFrame == nil then Octo_ToDoVars.config.RaidBossEmoteFrame = true end
		if Octo_ToDoVars.config.CinematicCanceler == nil then Octo_ToDoVars.config.CinematicCanceler = true end
		if Octo_ToDoVars.config.BossBanner == nil then Octo_ToDoVars.config.BossBanner = true end
		if Octo_ToDoVars.config.AnotherAddonsCasual == nil then Octo_ToDoVars.config.AnotherAddonsCasual = false end
		if Octo_ToDoVars.config.StaticPopup1Button1 == nil then Octo_ToDoVars.config.StaticPopup1Button1 = false end
		if Octo_ToDoVars.config.AnotherAddonsRAID == nil then Octo_ToDoVars.config.AnotherAddonsRAID = false end
		if Octo_ToDoVars.config.ClearChat == nil then Octo_ToDoVars.config.ClearChat = false end
		if Octo_ToDoVars.config.ShowOnlyCurrentRealm == nil then Octo_ToDoVars.config.ShowOnlyCurrentRealm = true end
		if Octo_ToDoVars.config.AutoSellGrey == nil then Octo_ToDoVars.config.AutoSellGrey = true end
		if Octo_ToDoVars.config.AutoRepair == nil then Octo_ToDoVars.config.AutoRepair = true end
		if Octo_ToDoVars.config.Auto_Screenshot == nil then Octo_ToDoVars.config.Auto_Screenshot = false end
		if Octo_ToDoVars.config.HideErrorMessages == nil then Octo_ToDoVars.config.HideErrorMessages = true end
		if Octo_ToDoVars.config.SellFrame == nil then Octo_ToDoVars.config.SellFrame = false end
		if Octo_ToDoVars.config.AutoTurnQuests == nil then Octo_ToDoVars.config.AutoTurnQuests = false end
		if Octo_ToDoVars.config.TrivialQuests == nil then Octo_ToDoVars.config.TrivialQuests = false end
		if Octo_ToDoVars.config.RepeatableQuests == nil then Octo_ToDoVars.config.RepeatableQuests = false end
		if Octo_ToDoVars.config.GlobalFadePersist == nil then Octo_ToDoVars.config.GlobalFadePersist = false end
		if Octo_ToDoVars.config.LevelToShow == nil then Octo_ToDoVars.config.LevelToShow = 60 end
		if Octo_ToDoVars.config.LevelToShowMAX == nil then Octo_ToDoVars.config.LevelToShowMAX = 70 end
		if Octo_ToDoVars.config.itemLevelToShow == nil then Octo_ToDoVars.config.itemLevelToShow = 100 end
		if Octo_ToDoVars.config.ExpansionToShow == nil then Octo_ToDoVars.config.ExpansionToShow = tonumber(GetBuildInfo():match("(.-)%.")) or 1 end
		if Octo_ToDoVars.config.AchievementToShow == nil then Octo_ToDoVars.config.AchievementToShow = 92 end
		if Octo_ToDoVars.config.AchievementShowCompleted == nil then Octo_ToDoVars.config.AchievementShowCompleted = true end
		if Octo_ToDoVars.config.ShowEvents == nil then Octo_ToDoVars.config.ShowEvents = true end
		if Octo_ToDoVars.config.ShowPVPEvents == nil then Octo_ToDoVars.config.ShowPVPEvents = false end
		if Octo_ToDoVars.config.ShowHoliday == nil then Octo_ToDoVars.config.ShowHoliday = true end
		if Octo_ToDoVars.config.ShowTransmogrification == nil then Octo_ToDoVars.config.ShowTransmogrification = false end
		if Octo_ToDoVars.config.ShowSkips == nil then Octo_ToDoVars.config.ShowSkips = false end
		if Octo_ToDoVars.config.InstanceTracker == nil then Octo_ToDoVars.config.InstanceTracker = true end
		if Octo_ToDoVars.config.ShowCurrency == nil then Octo_ToDoVars.config.ShowCurrency = true end
		if Octo_ToDoVars.config.ShowReputation == nil then Octo_ToDoVars.config.ShowReputation = false end
		if Octo_ToDoVars.config.ShowQuests == nil then Octo_ToDoVars.config.ShowQuests = true end
		if Octo_ToDoVars.config.ShowItems == nil then Octo_ToDoVars.config.ShowItems = false end
		if Octo_ToDoVars.config.ShowProfessions == nil then Octo_ToDoVars.config.ShowProfessions = false end
		if Octo_ToDoVars.config.ShowMoney == nil then Octo_ToDoVars.config.ShowMoney = true end
		if Octo_ToDoVars.config.ShowItemLevel == nil then Octo_ToDoVars.config.ShowItemLevel = true end
		if Octo_ToDoVars.config.ShowLogoutTime == nil then Octo_ToDoVars.config.ShowLogoutTime = true end
		if Octo_ToDoVars.config.AidingtheAccord == nil then Octo_ToDoVars.config.AidingtheAccord = false end
		if Octo_ToDoVars.config.CommunityFeast == nil then Octo_ToDoVars.config.CommunityFeast = true end
		if Octo_ToDoVars.config.ResearchersUnderFire == nil then Octo_ToDoVars.config.ResearchersUnderFire = true end
		if Octo_ToDoVars.config.Dreamsurges == nil then Octo_ToDoVars.config.Dreamsurges = false end
		if Octo_ToDoVars.config.TimeRift == nil then Octo_ToDoVars.config.TimeRift = false end
		if Octo_ToDoVars.config.Portals == nil then Octo_ToDoVars.config.Portals = false end
		if Octo_ToDoVars.config.Achievements == nil then Octo_ToDoVars.config.Achievements = false end
		if Octo_ToDoVars.config.curHeight == nil then Octo_ToDoVars.config.curHeight = 20 end
		if Octo_ToDoVars.config.curHeight ~= nil then E.Octo_Globals.curHeight = Octo_ToDoVars.config.curHeight end
		if Octo_ToDoVars.config.Addon_Height == nil then Octo_ToDoVars.config.Addon_Height = 400 end
		if Octo_ToDoVars.config.Addon_Height ~= nil then E.Octo_Globals.Addon_Height = Octo_ToDoVars.config.Addon_Height end
		if Octo_ToDoVars.config.curWidth == nil then Octo_ToDoVars.config.curWidth = 96 end
		if Octo_ToDoVars.config.curWidth ~= nil then E.Octo_Globals.curWidth = Octo_ToDoVars.config.curWidth end
		if Octo_ToDoVars.config.curWidthTitle == nil then Octo_ToDoVars.config.curWidthTitle = 200 end
		if Octo_ToDoVars.config.curWidthTitle ~= nil then E.Octo_Globals.curWidthTitle = Octo_ToDoVars.config.curWidthTitle end
		if Octo_ToDoVars.config.curWidthTitleAchievement == nil then Octo_ToDoVars.config.curWidthTitleAchievement = 300 end
		if Octo_ToDoVars.config.curWidthTitleAchievement ~= nil then E.Octo_Globals.curWidthTitleAchievement = Octo_ToDoVars.config.curWidthTitleAchievement end
		if Octo_ToDoVars.config.Octo_debug_Function_FIRST == nil then Octo_ToDoVars.config.Octo_debug_Function_FIRST = false end
		if Octo_ToDoVars.config.Octo_debug_Function_FIRST ~= nil then E.Octo_Globals.Octo_debug_Function_FIRST = Octo_ToDoVars.config.Octo_debug_Function_FIRST end
		if Octo_ToDoVars.config.Octo_debug_Event_FIRST == nil then Octo_ToDoVars.config.Octo_debug_Event_FIRST = false end
		if Octo_ToDoVars.config.Octo_debug_Event_FIRST ~= nil then E.Octo_Globals.Octo_debug_Event_FIRST = Octo_ToDoVars.config.Octo_debug_Event_FIRST end
		if Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST == nil then Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST = false end
		if Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST ~= nil then E.Octo_Globals.Octo_debug_BUTTONS_FIRST = Octo_ToDoVars.config.Octo_debug_BUTTONS_FIRST end
		if Octo_ToDoVars.config.Octo_debug_Function_SECOND == nil then Octo_ToDoVars.config.Octo_debug_Function_SECOND = false end
		if Octo_ToDoVars.config.Octo_debug_Function_SECOND ~= nil then E.Octo_Globals.Octo_debug_Function_SECOND = Octo_ToDoVars.config.Octo_debug_Function_SECOND end
		if Octo_ToDoVars.config.Octo_debug_Event_SECOND == nil then Octo_ToDoVars.config.Octo_debug_Event_SECOND = false end
		if Octo_ToDoVars.config.Octo_debug_Event_SECOND ~= nil then E.Octo_Globals.Octo_debug_Event_SECOND = Octo_ToDoVars.config.Octo_debug_Event_SECOND end
		if Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND == nil then Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND = false end
		if Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND ~= nil then E.Octo_Globals.Octo_debug_BUTTONS_SECOND = Octo_ToDoVars.config.Octo_debug_BUTTONS_SECOND end
		if Octo_ToDo_SmartCollectNEW2 == nil then Octo_ToDo_SmartCollectNEW2 = {} end
		if Octo_ToDo_SmartCollectNEW2.LFGInstance == nil then Octo_ToDo_SmartCollectNEW2.LFGInstance = {} end
		if Octo_ToDo_SmartCollectNEW2.Holiday == nil then Octo_ToDo_SmartCollectNEW2.Holiday = {} end
		if Octo_ToDo_SmartCollectNEW2.Holiday.Active == nil then Octo_ToDo_SmartCollectNEW2.Holiday.Active = {} end
		if Octo_ToDo_SmartCollectNEW2.Holiday.Collect == nil then Octo_ToDo_SmartCollectNEW2.Holiday.Collect = {} end
		if Octo_ToDoOther.prefix == nil then Octo_ToDoOther.prefix = 1 end
		if Octo_ToDoOther.TokenPrice == nil then Octo_ToDoOther.TokenPrice = 0 end
		for _, classFilename in pairs(E.Octo_Table.OctoTable_EnglishClasses) do
			Octo_ToDoTransmog[classFilename] = Octo_ToDoTransmog[classFilename] or {}
			for _, itemType in pairs (E.Octo_Globals.TransmogCollectionType) do
				Octo_ToDoTransmog[classFilename][itemType] = Octo_ToDoTransmog[classFilename][itemType] or {}
				for _, difficultyName in pairs(E.Octo_Globals.difficultyName) do
					Octo_ToDoTransmog[classFilename][itemType][difficultyName] = Octo_ToDoTransmog[classFilename][itemType][difficultyName] or "-"
				end
			end
		end
		for classFilename, v in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA) do
			for itemID in pairs(E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename]) do
				local artifactData = E.Octo_Globals.CLASS_ARTIFACT_DATA[classFilename][itemID]
				local _, specNameLocale, _, specIcon = GetSpecializationInfoByID(artifactData.specID)
				for index, data in pairs(artifactData.sets) do
					local appearanceID = data.appearanceID
					local sourceID = data.sourceID
					local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
					local visualID = sourceInfo.visualID
					if Octo_ToDoArtifact == nil then
						Octo_ToDoArtifact = {}
					end
					if Octo_ToDoArtifact[classFilename] == nil then
						Octo_ToDoArtifact[classFilename] = {}
					end
					if Octo_ToDoArtifact[classFilename][itemID] == nil then
						Octo_ToDoArtifact[classFilename][itemID] = {}
					end
					if Octo_ToDoArtifact[classFilename][itemID][visualID] == nil then
						Octo_ToDoArtifact[classFilename][itemID][visualID] = {}
					end
					setmetatable(Octo_ToDoArtifact[classFilename][itemID][visualID], Meta_Table_0)
				end
			end
		end
		-- for k, v in pairs(E.Octo_Globals.TransmogCollectionType) do
		-- end
		O_otrisovka_FIRST()
		for i, func in ipairs(E.Octo_Globals.modules) do
			func()
		end
		local MinimapName = GlobalAddonName.."Octo_ToDo_FIRST_Minimap"
		local ldb_icon = ldb:NewDataObject(MinimapName, {
				type = "data source",
				text = MinimapName,
				icon = AddonTexture_FIRST,
				OnClick = function(_, button)
					if button == "LeftButton" then
						if not InCombatLockdown() then
							-- if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
							--     Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
							-- end
							if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
								Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
							end
							Octo_ToDo_FIRST_Frame_Main_Frame:SetShown(not Octo_ToDo_FIRST_Frame_Main_Frame:IsShown())
							Collect_ALL_PlayerInfo()
							Collect_All_Currency()
							Collect_ALL_GreatVault()
							Collect_ALL_ItemLevel()
							Collect_ALL_ItemsInBag()
							Collect_ALL_KnownSpell()
							Collect_ALL_Locations()
							Collect_ALL_LoginTime()
							Collect_ALL_Mail()
							-- Collect_ALL_MoneyOnLogin()
							Collect_ALL_MoneyUpdate()
							Collect_All_Professions()
							Collect_ALL_PVPRaitings()
							Collect_All_Quests()
							Collect_All_Quest_Tooltip()
							Collect_All_Reputations()
							Collect_All_Legion_Transmoge()
							Collect_ALL_UNIVERSALQuestUpdate()
							Collect_BfA_Azerite()
							Collect_BfA_Cloaklvl()
							Collect_BfA_Island()
							Collect_BfA_QuestsBounties()
							Collect_SL_CovenantAnima()
							Collect_All_journalInstance()
							Collect_AberrusTransmog()
							Octo_ToDo_FIRST_AddDataToAltFrame()
						end
					else
						if SettingsPanel:IsVisible() and self:IsVisible() then
							HideUIPanel(SettingsPanel)
						else
							Settings.OpenToCategory(AddonTitle, true)
						end
					end
				end,
				OnEnter = function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
					-- GameTooltip_SetTitle(GameTooltip, AddonTitle.." "..E.Octo_Globals.LightGray_Color..AddonVersion.."|r")
					GameTooltip_SetTitle(GameTooltip, E.Octo_Func.func_Gradient(GlobalAddonName, E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color).."|n".."ПКМ - Настройки")
					GameTooltip:Show()
				end,
				OnLeave = function()
					GameTooltip:Hide()
				end,
		})
		Octo_ToDoVars.minimap_FIRST = Octo_ToDoVars.minimap_FIRST or {}
		Octo_ToDoVars.minimap_FIRST.minimapPos = Octo_ToDoVars.minimap_FIRST.minimapPos or 244
		Octo_ToDoVars.config.AddonVersion = tonumber(AddonVersion)
		ldbi:Register(MinimapName, ldb_icon, Octo_ToDoVars.minimap_FIRST)
		ldbi:Show(MinimapName)
	end
	if (event == "PLAYER_LOGIN") and not InCombatLockdown() then
		local curGUID = UnitGUID("PLAYER")
		Octo_ToDoLevels[curGUID] = Octo_ToDoLevels[curGUID] or {}
		for k, CharInfo in pairs(Octo_ToDoLevels) do
			checkCharInfo(CharInfo)
		end
		Collect_AberrusTransmog()
		Collect_ALL_PlayerInfo()
		Collect_All_Currency()
		Collect_ALL_GreatVault()
		Collect_All_Holiday()
		Collect_ALL_ItemLevel()
		Collect_ALL_ItemsInBag()
		Collect_ALL_KnownSpell()
		Collect_ALL_Locations()
		Collect_ALL_LoginTime()
		Collect_ALL_Mail()
		Collect_ALL_MoneyOnLogin()
		Collect_ALL_MoneyUpdate()
		Collect_All_Professions()
		Collect_ALL_PVPRaitings()
		Collect_All_Quests()
		Collect_All_Quest_Tooltip()
		Collect_All_Reputations()
		Collect_All_Legion_Transmoge()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		Collect_BfA_Island()
		Collect_BfA_QuestsBounties()
		Collect_SL_CovenantAnima()
		Collect_All_journalInstance()
		Octo_ToDo_FIRST_CreateAltFrame()
		Octo_ToDo_FIRST_AddDataToAltFrame()
		Collect_Player_Level()
		C_Timer.After(5, function()
				if Octo_ToDoVars.config.AnotherAddonsRAID then
					Octo_ToDoVars.config.AnotherAddonsRAID = false
				end
		end)
	end
	if (event == "TOKEN_MARKET_PRICE_UPDATED") and not InCombatLockdown() then
		Collect_Token_Price()
	end
	if (event == "CHAT_MSG_SKILL" or event == "CHAT_MSG_SYSTEM") and not InCombatLockdown() then -- event == "TRAINER_UPDATE" or
		Collect_All_Professions()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	-- if (event == "UI_INFO_MESSAGE") and not InCombatLockdown() then
	-- 	Collect_ALL_PlayerInfo()
	-- 	if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	-- end
	if event == "PLAYER_XP_UPDATE" then
-- PLAYER_ENTERING_WORLD,
-- QUEST_LOG_UPDATE,
-- UNIT_QUEST_LOG_CHANGED,
-- PLAYER_XP_UPDATE,
-- PLAYER_LEVEL_UP,
-- UPDATE_EXHAUSTION,
-- UPDATE_EXPANSION_LEVEL,
-- TIME_PLAYED_MSG,
-- ENABLE_XP_GAIN,
-- DISABLE_XP_GAIN
		Collect_Player_Level()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if event == "PLAYER_STARTED_MOVING" and not InCombatLockdown() then
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_Frame_Main_Frame:SetAlpha(E.Octo_Globals.BGALPHA*5) end
	end
	if event == "PLAYER_STOPPED_MOVING" then
		if Octo_ToDo_FIRST_Frame_Main_Frame then Octo_ToDo_FIRST_Frame_Main_Frame:SetAlpha(1) end
	end
	if (event == "COVENANT_CHOSEN" or event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED") and not InCombatLockdown() then
		C_Timer.After(1, function()
				Collect_SL_CovenantAnima()
		end)
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "QUEST_LOG_UPDATE") and not InCombatLockdown() then
		Collect_All_Quests()
		Collect_All_Quest_Tooltip()
		Collect_BfA_QuestsBounties()
		Collect_ALL_UNIVERSALQuestUpdate()
		Collect_BfA_Island()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_MONEY") and not InCombatLockdown() then
		Collect_ALL_MoneyUpdate()
		Collect_Token_Price()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "CURRENCY_DISPLAY_UPDATE") and not InCombatLockdown() then
		Collect_All_Currency()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_EQUIPMENT_CHANGED") and not InCombatLockdown() then
		Collect_ALL_ItemLevel()
		Collect_BfA_Cloaklvl()
		Collect_BfA_Azerite()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_LOGOUT") and not InCombatLockdown() then
		Collect_ALL_PVPRaitings()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_LEAVING_WORLD") and not InCombatLockdown() then
		Collect_ALL_GreatVault()
		Collect_ALL_LoginTime()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_ENTERING_WORLD") and not InCombatLockdown() then
		Collect_Token_Price()
		Collect_ALL_PVPRaitings()
		Collect_ALL_LoginTime()
		Collect_ALL_ItemsInBag()
		Collect_ALL_Locations()
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		Collect_All_journalInstance()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "ZONE_CHANGED_NEW_AREA" or event == "ITEM_COUNT_CHANGED" or event == "MAIL_SEND_SUCCESS") and not InCombatLockdown() then
		-- or event == "NEW_TOY_ADDED"
		-- or event == "PLAYER_REGEN_ENABLED"
		-- or event == "PLAYER_MONEY"
		-- or event == "MERCHANT_SHOW"
		-- or event == "MERCHANT_CLOSED"
		-- or event == "MAIL_INBOX_UPDATE"
		-- or event == "MAIL_SHOW"
		-- or event == "UPDATE_PENDING_MAIL"
		-- or event == "UI_INFO_MESSAGE"
		-- or event == "HEARTHSTONE_BOUND"
		-- or event == "SPELLS_CHANGED"
		-- or event == "ENCOUNTER_END"
		-- or event == "COVENANT_CHOSEN"
		-- or event == "COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED"
		-- or event == "ITEM_PUSH"
		-- or event == "BAG_NEW_ITEMS_UPDATED"
		-- or event == "ITEM_LOCKED"
		C_Timer.After(5, function()
				if not InCombatLockdown() then
					Collect_ALL_ItemsInBag()
					if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
				end
		end)
	end
	if (event == "ITEM_CHANGED" or event == "TRANSMOG_COLLECTION_SOURCE_ADDED") and not InCombatLockdown() then
		Collect_AberrusTransmog()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "HEARTHSTONE_BOUND" or event == "ZONE_CHANGED_NEW_AREA") and not InCombatLockdown() then
		Collect_ALL_Locations()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "SPELLS_CHANGED") and not InCombatLockdown() then
		Collect_ALL_KnownSpell()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "AZERITE_ITEM_EXPERIENCE_CHANGED") and not InCombatLockdown() then
		Collect_BfA_Azerite()
		Collect_BfA_Cloaklvl()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	if (event == "PLAYER_ENTERING_WORLD" or event == "MAIL_INBOX_UPDATE" or event == "MAIL_SHOW" or event == "UPDATE_PENDING_MAIL") and not InCombatLockdown() then
		Collect_ALL_Mail()
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	end
	-- if (event == "PLAYER_ENTERING_WORLD" or event == "CALENDAR_OPEN_EVENT") and not InCombatLockdown() then
	-- -- or event == "LFG_COMPLETION_REWARD"
	-- -- or event == "LFG_UPDATE_RANDOM_INFO"
	-- -- or event == "CALENDAR_UPDATE_EVENT_LIST"
	-- -- or event == "CALENDAR_UPDATE_EVENT"
	-- -- or event == "CALENDAR_CLOSE_EVENT"
	-- -- or event == "CALENDAR_NEW_EVENT"
	-- 	Collect_All_Holiday()
	-- 	if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
	-- end
	if event == "PLAYER_REGEN_DISABLED" or InCombatLockdown() then
		if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then
			Octo_ToDo_FIRST_Frame_Main_Frame:Hide()
		end
	end
	if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM") and not InCombatLockdown() then
		E.Octo_Func.PlaySoundFile_whisper(...)
	end
	if (event == "READY_CHECK") and not InCombatLockdown() then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Other\\Readycheck.ogg", "Master")
	end
	if event == "ENCOUNTER_END" then
		-- RequestRaidInfo()
		C_Timer.After(1, function()
				Collect_All_journalInstance()
				if Octo_ToDo_FIRST_Frame_Main_Frame and Octo_ToDo_FIRST_Frame_Main_Frame:IsShown() then Octo_ToDo_FIRST_AddDataToAltFrame() end
		end)
	end
end
Octo_ToDo_FIRST_OnLoad()
SLASH_Octo1, SLASH_Octo2 = "/Octo", "/OctoDF"
function SlashCmdList.Octo(msg, editBox)
	if Octo_ToDoVars.config.Octo_debug_Function_FIRST == true then
		ChatFrame1:AddMessage(E.Octo_Globals.Function_Color.."SlashCmdList.Octo".."|r")
	end
	if not InCombatLockdown() then
		-- if Octo_ToDo_FIRST_Frame_Main_FramePIZDA and Octo_ToDo_FIRST_Frame_Main_FramePIZDA:IsShown() then
		--     Octo_ToDo_FIRST_Frame_Main_FramePIZDA:Hide()
		-- end
		if Octo_ToDo_SECOND_Frame_Main_FramePIZDA and Octo_ToDo_SECOND_Frame_Main_FramePIZDA:IsShown() then
			Octo_ToDo_SECOND_Frame_Main_FramePIZDA:Hide()
		end
		Octo_ToDo_FIRST_Frame_Main_Frame:SetShown(not Octo_ToDo_FIRST_Frame_Main_Frame:IsShown())
		Octo_ToDo_FIRST_AddDataToAltFrame()
	end
end
SLASH_GSEARCH1 = "/gsearch"
SlashCmdList.GSEARCH = function(msg)
	print("SEARCH:", msg)
	for i, n in pairs(_G) do
		if type(n) == "string" and n:find(msg) then
			print(i, n)
		end
	end
end
SlashCmdList["RELOAD"] = ReloadUI
SLASH_RELOAD1 = "/rl"