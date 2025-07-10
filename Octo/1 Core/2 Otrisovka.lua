local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale("Octo")
local tinsert = table.insert
local tremove = table.remove
local tsort = table.sort
local tconcat = table.concat
local pairs = pairs
local ipairs = ipairs
local next = next
local tostring = tostring
local tostringall = tostringall
local select = select
local GetServerTime = GetServerTime
local string_format = string.format
local math_floor = math.floor
local wipe = wipe
function E.func_textCENT(CharInfo)
	local namePart = CharInfo.classColorHex..CharInfo.Name.."|r"
	local levelPart = ""
	if CharInfo.UnitLevel ~= 0 and
	CharInfo.UnitLevel ~= E.currentMaxLevel and
	CharInfo.PlayerCanEarnExperience then
		levelPart = " "..E.Yellow_Color..CharInfo.UnitLevel.."|r"
	end
	local serverPart = ""
	if not Octo_ToDo_DB_Vars.ShowOnlyCurrentServer and
	E.func_CurServerShort(E.curServer) ~= CharInfo.curServerShort then
		serverPart = E.Skyblue_Color.."("..CharInfo.curServerShort..")|r"
	end
	return namePart..levelPart..serverPart
end
local function AddDoubleLine(left, right, tooltip)
	tooltip[#tooltip+1] = {left, right or ""}
end
function E.CreateTooltipPlayers(CharInfo)
	local tooltipRIGHT = {}
	-- Basic character information
	if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal then
		-- Name and guild info
		if CharInfo.guildRankIndex ~= 0 then
			tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", "<"..E.Green_Color..CharInfo.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.guildRankName.."|r".."]"}
		else
			tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")", " "}
		end
		-- War mode status
		if CharInfo.WarMode == true then
			tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""}
		end
		-- Level and race info
		if CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.UnitXPPercent then
			tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.RaceLocal.." "..CharInfo.classColorHex..CharInfo.UnitLevel.."-го|r уровня "..CharInfo.classColorHex..CharInfo.UnitXPPercent.."%|r", " "}
		else
			tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.RaceLocal, " "}
		end
		-- Spec and class info
		if CharInfo.specName ~= 0 or CharInfo.specName ~= 0 then
			tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className, " "}
		end
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
	end
	-- Chromie time info
	if CharInfo.Chromie_name ~= nil and CharInfo.Chromie_name ~= "" then
		tooltipRIGHT[#tooltipRIGHT+1] = {E.Red_Color..CharInfo.Chromie_name.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
	end
	-- Location info
	if CharInfo.BindLocation ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(134414)..L["Bind Location"], CharInfo.BindLocation}
	end
	if CharInfo.curLocation ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(132319)..L["Current Location"], CharInfo.curLocation}
	end
	-- Inventory info
	if CharInfo.totalSlots ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(133634)..L["Bags"], CharInfo.classColorHex..(CharInfo.usedSlots.."/"..CharInfo.totalSlots).."|r"}
	end
	-- Quests info
	if CharInfo.maxNumQuestsCanAccept ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(236664)..QUESTS_LABEL, CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"}
	end
	-- Play time info
	if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		tooltipRIGHT[#tooltipRIGHT+1] = {string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..E.func_SecondsToClock(CharInfo.realTotalTime)).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..E.func_SecondsToClock(CharInfo.realLevelTime)).."|r"}
	end
	-- Special item info
	if CharInfo.MASLENGO.ItemsInBag[122284] ~= nil then
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(122284))..E.func_GetItemNameByID(122284), CharInfo.MASLENGO.ItemsInBag[122284]}
	end
	-- Reload count
	if CharInfo.ReloadCount ~= 0 then
		tooltipRIGHT[#tooltipRIGHT+1] = {"Reload Count: "..CharInfo.classColorHex..CharInfo.ReloadCount.."|r"}
	end
	-- Debug information
	if E.DebugInfo then
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		tooltipRIGHT[#tooltipRIGHT+1] = {E.DEVTEXT, " "}
		-- Character identification
		tooltipRIGHT[#tooltipRIGHT+1] = {E.Purple_Color.."GUID".."|r", E.Purple_Color..CharInfo.GUID.."|r"}
		if CharInfo.hasMail ~= false then
			tooltipRIGHT[#tooltipRIGHT+1] = {"hasMail", E.func_texturefromIcon(E.Icon_MailBox)..CharInfo.classColorHex.."true|r"}
		end
		-- Chromie time debug info
		tooltipRIGHT[#tooltipRIGHT+1] = {"Chromie_canEnter", CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"Chromie_UnitChromieTimeID", CharInfo.Chromie_UnitChromieTimeID.."|r"}
		if CharInfo.Chromie_name ~= nil then
			tooltipRIGHT[#tooltipRIGHT+1] = {"Chromie_name", CharInfo.classColorHex..CharInfo.Chromie_name.."|r"}
		end
		-- BattleTag info
		tooltipRIGHT[#tooltipRIGHT+1] = {"BattleTag", E.Blue_Color..CharInfo.BattleTag.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"BattleTagLocal", E.Blue_Color..CharInfo.BattleTagLocal.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Account restrictions
		tooltipRIGHT[#tooltipRIGHT+1] = {"GameLimitedMode_IsActive", CharInfo.GameLimitedMode_IsActive and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"levelCapped20", CharInfo.levelCapped20 and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"PlayerCanEarnExperience", CharInfo.PlayerCanEarnExperience and E.Green_Color.."true|r" or E.Red_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Build info
		tooltipRIGHT[#tooltipRIGHT+1] = {"buildVersion", CharInfo.classColorHex..CharInfo.buildVersion.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"buildNumber", CharInfo.classColorHex..CharInfo.buildNumber.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"buildDate", CharInfo.classColorHex..CharInfo.buildDate.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"interfaceVersion", CharInfo.classColorHex..CharInfo.interfaceVersion.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Version info
		tooltipRIGHT[#tooltipRIGHT+1] = {"currentTier", CharInfo.classColorHex..CharInfo.currentTier.."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"IsPublicBuild", CharInfo.IsPublicBuild and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"isBeta", CharInfo.isBeta and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Account limits
		tooltipRIGHT[#tooltipRIGHT+1] = {"max LVL", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rLevel).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"max Money", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rMoney).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"max Prof", CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_profCap).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Account security
		tooltipRIGHT[#tooltipRIGHT+1] = {"Authenticator", CharInfo.classColorHex..tostringall(CharInfo.IsAccountSecured).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"УЗ имеет ограничения пробной УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsRestrictedAccount).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"Использует ли игрок пробную УЗ", CharInfo.classColorHex..tostringall(CharInfo.IsTrialAccount).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {"Нет игрового времени", CharInfo.classColorHex..tostringall(CharInfo.IsVeteranTrialAccount).."|r"}
		tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		-- Durability
		tooltipRIGHT[#tooltipRIGHT+1] = {"PlayerDurability", CharInfo.PlayerDurability.."%"}
		-- DBVersion
		tooltipRIGHT[#tooltipRIGHT+1] = {"DBVersion", CharInfo.DBVersion}
	end
	return tooltipRIGHT
end
local OctoTable_func_otrisovka = {}
local function func_Universal(expansionID)
	for expID, expDATA in ipairs(E.OctoTable_Expansions) do
		if expID == expansionID then
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if expDATA.nameShort == v.desc then
					tinsert(OctoTable_func_otrisovka, function(CharInfo)
							----------------------------------------------------------------
							local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
							----------------------------------------------------------------
							local LeftData = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							local max = v.max
							if LeftData and type(LeftData) == "number" and max then
								if LeftData < max then
									textCENT = LeftData.."/"..max
								else
									textCENT = E.DONE
								end
							end
							if CharInfo.GUID == E.curGUID then
								for index, questID in ipairs(v.questID) do
									tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
								end
							end
							----------------------------------------------------------------
							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = expDATA.color
							----------------------------------------------------------------
							return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
							----------------------------------------------------------------
					end)
				end
			end
		end
	end
end
local function func_Universal_Holiday(Holiday, color)
	for _, v in ipairs(E.OctoTable_UniversalQuest) do
		if v.desc == Holiday then
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local LeftData = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
					local max = v.max
					if LeftData and type(LeftData) == "number" and max then
						if LeftData < max then
							textCENT = LeftData.."/"..max
						else
							textCENT = E.DONE
						end
					end
					if CharInfo.GUID == E.curGUID then
						for index, questID in ipairs(v.questID) do
							tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
						end
					end
					----------------------------------------------------------------
					textLEFT = tostringall(v.textleft).."|r"
					iconLEFT = v.icon
					colorLEFT = color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
	end
end
local OCTOexpansionID11 = 11
local OCTOexpansionID10 = 10
local OCTOexpansionID9 = 9
local OCTOexpansionID8 = 8
local OCTOexpansionID7 = 7
local OCTOexpansionID6 = 6
local OCTOexpansionID5 = 5
local OCTOexpansionID4 = 4
local OCTOexpansionID3 = 3
local OCTOexpansionID2 = 2
local OCTOexpansionID1 = 1
function E:func_Otrisovka()
	wipe(OctoTable_func_otrisovka)
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID11] then
		func_Universal(OCTOexpansionID11)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				local Enum_Activities_table = {}
				for name, i in next, (Enum.WeeklyRewardChestThresholdType) do
					Enum_Activities_table[#Enum_Activities_table+1] = i
				end
				tsort(Enum_Activities_table)
				for j = 1, #Enum_Activities_table do
					local i = Enum_Activities_table[j]
					if CharInfo.MASLENGO.GreatVault[i] and CharInfo.MASLENGO.GreatVault[i].type ~= "" then
						CharInfo.MASLENGO.GreatVault[i] = CharInfo.MASLENGO.GreatVault[i] or {}
						CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING = CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING or 0
						CharInfo.MASLENGO.GreatVault[i].progress = CharInfo.MASLENGO.GreatVault[i].progress or 0
						CharInfo.MASLENGO.GreatVault[i].threshold = CharInfo.MASLENGO.GreatVault[i].threshold or 0
						if CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING ~= 0 then
							tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING.."|r"}
						elseif CharInfo.MASLENGO.GreatVault[i].progress ~= 0 then
							tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold}
						end
					end
				end
				if CharInfo.HasAvailableRewards then
					textCENT = textCENT..E.Blue_Color..">"..REWARD.."<|r"
				end
				textLEFT = E.Blue_Color..RATED_PVP_WEEKLY_VAULT.."|r"-- DELVES_GREAT_VAULT_LABEL
				iconLEFT = "greatVault-whole-normal"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID11].color
				-- CreateAtlasMarkup("greatVault-whole-normal", 20, 20)..
				-- greatVault-handles-dis
				-- greatVault-centerPlate-dis
				-- greatVault-whole-normal
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.CurrentKeyName and CharInfo.CurrentKeyName ~= 0 then
					tooltipRIGHT[#tooltipRIGHT+1] = {E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyName.."|r", ""}
				end
				if CharInfo.RIO_Score ~= 0 then
					tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
					tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
					tooltipRIGHT[#tooltipRIGHT+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_weeklyBest.."|r"}
					tooltipRIGHT[#tooltipRIGHT+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_Score.."|r"}
				end
				if CharInfo.CurrentKey ~= 0 then
					textCENT = E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKey.."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.WOW_Epic_Color..L["Mythic Keystone"].."|r"
				iconLEFT = 4352494
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID11].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID10] then
		func_Universal(OCTOexpansionID10)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= nil then
					textCENT = textCENT..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(209856)
				iconLEFT = E.func_GetItemIconByID(209856)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= nil then
					textCENT = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(207002)
				iconLEFT = E.func_GetItemIconByID(207002)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[2594] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= nil then
					textCENT = textCENT..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_GetItemIconByID(208945)
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2594)
				iconLEFT = E.func_GetCurrencyIcon(2594)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= nil then
					textCENT = textCENT..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= nil then
					textCENT = textCENT..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				----------------------------------------------------------------
				textLEFT = E.WOW_Epic_Color..E.func_GetItemNameByID(210254).."|r"
				iconLEFT = E.func_GetItemIconByID(210254)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[2245] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2245]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2245)
				iconLEFT = E.func_GetCurrencyIcon(2245)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(213089)
				iconLEFT = E.func_GetItemIconByID(213089)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(211516)
				iconLEFT = E.func_GetItemIconByID(211516)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(211515)
				iconLEFT = E.func_GetItemIconByID(211515)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID10].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID9] then
		func_Universal(OCTOexpansionID9)
		local colorCENT
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				tinsert(OctoTable_func_otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
						----------------------------------------------------------------
						if CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant] ~= nil then
							if kCovenant == 1 then
								textCENT = textCENT..E.func_EmptyZero(CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant])
							else
								textCENT = textCENT..E.func_EmptyZero(CharInfo.MASLENGO.CovenantAndAnima[iANIMA][kCovenant])
							end
						end
						textCENT = E.OctoTable_Covenant[iANIMA].color..textCENT.."|r"
						if iANIMA == CharInfo.MASLENGO.CovenantAndAnima.curCovID then
							if CharInfo.Possible_Anima ~= 0 and kCovenant == 2 then
								textCENT = textCENT..E.Blue_Color.." +"..CharInfo.Possible_Anima.."|r"
							end
							colorCENT = E.OctoTable_Covenant[iANIMA].color
						else
							colorCENT = nil
						end
						----------------------------------------------------------------
						local vivodLeft = E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r"
						if kCovenant == 2 then
							vivodLeft = vivodLeft.. E.func_texturefromIcon(E.func_GetCurrencyIcon(1813))
						end
						----------------------------------------------------------------
						textLEFT = vivodLeft
						iconLEFT = E.OctoTable_Covenant[iANIMA].icon
						colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
						----------------------------------------------------------------
						return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
						----------------------------------------------------------------
				end)
			end
		end
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[2009] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2009]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(2009)
				iconLEFT = E.func_GetCurrencyIcon(2009)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1906] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1906]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1906)
				iconLEFT = E.func_GetCurrencyIcon(1906)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1828] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1828]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1828)
				iconLEFT = E.func_GetCurrencyIcon(1828)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1979] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1979]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1979)
				iconLEFT = E.func_GetCurrencyIcon(1979)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1931] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1931]
				end
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					textCENT = textCENT..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1931)
				iconLEFT = E.func_GetCurrencyIcon(1931)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID9].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID8] then
		func_Universal(OCTOexpansionID8)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1560] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1560]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1560)
				iconLEFT = E.func_GetCurrencyIcon(1560)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1721] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1721]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1721)
				iconLEFT = E.func_GetCurrencyIcon(1721)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1803] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1803]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1803)
				iconLEFT = E.func_GetCurrencyIcon(1803)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1755] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= nil then
					textCENT = textCENT.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_texturefromIcon(E.func_GetItemIconByID(173363))
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1755)
				iconLEFT = E.func_GetCurrencyIcon(1755)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1719] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1719]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1719)
				iconLEFT = E.func_GetCurrencyIcon(1719)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1710] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1710]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1710)
				iconLEFT = E.func_GetCurrencyIcon(1710)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1716] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1716]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1716)
				iconLEFT = E.func_GetCurrencyIcon(1716)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1718]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1718)
				iconLEFT = E.func_GetCurrencyIcon(1718)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[158075] == nil then
					textCENT = E.Red_Color.."no neck|r"
				else
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						textCENT = E.Green_Color..CharInfo.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(158075)
				iconLEFT = E.func_GetItemIconByID(158075)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[169223] == nil then
					textCENT = E.Red_Color.."no cloak|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[169223] ~= nil then
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.cloak_lvl ~= 0 then
						textCENT = CharInfo.cloak_lvl.." lvl"
						if CharInfo.cloak_lvl == 15 then
							textCENT = E.Green_Color..textCENT.."|r"
						end
					end
					if CharInfo.cloak_res ~= 0 then
						textCENT = textCENT.."+"..CharInfo.cloak_res
					end
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(169223)
				iconLEFT = E.func_GetItemIconByID(169223)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.islandBfA ~= nil then
					textCENT = CharInfo.MASLENGO.islandBfA
				end
				----------------------------------------------------------------
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					textLEFT = E.func_questName(questID)
				else
					textLEFT = "All_BfA_Island"
				end
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166846))..E.func_GetItemNameByID(166846), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166846])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(169610))..E.func_GetItemNameByID(169610), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[169610])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166970))..E.func_GetItemNameByID(166970), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166970])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168327))..E.func_GetItemNameByID(168327), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168327])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168832))..E.func_GetItemNameByID(168832), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168832])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166971))..E.func_GetItemNameByID(166971), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166971])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168946))..E.func_GetItemNameByID(168946), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168946])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168215))..E.func_GetItemNameByID(168215), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168215])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168216))..E.func_GetItemNameByID(168216), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168216])}
				tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168217))..E.func_GetItemNameByID(168217), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168217])}
				textCENT = "МЕХАГОН"
				----------------------------------------------------------------
				textLEFT = "МЕХАГОН"
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID8].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID7] then
		func_Universal(OCTOexpansionID7)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1273] then
					textCENT = CharInfo.MASLENGO.CurrencyID_Total[1273]
				end
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273)
				iconLEFT = E.func_GetCurrencyIcon(1273)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1508] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1508)
				iconLEFT = E.func_GetCurrencyIcon(1508)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1342]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1342)
				iconLEFT = E.func_GetCurrencyIcon(1342)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1220]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1220)
				iconLEFT = E.func_GetCurrencyIcon(1220)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1226]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1226)
				iconLEFT = E.func_GetCurrencyIcon(1226)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1533]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1533)
				iconLEFT = E.func_GetCurrencyIcon(1533)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1155]
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1155)
				iconLEFT = E.func_GetCurrencyIcon(1155)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				----------------------------------------------------------------
				textLEFT = E.func_GetItemNameByID(124124)
				iconLEFT = E.func_GetItemIconByID(124124)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID7].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID6] then
		func_Universal(OCTOexpansionID6)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1129] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1129]
				end
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129)
				iconLEFT = E.func_GetCurrencyIcon(1129)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[994] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[994]
				end
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994)
				iconLEFT = E.func_GetCurrencyIcon(994)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[823] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[823]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(823)
				iconLEFT = E.func_GetCurrencyIcon(823)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[1101] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1101]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(1101)
				iconLEFT = E.func_GetCurrencyIcon(1101)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[824] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[824]
				end
				----------------------------------------------------------------
				textLEFT = E.func_currencyName(824)
				iconLEFT = E.func_GetCurrencyIcon(824)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		-- tinsert(OctoTable_func_otrisovka, function(CharInfo)
		--         ----------------------------------------------------------------
		--         local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
		--         ----------------------------------------------------------------
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114128))..E.func_GetItemNameByID(114128), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114128])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114129))..E.func_GetItemNameByID(114129), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114129])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114131))..E.func_GetItemNameByID(114131), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114131])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114616))..E.func_GetItemNameByID(114616), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114616])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114081))..E.func_GetItemNameByID(114081), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114081])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114622))..E.func_GetItemNameByID(114622), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114622])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(128307))..E.func_GetItemNameByID(128307), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128307])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(120313))..E.func_GetItemNameByID(120313), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[120313])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114745))..E.func_GetItemNameByID(114745), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114745])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114808))..E.func_GetItemNameByID(114808), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114808])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114822))..E.func_GetItemNameByID(114822), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114822])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114807))..E.func_GetItemNameByID(114807), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114807])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114806))..E.func_GetItemNameByID(114806), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114806])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114746))..E.func_GetItemNameByID(114746), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114746])}
		--         tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(128308))..E.func_GetItemNameByID(128308), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128308])}
		--         textCENT = SPELL_UPGRADE
		--         ----------------------------------------------------------------
		--         textLEFT = GARRISON_FOLLOWERS_TITLE
		--         ----------------------------------------------------------------
		--         return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
		--         ----------------------------------------------------------------
		-- end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[38242] and E.DONE
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= nil then
					textCENT = textCENT.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_GetItemIconByID(122457)
				end
				----------------------------------------------------------------
				textLEFT = E.func_questName(38242).." (ап пета)"
				iconLEFT = E.func_GetItemIconByID(122457)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[39246] and E.DONE
				end
				----------------------------------------------------------------
				textLEFT = E.func_questName(39246)
				iconLEFT = E.func_GetItemIconByID(127267)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID6].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID5] then
		func_Universal(OCTOexpansionID5)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[697] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[697]
				end
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697)
				iconLEFT = E.func_GetCurrencyIcon(697)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID5].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.CurrencyID[776] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[776]
				end
				----------------------------------------------------------------
				textLEFT = E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776)
				iconLEFT =E.func_GetCurrencyIcon(776)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID5].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID4] then
		func_Universal(OCTOexpansionID4)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(52078)
				iconLEFT =E.func_GetItemIconByID(52078)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID4].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(69237)
				iconLEFT =E.func_GetItemIconByID(69237)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID4].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(71998)
				iconLEFT =E.func_GetItemIconByID(71998)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID4].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID3] then
		func_Universal(OCTOexpansionID3)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(45087)
				iconLEFT =E.func_GetItemIconByID(45087)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID3].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(47556)
				iconLEFT =E.func_GetItemIconByID(47556)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID3].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(49908)
				iconLEFT =E.func_GetItemIconByID(49908)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID3].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID2] then
		func_Universal(OCTOexpansionID2)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(23572)
				iconLEFT =E.func_GetItemIconByID(23572)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID2].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(30183)
				iconLEFT =E.func_GetItemIconByID(30183)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID2].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(32428)
				iconLEFT =E.func_GetItemIconByID(32428)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID2].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(34664)
				iconLEFT =E.func_GetItemIconByID(34664)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID2].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[24581] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[24581]
				elseif CharInfo.MASLENGO.ItemsInBag[24579] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[24579]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(24581)
				iconLEFT =E.func_GetItemIconByID(24581)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID2].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ExpansionToShow[OCTOexpansionID1] then
		func_Universal(OCTOexpansionID1)
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				----------------------------------------------------------------
				textLEFT =E.func_GetItemNameByID(23572)
				iconLEFT =E.func_GetItemIconByID(23572)
				colorLEFT = E.OctoTable_Expansions[OCTOexpansionID1].color
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Holidays then
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[181] then
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[181]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[181]
					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 181|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			func_Universal_Holiday("HolidaysNoblegarden", E.Holiday_Color)
			-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
			--     if v.desc == "HolidaysNoblegarden" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                 end
			--                 if CharInfo.GUID == E.curGUID then
			--                     for index, questID in ipairs(v.questID) do
			--                         tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 colorLEFT = E.Holiday_Color
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			-- end
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[44791] ~= nil then
						textCENT = CharInfo.MASLENGO.ItemsInBag[44791]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(44791)
					iconLEFT = E.func_GetItemIconByID(44791)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[45072] ~= nil then
						textCENT = CharInfo.MASLENGO.ItemsInBag[45072]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(45072)
					iconLEFT = E.func_GetItemIconByID(45072)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		local TimewalkHolidayTBL = {1265, 1063, 652, 622} -- 1458 Бурные потоки
		for _, HolidayID in ipairs(TimewalkHolidayTBL) do
			if Octo_ToDo_DB_Other.ActiveHoliday[HolidayID] then
				tinsert(OctoTable_func_otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
						----------------------------------------------------------------
						local v = Octo_ToDo_DB_Other.Holiday[HolidayID]
						if CharInfo.GUID == E.curGUID then
							textCENT = E.Event_Color..v.startTime.." - "..v.endTime.."|r"
						end
						----------------------------------------------------------------
						textLEFT = v.invitedBy..E.Event_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id:"..HolidayID.."|r" or "")
						iconLEFT = v.iconTexture
						colorLEFT = E.Event_Color
						----------------------------------------------------------------
						return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
						----------------------------------------------------------------
				end)
				func_Universal_Holiday("HolidaysTimewalk", E.Event_Color)
				-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
				--     if v.desc == "HolidaysTimewalk" then
				--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
				--                 ----------------------------------------------------------------
				--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				--                 ----------------------------------------------------------------
				--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
				--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
				--                 end
				--                 if CharInfo.GUID == E.curGUID then
				--                     for index, questID in ipairs(v.questID) do
				--                         tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
				--                     end
				--                 end
				--                 ----------------------------------------------------------------
				--                 textLEFT = E.func_texturefromIcon(E.Icon_LFG) .. tostringall(v.textleft).."|r"
				--                 iconLEFT = v.icon
				--                 colorLEFT = E.Event_Color
				--                 ----------------------------------------------------------------
				--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				--                 ----------------------------------------------------------------
				--         end)
				--     end
				-- end
				tinsert(OctoTable_func_otrisovka, function(CharInfo)
						----------------------------------------------------------------
						local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
						----------------------------------------------------------------
						if CharInfo.MASLENGO.CurrencyID[1166] ~= nil then
							textCENT = CharInfo.MASLENGO.CurrencyID[1166]
						end
						----------------------------------------------------------------
						textLEFT = E.func_currencyName(1166)
						iconLEFT = E.func_GetCurrencyIcon(1166)
						colorLEFT = E.Event_Color
						----------------------------------------------------------------
						return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
						----------------------------------------------------------------
				end)
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[201] then
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[201]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					----------------------------------------------------------------
					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 201|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			func_Universal_Holiday("HolidaysChildrensWeek", E.Holiday_Color)
			-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
			--     if v.desc == "HolidaysChildrensWeek" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                     if CharInfo.GUID == E.curGUID then
			--                         for index, questID in ipairs(v.questID) do
			--                             tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                         end
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			-- end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[341]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					----------------------------------------------------------------
					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 341|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			func_Universal_Holiday("HolidaysMidsummerFireFestival", E.Holiday_Color)
			func_Universal_Holiday("TheSpinnerofSummerTales", E.Holiday_Color)
			-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
			--     if v.desc == "HolidaysMidsummerFireFestival" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                     if CharInfo.GUID == E.curGUID then
			--                         for index, questID in ipairs(v.questID) do
			--                             tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                         end
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 colorLEFT = E.Holiday_Color
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			--     if v.desc == "TheSpinnerofSummerTales" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                     if CharInfo.GUID == E.curGUID then
			--                         for index, questID in ipairs(v.questID) do
			--                             tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                         end
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 colorLEFT = E.Holiday_Color
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			-- end
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday ~= nil then
						textCENT = textCENT .. CharInfo.MASLENGO.LFGInstance[286].donetoday
					end
					----------------------------------------------------------------
					textLEFT = E.func_texturefromIcon(E.Icon_LFG) .. E.func_LFGdungName(286)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.ItemsInBag[23247] ~= nil then
						textCENT = textCENT..CharInfo.MASLENGO.ItemsInBag[23247]
					end
					----------------------------------------------------------------
					textLEFT = E.func_GetItemNameByID(23247)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[1691] then -- Алчный посланец
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[1691]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Red_Color..v.startTime.." - "..v.endTime.."|r"
					end
					----------------------------------------------------------------
					textLEFT = v.invitedBy..E.Red_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 1691|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Red_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			func_Universal_Holiday("HolidaysAGreedyEmissary", E.Red_Color)
			-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
			--     if v.desc == "HolidaysAGreedyEmissary" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                 end
			--                 if CharInfo.GUID == E.curGUID then
			--                     for index, questID in ipairs(v.questID) do
			--                         tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 colorLEFT = E.Red_Color
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			-- end
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					if CharInfo.MASLENGO.CurrencyID[3309] ~= nil then
						textCENT = CharInfo.MASLENGO.CurrencyID[3309]
					end
					----------------------------------------------------------------
					textLEFT = E.func_currencyName(3309)
					iconLEFT = E.func_GetCurrencyIcon(3309)
					colorLEFT = E.Red_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[479] then -- Ярмарка новолунья
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					local v = Octo_ToDo_DB_Other.Holiday[479]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Purple_Color..v.startTime.." - "..v.endTime.."|r"
					end
					----------------------------------------------------------------
					textLEFT = v.invitedBy..E.Purple_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 479|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Purple_Color
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
			func_Universal_Holiday("HolidaysDarkmoonFaire", E.Purple_Color)
			-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
			--     if v.desc == "HolidaysDarkmoonFaire" then
			--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
			--                 ----------------------------------------------------------------
			--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
			--                 ----------------------------------------------------------------
			--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
			--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
			--                 end
			--                 if CharInfo.GUID == E.curGUID then
			--                     for index, questID in ipairs(v.questID) do
			--                         tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
			--                     end
			--                 end
			--                 ----------------------------------------------------------------
			--                 textLEFT = tostringall(v.textleft).."|r"
			--                 iconLEFT = v.icon
			--                 colorLEFT = E.Purple_Color
			--                 ----------------------------------------------------------------
			--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
			--                 ----------------------------------------------------------------
			--         end)
			--     end
			-- end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.DebugInfo == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				for _, v in next, (E.OctoTable_UniversalQuest) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] == E.DONE then
						tooltipRIGHT[#tooltipRIGHT+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Green_Color.."Выполненные|r"
				end
				----------------------------------------------------------------
				textLEFT = E.DEVTEXT..E.Blue_Color.."ALL|r"
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		E.func_TableRemoveDuplicates(list)
		tsort(list)
		for i, value in ipairs(list) do
			tinsert(OctoTable_func_otrisovka, function(CharInfo)
					----------------------------------------------------------------
					local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
					----------------------------------------------------------------
					tooltipRIGHT[#tooltipRIGHT+1] = {E.DEVTEXT, ""}
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltipRIGHT[#tooltipRIGHT+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							textCENT = value
						end
					end
					----------------------------------------------------------------
					textLEFT = E.DEVTEXT..i
					----------------------------------------------------------------
					return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
					----------------------------------------------------------------
			end)
		end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Quests == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.numQuests ~= 0 then
					textCENT = CharInfo.classColorHex..CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept.."|r"
					local questIDs = {}
					for questID in next, CharInfo.MASLENGO.ListOfQuests do
						questIDs[#questIDs+1] = questID
					end
					tsort(questIDs, E.func_Reverse_order)
					for i = 1, #questIDs do
						local questID = questIDs[i]
						tooltipRIGHT[i] = {E.func_questName(questID), CharInfo.MASLENGO.ListOfQuests[questID]}
					end
				end
				----------------------------------------------------------------
				textLEFT = QUESTS_LABEL
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
		func_Universal_Holiday("Storyline", E.Holiday_Color)
		-- for _, v in ipairs(E.OctoTable_UniversalQuest) do
		--     if v.desc == "Storyline" then
		--         tinsert(OctoTable_func_otrisovka, function(CharInfo)
		--                 ----------------------------------------------------------------
		--                 local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
		--                 ----------------------------------------------------------------
		--                 if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
		--                     textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
		--                     if CharInfo.GUID == E.curGUID then
		--                         for index, questID in ipairs(v.questID) do
		--                             tooltipRIGHT[#tooltipRIGHT+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
		--                         end
		--                     end
		--                 end
		--                 ----------------------------------------------------------------
		--                 textLEFT = tostringall(v.textleft).."|r"
		--                 iconLEFT = v.icon
		--                 colorLEFT = E.Holiday_Color
		--                 ----------------------------------------------------------------
		--                 return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
		--                 ----------------------------------------------------------------
		--         end)
		--     end
		-- end
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Dungeons == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltipRIGHT[#tooltipRIGHT+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..instanceID.."|r" or ""), w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
					if v then
						if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday ~= nil then
							tooltipRIGHT[#tooltipRIGHT+1] = {CharInfo.MASLENGO.LFGInstance[dungeonID].D_name..(E.DebugIDs and E.Gray_Color.. " id:"..dungeonID.."|r" or ""), CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday}
						end
					end
				end
				for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
					if v then
						tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.Icon_WorldBoss).. v.name .." ".. E.Red_Color..E.func_SecondsToClock(v.reset).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..worldBossID.."|r" or ""), " "}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Gray_Color..DUNGEONS.."|r"
				else
					textCENT = ""
				end
				----------------------------------------------------------------
				textLEFT = DUNGEONS
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Items == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				for index, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if CharInfo.MASLENGO.ItemsInBag[itemID] ~= nil then
						tooltipRIGHT[#tooltipRIGHT+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(itemID))..E.func_GetItemNameByID(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
					end
				end
				if #tooltipRIGHT ~= 0 then
					textCENT = E.Gray_Color..ITEMS.."|r"
				else
					textCENT = ""
				end
				----------------------------------------------------------------
				textLEFT = ITEMS
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Professions == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				local charProf = CharInfo.MASLENGO.professions
				local pic = E.func_ProfessionIcon
				local pin = E.func_ProfessionName
				for i = 1, 5 do
					if charProf[i] and charProf[i].skillLine ~= nil and charProf[i].skillLine ~= 0 then
						if i == 1 or i == 2 then
							textCENT = textCENT..pic(charProf[i].skillLine).." "
						end
						local leftText = pic(charProf[i].skillLine).." "..pin(charProf[i].skillLine)
						local RightText = charProf[i].skillLevel.."/"..charProf[i].maxSkillLevel
						if charProf[i].skillModifier ~= nil and charProf[i].skillModifier ~= 0 then
							RightText = charProf[i].skillLevel.."|cff00FF00+"..charProf[i].skillModifier.."|r".."/"..charProf[i].maxSkillLevel
						end
						tooltipRIGHT[#tooltipRIGHT+1] = {leftText, RightText}
						if charProf[i].child ~= nil then
							-- for expIndex, v in ipairs(charProf[i].child) do
							for expIndex = #charProf[i].child, 1, -1 do
								local v = charProf[i].child[expIndex]
								if v.QWEskillLevel ~= nil and v.QWEskillLevel ~= 0 and v.QWEprofessionName ~= nil then
									-- for expI, j in ipairs(E.OctoTable_Expansions) do
									-- for expI = #E.OctoTable_Expansions, 1, -1 do
									--     local j = E.OctoTable_Expansions[expI]
									local j = E.OctoTable_Expansions[expIndex]
									tooltipRIGHT[#tooltipRIGHT+1] = {" "..E.func_texturefromIcon(j.icon, 16, 32).." "..j.color..j.nameVeryShort.."|r ", v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
									-- end
									-- end
								end
							end
						end
					end
				end
				----------------------------------------------------------------
				textLEFT = PROFESSIONS_BUTTON
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.Gold == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				if CharInfo.Money then
					textCENT = E.func_CompactNumberFormat(CharInfo.Money/10000)
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						textCENT = textCENT..E.Red_Color.."-|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {"lost: ", E.Red_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						textCENT = textCENT..E.Green_Color.."+|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {"received: ", E.Green_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					end
				end
				----------------------------------------------------------------
				textLEFT = BONUS_ROLL_REWARD_MONEY
				-- iconLEFT = E.Icon_Money
				iconLEFT = "coin-gold"
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.ItemLevel == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				local color = E.Red_Color
				local ItemLevelGreen = 625
				local ItemLevelOrange = 610
				local ItemLevelRed = 580
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
					textCENT = color..CharInfo.avgItemLevelEquipped
					if CharInfo.avgItemLevel > CharInfo.avgItemLevelEquipped then
						textCENT = textCENT.."/"..CharInfo.avgItemLevel.."|r"
					end
					if CharInfo.avgItemLevelPvp and CharInfo.avgItemLevelPvp > CharInfo.avgItemLevel then
						textCENT = textCENT..E.Green_Color.."+|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				----------------------------------------------------------------
				textLEFT = STAT_AVERAGE_ITEM_LEVEL
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	if Octo_ToDo_DB_Vars.WasOnline == true then
		tinsert(OctoTable_func_otrisovka, function(CharInfo)
				----------------------------------------------------------------
				local textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT = "", nil, nil, "", {}, nil
				----------------------------------------------------------------
				local color = "|cffFFFFFF"
				if CharInfo.loginHour and CharInfo.loginDay then
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {"Время после релоуда: "..CharInfo.classColorHex.. E.func_SecondsToClock(GetServerTime() - CharInfo.time).."|r"}
						tooltipRIGHT[#tooltipRIGHT+1] = {string.format(TIME_PLAYED_ALERT, CharInfo.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r" )}
					else
						if CharInfo.needResetWeekly == true then
							color = E.Gray_Color
						elseif CharInfo.needResetDaily == true then
							color = E.Red_Color
						end
						textCENT = color..E.FriendsFrame_GetLastOnline(CharInfo.time).."|r"
						tooltipRIGHT[#tooltipRIGHT+1] = {color..E.FriendsFrame_GetLastOnlineText(CharInfo.time, CharInfo.classColorHex).."|r"}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", " "}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", color..CharInfo.loginDay.."|r"}
						tooltipRIGHT[#tooltipRIGHT+1] = {" ", color..CharInfo.loginHour.."|r"}
					end
				end
				textLEFT = L["Was online"]
				----------------------------------------------------------------
				----------------------------------------------------------------
				return textLEFT, iconLEFT, colorLEFT, textCENT, tooltipRIGHT, colorCENT
				----------------------------------------------------------------
		end)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	return OctoTable_func_otrisovka
end