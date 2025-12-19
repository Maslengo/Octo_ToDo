local GlobalAddonName, E =...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
----------------------------------------------------------------
local utf8len, utf8sub, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8upper, string.utf8lower
local LibStub = LibStub
local strsplit = strsplit
local GetClassColor = GetClassColor or C_ClassColor.GetClassColor
local DoesAddOnExist = DoesAddOnExist or C_AddOns.DoesAddOnExist
local EnableAddOn = EnableAddOn or C_AddOns.EnableAddOn
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
local LoadAddOn = LoadAddOn or C_AddOns.LoadAddOn
local GetItemCooldown = GetItemCooldown or C_Item.GetItemCooldown
local GetItemCount = GetItemCount or C_Item.GetItemCount
local GetItemIconByID = GetItemIconByID or C_Item.GetItemIconByID
local GetItemInfo = GetItemInfo or C_Item.GetItemInfo
local GetItemNameByID = GetItemNameByID or C_Item.GetItemNameByID
local GetItemQualityByID = GetItemQualityByID or C_Item.GetItemQualityByID
local GetItemQualityColor = GetItemQualityColor or C_Item.GetItemQualityColor
local IsAnimaItemByID = IsAnimaItemByID or C_Item.IsAnimaItemByID
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo or C_Item.GetDetailedItemLevelInfo
local GetSpellCooldown = GetSpellCooldown or C_Spell.GetSpellCooldown
local GetSpellName = GetSpellName or C_Spell.GetSpellName
local GetSpellSubtext = GetSpellSubtext or C_Spell.GetSpellSubtext
local GetSpellTexture = GetSpellTexture or C_Spell.GetSpellTexture
local GetSpellCharges = GetSpellCharges or C_Spell.GetSpellCharges
local IsSpellKnown = IsSpellKnown
local GetCurrencyInfo = GetCurrencyInfo or C_CurrencyInfo.GetCurrencyInfo
local IsAccountWideCurrency = IsAccountWideCurrency or C_CurrencyInfo.IsAccountWideCurrency
local IsAccountTransferableCurrency = IsAccountTransferableCurrency or C_CurrencyInfo.IsAccountTransferableCurrency
local GetQuestInfo = GetQuestInfo or C_QuestLog.GetQuestInfo
local GetTitleForQuestID = GetTitleForQuestID or C_QuestLog.GetTitleForQuestID
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted
local IsQuestFlaggedCompletedOnAccount = IsQuestFlaggedCompletedOnAccount or C_QuestLog.IsQuestFlaggedCompletedOnAccount
local IsComplete = IsComplete or C_QuestLog.IsComplete
local IsOnQuest = IsOnQuest or C_QuestLog.IsOnQuest
local GetQuestObjectives = GetQuestObjectives or C_QuestLog.GetQuestObjectives
local GetInfo = GetInfo or C_QuestLog.GetInfo
local IsAccountQuest = IsAccountQuest or C_QuestLog.IsAccountQuest
local IsFailed = IsFailed or C_QuestLog.IsFailed
local GetNumQuestLogEntries = GetNumQuestLogEntries or C_QuestLog.GetNumQuestLogEntries
local GetFactionDataByID = GetFactionDataByID or C_Reputation.GetFactionDataByID
local IsFactionParagon = IsFactionParagon or C_Reputation.IsFactionParagon
local GetFactionParagonInfo = GetFactionParagonInfo or C_Reputation.GetFactionParagonInfo
local IsAccountWideReputation = IsAccountWideReputation or C_Reputation.IsAccountWideReputation
local IsMajorFaction = IsMajorFaction or C_Reputation.IsMajorFaction
local GetMajorFactionData = GetMajorFactionData or C_MajorFactions.GetMajorFactionData
local GetFriendshipReputation = GetFriendshipReputation or C_GossipInfo.GetFriendshipReputation
local GetFriendshipReputationRanks = GetFriendshipReputationRanks or C_GossipInfo.GetFriendshipReputationRanks
local GetCovenantData = GetCovenantData or C_Covenants.GetCovenantData
local GetTradeSkillDisplayName = GetTradeSkillDisplayName or C_TradeSkillUI.GetTradeSkillDisplayName
local GetTradeSkillTexture = GetTradeSkillTexture or C_TradeSkillUI.GetTradeSkillTexture
local GetMapInfo = GetMapInfo or C_Map.GetMapInfo
local GetMapGroupID = GetMapGroupID or C_Map.GetMapGroupID
local GetMapGroupMembersInfo = GetMapGroupMembersInfo or C_Map.GetMapGroupMembersInfo
local GetCurrentCalendarTime = GetCurrentCalendarTime or C_DateAndTime.GetCurrentCalendarTime
local GetSecondsUntilWeeklyReset = GetSecondsUntilWeeklyReset or C_DateAndTime.GetSecondsUntilWeeklyReset
local GetWeeklyResetStartTime = GetWeeklyResetStartTime or C_DateAndTime.GetWeeklyResetStartTime
local GetHolidayInfo = C_Calendar.GetHolidayInfo
local GetDayEvent = C_Calendar.GetDayEvent
local GetMonthInfo = C_Calendar.GetMonthInfo
local SetAbsMonth = C_Calendar.SetAbsMonth
local GetNumDayEvents = GetNumDayEvents or C_Calendar.GetNumDayEvents
local GetBuildingInfo = GetBuildingInfo or C_Garrison.GetBuildingInfo
local IsFollowerOnCompletedMission = IsFollowerOnCompletedMission or C_Garrison.IsFollowerOnCompletedMission
local GetFollowerNameByID = GetFollowerNameByID or C_Garrison.GetFollowerNameByID -- (garrFollowerID)
local GetPlayerAuraBySpellID = GetPlayerAuraBySpellID or C_UnitAuras.GetPlayerAuraBySpellID
-- local GetFollowerName = GetFollowerName or C_Garrison.GetFollowerName -- (followerID)
local GetMountIDs = C_MountJournal.GetMountIDs
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID
local GetMountFromItem = C_MountJournal.GetMountFromItem
local classR, classG, classB = GetClassColor(E.classFilename)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_Tooltip_Chars(CharInfo)
	local tooltip_Chars = {}
	local pd = CharInfo.PlayerData or {}
	local color = E.COLOR_SKYBLUE
	-- ===== locals from pd =====
	local classColorHex                = pd.classColorHex or E.COLOR_GREEN
	local Name                         = pd.Name or ""
	local curServer                    = pd.curServer or ""
	local guildName                    = pd.guildName or ""
	local guildRankName                = pd.guildRankName or ""
	local guildRankIndex               = pd.guildRankIndex or 0
	local RaceLocal                    = pd.RaceLocal or ""
	local UnitLevel                    = pd.UnitLevel or 0
	local UnitXPPercent                = pd.UnitXPPercent or 0
	local WarMode                      = pd.WarMode or false
	local Chromie_name                 = pd.Chromie_name or ""
	local curLocation                  = pd.curLocation or ""
	local usedSlots_BAGS               = pd.usedSlots_BAGS or 0
	local totalSlots_BAGS              = pd.totalSlots_BAGS or 0
	local usedSlots_BANK               = pd.usedSlots_BANK or 0
	local totalSlots_BANK              = pd.totalSlots_BANK or 0
	local numQuests                    = pd.numQuests or 0
	local maxNumQuestsCanAccept        = pd.maxNumQuestsCanAccept or 0
	local realTotalTime                = pd.realTotalTime or 0
	local specIcon                     = pd.specIcon or 0
	local specTexture                  = E.func_texturefromIcon(specIcon)
	-- ===== Header =====
	if Name ~= "" and curServer ~= "" then
		tooltip_Chars.Header = {
			specTexture..classColorHex..Name.."|r ("..curServer..")"
		}
	end
	-- ===== Guild =====
	if guildName ~= "" and guildRankName ~= "" and guildRankIndex > 0 then
		tooltip_Chars[#tooltip_Chars + 1] = {
			"<"..E.COLOR_GREEN..guildName.."|r> ["..E.COLOR_GREEN..guildRankName.."|r]"
		}
	end
	-- ===== Race / Level =====
	if RaceLocal ~= "" then
		if UnitLevel ~= E.currentMaxLevel and UnitXPPercent > 0 then
			tooltip_Chars[#tooltip_Chars + 1] = {
				format(TOOLTIP_UNIT_LEVEL_RACE, UnitLevel, RaceLocal)
			}
		else
			tooltip_Chars[#tooltip_Chars + 1] = { RaceLocal, "" }
		end
	end
	-- ===== War Mode =====
	if WarMode then
		tooltip_Chars[#tooltip_Chars + 1] = {
			E.COLOR_SKYBLUE..ERR_PVP_WARMODE_TOGGLE_ON.."|r"
		}
	end
	-- ===== Chromie Time =====
	if Chromie_name ~= "" then
		tooltip_Chars[#tooltip_Chars + 1] = { " ", " " }
		tooltip_Chars[#tooltip_Chars + 1] = {
			E.func_texturefromIcon("ChromieMap", nil, nil, true)..E.func_GetNPCName(167032)..": "..E.COLOR_GREEN..Chromie_name.."|r"
		}
	end
	-- ===== Location =====
	if curLocation ~= "" then
		tooltip_Chars[#tooltip_Chars + 1] = { " ", " " }
		tooltip_Chars[#tooltip_Chars + 1] = {
			E.func_texturefromIcon(132319)..FRIENDS_LIST_ZONE..classColorHex..curLocation.."|r"
		}
	end
	-- ===== Bags / Bank =====
	if usedSlots_BAGS > 0 and totalSlots_BAGS > 0 then
		local icon = E.func_texturefromIcon(133634)
		local textLeft = icon..BAG_NAME_BACKPACK..": "..classColorHex..usedSlots_BAGS.."/"..totalSlots_BAGS.."|r"
		if totalSlots_BANK > 0 then
			textLeft = textLeft.." "..BANK..": "..classColorHex..usedSlots_BANK.."/"..totalSlots_BANK.."|r"
		end
		tooltip_Chars[#tooltip_Chars + 1] = { textLeft, "" }
	end
	-- ===== Quests =====
	if maxNumQuestsCanAccept > 0 then
		tooltip_Chars[#tooltip_Chars + 1] = {
			E.func_texturefromIcon(236664)..QUESTS_LABEL..": "..classColorHex..numQuests.."/"..maxNumQuestsCanAccept.."|r"
		}
	end
	-- ===== Playtime =====
	if realTotalTime > 0 then
		tooltip_Chars[#tooltip_Chars + 1] = { " ", "" }
		tooltip_Chars[#tooltip_Chars + 1] = {
			string.format(TIME_PLAYED_TOTAL,classColorHex..E.func_SecondsToClock(realTotalTime)).."|r"
		}
	end
	-- ===== Special Item =====
	if CharInfo.MASLENGO and CharInfo.MASLENGO.Items and CharInfo.MASLENGO.Items.Bags and CharInfo.MASLENGO.Items.Bags[122284] then
		tooltip_Chars[#tooltip_Chars + 1] = { " ", "" }
		tooltip_Chars[#tooltip_Chars + 1] = {
			E.func_GetItemName(122284),
			CharInfo.MASLENGO.Items.Bags[122284]
		}
	end
	-- ===== Debug =====
	if E.DebugCharacterInfo then
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		tooltip_Chars[#tooltip_Chars+1] = {color..E.DEVTEXT.."|r", ""}
		if pd.tmstp_Daily then
			tooltip_Chars[#tooltip_Chars+1] = {
				color.."tmstp_Daily|r",
				classColorHex..E.func_SecondsToClock(pd.tmstp_Daily - GetServerTime()).."|r"
			}
		end
		if pd.tmstp_Weekly then
			tooltip_Chars[#tooltip_Chars+1] = {
				color.."tmstp_Weekly|r",
				classColorHex..E.func_SecondsToClock(pd.tmstp_Weekly - GetServerTime()).."|r"
			}
		end
		-- Character identification
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."GUID|r",
			E.COLOR_PURPLE..pd.GUID.."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."hasMail|r",
			pd.hasMail and E.func_texturefromIcon(E.Icon_MailBox)..classColorHex.."true|r" or color.."false|r"
		}
		-- Chromie time debug info
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."Chromie_canEnter|r",
			pd.Chromie_canEnter and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."Chromie_UnitChromieTimeID|r",
			color..tostring(pd.Chromie_UnitChromieTimeID or "").."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."Chromie_name|r",
			color..tostring(pd.Chromie_name or "").."|r"
		}
		-- BattleTag info
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."BattleTag|r",
			E.COLOR_BLUE..pd.BattleTag.."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."BattleTagLocal|r",
			E.COLOR_BLUE..pd.BattleTagLocal.."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account restrictions
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."GameLimitedMode_IsActive|r",
			pd.GameLimitedMode_IsActive and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."levelCapped20|r",
			pd.levelCapped20 and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."PlayerCanEarnExperience|r",
			pd.PlayerCanEarnExperience and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Build info
		tooltip_Chars[#tooltip_Chars+1] = {color.."buildVersion|r", classColorHex..pd.buildVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {color.."buildNumber|r",  classColorHex..pd.buildNumber.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {color.."buildDate|r",    classColorHex..pd.buildDate.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {color.."interfaceVersion|r", classColorHex..pd.interfaceVersion.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Version info
		tooltip_Chars[#tooltip_Chars+1] = {color.."currentTier|r", classColorHex..pd.currentTier.."|r"}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."IsPublicBuild|r",
			pd.IsPublicBuild and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account limits
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."max LVL|r",
			pd.GetRestrictedAccountData_rLevel and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."max Money|r",
			pd.GetRestrictedAccountData_rMoney and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Account security
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."Authenticator|r",
			pd.IsAccountSecured and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."IsRestrictedAccount|r",
			pd.IsRestrictedAccount and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."IsTrialAccount|r",
			pd.IsTrialAccount and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."IsVeteranTrialAccount|r",
			pd.IsVeteranTrialAccount and E.TRUE or color.."false|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {" ", ""}
		-- Durability
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."PlayerDurability|r",
			pd.PlayerDurability and E.TRUE or color.."false|r"
		}
		-- CharDB / Region
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."CharDBVersion|r",
			color..tostring(pd.CharDBVersion or "").."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."CurrentRegion|r",
			color..tostring(pd.CurrentRegion or "").."|r"
		}
		tooltip_Chars[#tooltip_Chars+1] = {
			color.."CurrentRegionName|r",
			color..tostring(pd.CurrentRegionName or "").."|r"
		}
	end
	return tooltip_Chars
end
