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
function E.CreateTooltipPlayers(CharInfo)
	local tooltip = {}
	-- Basic character information
	if CharInfo.Name and CharInfo.curServer and CharInfo.specIcon and CharInfo.classColorHex and CharInfo.specName and CharInfo.RaceLocal then
		-- Name and guild info
		if CharInfo.guildRankIndex ~= 0 then
			tooltip[#tooltip+1] = {
				CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")",
				"<"..E.Green_Color..CharInfo.guildName.."|r"..">".." ["..E.Green_Color..CharInfo.guildRankName.."|r".."]"
			}
		else
			tooltip[#tooltip+1] = {
				CharInfo.classColorHex..CharInfo.Name.."|r ("..CharInfo.curServer..")",
				" "
			}
		end
		-- War mode status
		if CharInfo.WarMode == true then
			tooltip[#tooltip+1] = {
				CharInfo.WarMode and E.Green_Color..ERR_PVP_WARMODE_TOGGLE_ON.."|r" or ""
			}
		end
		-- Level and race info
		if CharInfo.UnitLevel ~= E.currentMaxLevel and CharInfo.UnitXPPercent then
			tooltip[#tooltip+1] = {
				CharInfo.RaceLocal.." "..CharInfo.classColorHex..CharInfo.UnitLevel.."-го|r уровня "..CharInfo.classColorHex..CharInfo.UnitXPPercent.."%|r",
				" "
			}
		else
			tooltip[#tooltip+1] = {
				CharInfo.RaceLocal,
				" "
			}
		end
		-- Spec and class info
		if CharInfo.specName ~= 0 or CharInfo.specName ~= 0 then
			tooltip[#tooltip+1] = {
				E.func_texturefromIcon(CharInfo.specIcon)..CharInfo.specName.." "..CharInfo.className,
				" "
			}
		end
		tooltip[#tooltip+1] = {" ", " "}
	end
	-- Chromie time info
	if CharInfo.Chromie_name ~= nil and CharInfo.Chromie_name ~= "" then
		tooltip[#tooltip+1] = {E.Red_Color..CharInfo.Chromie_name.."|r"}
		tooltip[#tooltip+1] = {" ", " "}
	end
	-- Location info
	if CharInfo.BindLocation ~= 0 then
		tooltip[#tooltip+1] = {
			E.func_texturefromIcon(134414)..L["Bind Location"],
			CharInfo.BindLocation
		}
	end
	if CharInfo.CurrentLocation ~= 0 then
		tooltip[#tooltip+1] = {
			E.func_texturefromIcon(132319)..L["Current Location"],
			CharInfo.CurrentLocation
		}
	end
	-- Inventory info
	if CharInfo.totalSlots ~= 0 then
		tooltip[#tooltip+1] = {
			E.func_texturefromIcon(133634)..L["Bags"],
			CharInfo.classColorHex..(CharInfo.usedSlots.."/"..CharInfo.totalSlots).."|r"
		}
	end
	-- Quests info
	if CharInfo.maxNumQuestsCanAccept ~= 0 then
		tooltip[#tooltip+1] = {
			E.func_texturefromIcon(236664)..QUESTS_LABEL,
			CharInfo.classColorHex..(CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept).."|r"
		}
	end
	-- Play time info
	if CharInfo.realTotalTime ~= 0 and CharInfo.realLevelTime ~= 0 then
		tooltip[#tooltip+1] = {" ", " "}
		tooltip[#tooltip+1] = {
			string.format(TIME_PLAYED_TOTAL, CharInfo.classColorHex..E.func_SecondsToClock(CharInfo.realTotalTime)).."|r"
		}
		tooltip[#tooltip+1] = {
			string.format(TIME_PLAYED_LEVEL, CharInfo.classColorHex..E.func_SecondsToClock(CharInfo.realLevelTime)).."|r"
		}
	end
	-- Special item info
	if CharInfo.MASLENGO.ItemsInBag[122284] ~= nil then
		tooltip[#tooltip+1] = {" ", " "}
		tooltip[#tooltip+1] = {
			E.func_GetItemIconByID(122284)..E.func_GetItemNameByID(122284),
			CharInfo.MASLENGO.ItemsInBag[122284]
		}
	end
	-- Reload count
	if CharInfo.ReloadCount ~= 0 then
		tooltip[#tooltip+1] = {
			"Reload Count: "..CharInfo.classColorHex..CharInfo.ReloadCount.."|r"
		}
	end
	-- Debug information
	if E.DebugInfo then
		tooltip[#tooltip+1] = {" ", " "}
		tooltip[#tooltip+1] = {E.DEVTEXT, " "}
		-- Character identification
		tooltip[#tooltip+1] = {
			E.Purple_Color.."GUID".."|r",
			E.Purple_Color..CharInfo.GUID.."|r"
		}
		if CharInfo.hasMail ~= false then
			tooltip[#tooltip+1] = {
				"hasMail",
				E.func_texturefromIcon(E.Icon_MailBox)..CharInfo.classColorHex.."true|r"
			}
		end
		-- Chromie time debug info
		tooltip[#tooltip+1] = {
			"Chromie_canEnter",
			CharInfo.Chromie_canEnter and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"
		}
		tooltip[#tooltip+1] = {
			"Chromie_UnitChromieTimeID",
			CharInfo.Chromie_UnitChromieTimeID.."|r"
		}
		if CharInfo.Chromie_name ~= nil then
			tooltip[#tooltip+1] = {
				"Chromie_name",
				CharInfo.classColorHex..CharInfo.Chromie_name.."|r"
			}
		end
		-- BattleTag info
		tooltip[#tooltip+1] = {
			"BattleTag",
			E.Blue_Color..CharInfo.BattleTag.."|r"
		}
		tooltip[#tooltip+1] = {
			"BattleTagLocal",
			E.Blue_Color..CharInfo.BattleTagLocal.."|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Account restrictions
		tooltip[#tooltip+1] = {
			"GameLimitedMode_IsActive",
			CharInfo.GameLimitedMode_IsActive and E.Green_Color.."true|r" or E.Red_Color.."false|r"
		}
		tooltip[#tooltip+1] = {
			"levelCapped20",
			CharInfo.levelCapped20 and E.Green_Color.."true|r" or E.Red_Color.."false|r"
		}
		tooltip[#tooltip+1] = {
			"PlayerCanEarnExperience",
			CharInfo.PlayerCanEarnExperience and E.Green_Color.."true|r" or E.Red_Color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Build info
		tooltip[#tooltip+1] = {
			"buildVersion",
			CharInfo.classColorHex..CharInfo.buildVersion.."|r"
		}
		tooltip[#tooltip+1] = {
			"buildNumber",
			CharInfo.classColorHex..CharInfo.buildNumber.."|r"
		}
		tooltip[#tooltip+1] = {
			"buildDate",
			CharInfo.classColorHex..CharInfo.buildDate.."|r"
		}
		tooltip[#tooltip+1] = {
			"interfaceVersion",
			CharInfo.classColorHex..CharInfo.interfaceVersion.."|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Version info
		tooltip[#tooltip+1] = {
			"currentTier",
			CharInfo.classColorHex..CharInfo.currentTier.."|r"
		}
		tooltip[#tooltip+1] = {
			"IsPublicBuild",
			CharInfo.IsPublicBuild and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"
		}
		tooltip[#tooltip+1] = {
			"isBeta",
			CharInfo.isBeta and CharInfo.classColorHex.."true|r" or E.Gray_Color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Account limits
		tooltip[#tooltip+1] = {
			"max LVL",
			CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rLevel).."|r"
		}
		tooltip[#tooltip+1] = {
			"max Money",
			CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_rMoney).."|r"
		}
		tooltip[#tooltip+1] = {
			"max Prof",
			CharInfo.classColorHex..tostringall(CharInfo.GetRestrictedAccountData_profCap).."|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Account security
		tooltip[#tooltip+1] = {
			"Authenticator",
			CharInfo.classColorHex..tostringall(CharInfo.IsAccountSecured).."|r"
		}
		tooltip[#tooltip+1] = {
			"УЗ имеет ограничения пробной УЗ",
			CharInfo.classColorHex..tostringall(CharInfo.IsRestrictedAccount).."|r"
		}
		tooltip[#tooltip+1] = {
			"Использует ли игрок пробную УЗ",
			CharInfo.classColorHex..tostringall(CharInfo.IsTrialAccount).."|r"
		}
		tooltip[#tooltip+1] = {
			"Нет игрового времени",
			CharInfo.classColorHex..tostringall(CharInfo.IsVeteranTrialAccount).."|r"
		}
		tooltip[#tooltip+1] = {" ", " "}
		-- Durability
		tooltip[#tooltip+1] = {
			"PlayerDurability",
			CharInfo.PlayerDurability.."%"
		}
	end
	return tooltip
end
function E:func_Otrisovka()
	local OctoTable_func_otrisovkaCENT = {}
	local OctoTable_func_otrisovkaLEFT = {}
	local function Universal(expansionID)
		for expID, expDATA in ipairs(E.OctoTable_Expansions) do
			if expID == expansionID then
				for _, v in ipairs(E.OctoTable_UniversalQuest) do
					if expDATA.nameShort == v.desc then
						tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
								local textCENT, tooltip, colorCENT = "", {}, nil
								if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
									textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
								end
								if CharInfo.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
									end
								end
								return textCENT, tooltip, colorCENT
						end)
						tinsert(OctoTable_func_otrisovkaLEFT, function()
								return tostringall(v.textleft).."|r", v.icon, expDATA.color
						end)
					end
				end
			end
		end
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[11] then
		Universal(11)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.CurrentKeyName and CharInfo.CurrentKeyName ~= 0 then
					tooltip[#tooltip+1] = {E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKeyLevel.." "..CharInfo.CurrentKeyName.."|r", ""}
				end
				if CharInfo.RIO_Score ~= 0 then
					tooltip[#tooltip+1] = {" ", " "}
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
								tooltip[#tooltip+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold.." "..E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.MASLENGO.GreatVault[i].hyperlink_STRING.."|r"}
							elseif CharInfo.MASLENGO.GreatVault[i].progress ~= 0 then
								tooltip[#tooltip+1] = {CharInfo.MASLENGO.GreatVault[i].type, CharInfo.MASLENGO.GreatVault[i].progress.."/"..CharInfo.MASLENGO.GreatVault[i].threshold}
							end
						end
					end
					tooltip[#tooltip+1] = {" ", " "}
					tooltip[#tooltip+1] = {"Weekly Best:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_weeklyBest.."|r"}
					tooltip[#tooltip+1] = {"RIO Score:", E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.RIO_Score.."|r"}
				end
				if CharInfo.CurrentKey ~= 0 then
					textCENT = E.func_RIOColor(CharInfo.RIO_Score)..CharInfo.CurrentKey.."|r"
				end
				if CharInfo.HasAvailableRewards then
					textCENT = textCENT..E.Blue_Color..">Vault<|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.WOW_Epic_Color..L["Mythic Keystone"].."|r", 4352494
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[10] then
		Universal(10)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[209856] ~= nil then
					textCENT = textCENT..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[209856].."|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(209856), E.func_GetItemIconByID(209856)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[207002] ~= nil then
					textCENT = E.WOW_Rare_Color..CharInfo.MASLENGO.ItemsInBag[207002].."|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(207002), E.func_GetItemIconByID(207002)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[2594] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2594]
				end
				if CharInfo.MASLENGO.ItemsInBag[208945] ~= nil then
					textCENT = textCENT..E.WOW_WoWToken_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208945].."|r"..E.func_GetItemIconByID(208945)
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2594), E.func_GetCurrencyIcon(2594)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[210254] ~= nil then
					textCENT = textCENT..E.WOW_Epic_Color..CharInfo.MASLENGO.ItemsInBag[210254].."|r"
				end
				if CharInfo.MASLENGO.ItemsInBag[208153] ~= nil then
					textCENT = textCENT..E.Gray_Color.." +"..CharInfo.MASLENGO.ItemsInBag[208153].."(old)|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.WOW_Epic_Color..E.func_GetItemNameByID(210254).."|r", E.func_GetItemIconByID(210254)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[2245] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2245]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2245), E.func_GetCurrencyIcon(2245)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[213089] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[213089]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(213089), E.func_GetItemIconByID(213089)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[211516] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211516]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(211516), E.func_GetItemIconByID(211516)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[211515] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[211515]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(211515), E.func_GetItemIconByID(211515)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[9] then
		Universal(9)
		local colorCENT
		for kCovenant = 1, 2 do
			for iANIMA = 1, 4 do
				tinsert(OctoTable_func_otrisovkaCENT,
					function(CharInfo)
						local textCENT, tooltip, colorCENT = "", {}, nil
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
						return textCENT, tooltip, colorCENT
				end)
				tinsert(OctoTable_func_otrisovkaLEFT,
					function(CharInfo)
						local vivodLeft = E.OctoTable_Covenant[iANIMA].color..E.OctoTable_Covenant[iANIMA].name.."|r"
						if kCovenant == 2 then
							vivodLeft = vivodLeft.. E.func_texturefromIcon(E.func_GetCurrencyIcon(1813))
						end
						return vivodLeft, E.OctoTable_Covenant[iANIMA].icon
				end)
			end
		end
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[2009] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[2009]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(2009), E.func_GetCurrencyIcon(2009)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1906] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1906]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1906), E.func_GetCurrencyIcon(1906)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1828] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1828]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1828), E.func_GetCurrencyIcon(1828)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1979] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1979]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1979), E.func_GetCurrencyIcon(1979)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1931] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1931]
				end
				if CharInfo.Possible_CatalogedResearch ~= 0 then
					textCENT = textCENT..E.Purple_Color.." +"..CharInfo.Possible_CatalogedResearch.."|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1931), E.func_GetCurrencyIcon(1931)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[8] then
		Universal(8)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1560] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1560]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1560), E.func_GetCurrencyIcon(1560)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1721] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1721]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1721), E.func_GetCurrencyIcon(1721)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1803] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1803]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1803), E.func_GetCurrencyIcon(1803)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1755] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1755]
				end
				if CharInfo.MASLENGO.ItemsInBag[173363] ~= nil then
					textCENT = textCENT.." +"..CharInfo.MASLENGO.ItemsInBag[173363]..E.func_GetItemIconByID(173363)
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1755), E.func_GetCurrencyIcon(1755)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1719] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1719]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1719), E.func_GetCurrencyIcon(1719)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1710] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1710]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1710), E.func_GetCurrencyIcon(1710)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1716] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1716]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1716), E.func_GetCurrencyIcon(1716)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1718]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1718), E.func_GetCurrencyIcon(1718)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[158075] == nil then
					textCENT = E.Red_Color.."no neck|r"
				else
					textCENT = E.Orange_Color.."neeed to equip|r"
					if CharInfo.azeriteLVL ~= 0 then
						textCENT = E.Green_Color..CharInfo.azeriteLVL.."|r".."+"..E.Gray_Color..CharInfo.azeriteEXP.."|r"
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(158075), E.func_GetItemIconByID(158075)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
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
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(169223), E.func_GetItemIconByID(169223)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.islandBfA ~= nil then
					textCENT = CharInfo.MASLENGO.islandBfA
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				local questID = C_IslandsQueue.GetIslandsWeeklyQuestID()
				if questID then
					return E.func_questName(questID)
				else
					return "All_BfA_Island"
				end
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166846))..E.func_GetItemNameByID(166846), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166846])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(169610))..E.func_GetItemNameByID(169610), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[169610])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166970))..E.func_GetItemNameByID(166970), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166970])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168327))..E.func_GetItemNameByID(168327), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168327])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168832))..E.func_GetItemNameByID(168832), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168832])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(166971))..E.func_GetItemNameByID(166971), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[166971])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168946))..E.func_GetItemNameByID(168946), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168946])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168215))..E.func_GetItemNameByID(168215), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168215])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168216))..E.func_GetItemNameByID(168216), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168216])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(168217))..E.func_GetItemNameByID(168217), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[168217])}
				textCENT = "МЕХАГОН"
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return "МЕХАГОН"
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[7] then
		Universal(7)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1273] then
					textCENT = CharInfo.MASLENGO.CurrencyID_Total[1273]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1273), E.func_GetCurrencyIcon(1273)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1508] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID_Total[1508]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1508), E.func_GetCurrencyIcon(1508)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1342]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1342), E.func_GetCurrencyIcon(1342)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1220]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1220), E.func_GetCurrencyIcon(1220)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1226]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1226), E.func_GetCurrencyIcon(1226)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1533]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1533), E.func_GetCurrencyIcon(1533)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				textCENT = CharInfo.MASLENGO.CurrencyID_Total[1155]
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1155), E.func_GetCurrencyIcon(1155)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[124124] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[124124]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(124124), E.func_GetItemIconByID(124124)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[6] then
		Universal(6)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1129] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1129]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(1129), E.func_GetCurrencyIcon(1129)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[994] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[994]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(994), E.func_GetCurrencyIcon(994)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[823] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[823]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(823), E.func_GetCurrencyIcon(823)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[1101] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[1101]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(1101), E.func_GetCurrencyIcon(1101)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[824] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[824]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_currencyName(824), E.func_GetCurrencyIcon(824)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114128))..E.func_GetItemNameByID(114128), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114128])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114129))..E.func_GetItemNameByID(114129), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114129])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114131))..E.func_GetItemNameByID(114131), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114131])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114616))..E.func_GetItemNameByID(114616), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114616])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114081))..E.func_GetItemNameByID(114081), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114081])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114622))..E.func_GetItemNameByID(114622), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114622])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(128307))..E.func_GetItemNameByID(128307), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128307])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(120313))..E.func_GetItemNameByID(120313), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[120313])}
				tooltip[#tooltip+1] = {" ", " "}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114745))..E.func_GetItemNameByID(114745), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114745])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114808))..E.func_GetItemNameByID(114808), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114808])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114822))..E.func_GetItemNameByID(114822), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114822])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114807))..E.func_GetItemNameByID(114807), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114807])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114806))..E.func_GetItemNameByID(114806), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114806])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(114746))..E.func_GetItemNameByID(114746), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[114746])}
				tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(128308))..E.func_GetItemNameByID(128308), E.func_EmptyZero(CharInfo.MASLENGO.ItemsInBag[128308])}
				textCENT = SPELL_UPGRADE
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return GARRISON_FOLLOWERS_TITLE
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.OctoTable_QuestID[38242] ~= nil then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[38242]
				end
				if CharInfo.MASLENGO.ItemsInBag[122457] ~= nil then
					textCENT = textCENT.."+"..CharInfo.MASLENGO.ItemsInBag[122457]..E.func_GetItemIconByID(122457)
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(38242).." (ап пета)"
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.OctoTable_QuestID[39246] ~= nil then
					textCENT = CharInfo.MASLENGO.OctoTable_QuestID[39246]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_questName(39246)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[5] then
		Universal(5)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[697] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[697]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(697), E.func_GetCurrencyIcon(697)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.CurrencyID[776] ~= nil then
					textCENT = CharInfo.MASLENGO.CurrencyID[776]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.Blue_Color.."("..L["Coins"]..") |r"..E.func_currencyName(776), E.func_GetCurrencyIcon(776)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[4] then
		Universal(4)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[52078] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[52078]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(52078), E.func_GetItemIconByID(52078)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[69237] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[69237]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(69237), E.func_GetItemIconByID(69237)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[71998] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[71998]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(71998), E.func_GetItemIconByID(71998)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[3] then
		Universal(3)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[45087] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[45087]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(45087), E.func_GetItemIconByID(45087)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[47556] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[47556]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(47556), E.func_GetItemIconByID(47556)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[49908] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[49908]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(49908), E.func_GetItemIconByID(49908)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[2] then
		Universal(2)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(23572), E.func_GetItemIconByID(23572)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[30183] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[30183]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(30183), E.func_GetItemIconByID(30183)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[32428] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[32428]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(32428), E.func_GetItemIconByID(32428)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[34664] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[34664]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(34664), E.func_GetItemIconByID(34664)
		end)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[24581] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[24581]
				elseif CharInfo.MASLENGO.ItemsInBag[24579] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[24579]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(24581), E.func_GetItemIconByID(24581)
		end)
	end
	if Octo_ToDo_DB_Vars.ExpansionToShow[2] then
		Universal(1)
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.MASLENGO.ItemsInBag[23572] ~= nil then
					textCENT = CharInfo.MASLENGO.ItemsInBag[23572]
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.func_GetItemNameByID(23572), E.func_GetItemIconByID(23572)
		end)
	end
	if Octo_ToDo_DB_Vars.Holidays then
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[181] then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					local v = Octo_ToDo_DB_Other.Holiday[181]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil
					local v = Octo_ToDo_DB_Other.Holiday[181]

					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 181|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if v.desc == "HolidaysNoblegarden" then
					tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
							local textCENT, tooltip, colorCENT = "", {}, nil
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							end
							if CharInfo.GUID == E.curGUID then
								for index, questID in ipairs(v.questID) do
									tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
								end
							end
							return textCENT, tooltip, colorCENT
					end)
					tinsert(OctoTable_func_otrisovkaLEFT, function()
							local textLEFT, iconLEFT, colorLEFT = "", nil, nil

							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = E.Holiday_Color

							return textLEFT, iconLEFT, colorLEFT
					end)
				end
			end
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					if CharInfo.MASLENGO.ItemsInBag[44791] ~= nil then
						textCENT = CharInfo.MASLENGO.ItemsInBag[44791]
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil

					textLEFT = E.func_GetItemNameByID(44791)
					iconLEFT = E.func_GetItemIconByID(44791)
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					if CharInfo.MASLENGO.ItemsInBag[45072] ~= nil then
						textCENT = CharInfo.MASLENGO.ItemsInBag[45072]
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil

					textLEFT = E.func_GetItemNameByID(45072)
					iconLEFT = E.func_GetItemIconByID(45072)
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		local TimewalkHolidayTBL = {1265, 652, 622} -- 1458 Бурные потоки
		for _, HolidayID in ipairs(TimewalkHolidayTBL) do
			if Octo_ToDo_DB_Other.ActiveHoliday[HolidayID] then
				tinsert(OctoTable_func_otrisovkaCENT,
					function(CharInfo)
						local textCENT, tooltip, colorCENT = "", {}, nil
						local v = Octo_ToDo_DB_Other.Holiday[HolidayID]
						if CharInfo.GUID == E.curGUID then
							textCENT = E.Event_Color..v.startTime.." - "..v.endTime.."|r"
						end
						return textCENT, tooltip, colorCENT
				end)
				tinsert(OctoTable_func_otrisovkaLEFT,
					function(CharInfo)
						local textLEFT, iconLEFT, colorLEFT = "", nil, nil
						local v = Octo_ToDo_DB_Other.Holiday[HolidayID]

						textLEFT = v.invitedBy..E.Event_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id:"..HolidayID.."|r" or "")
						iconLEFT = v.iconTexture
						colorLEFT = E.Event_Color

						return textLEFT, iconLEFT, colorLEFT
				end)
				for _, v in ipairs(E.OctoTable_UniversalQuest) do
					if v.desc == "HolidaysTimewalk" then
						tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
								local textCENT, tooltip, colorCENT = "", {}, nil
								if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
									textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
								end
								if CharInfo.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
									end
								end
								return textCENT, tooltip, colorCENT
						end)
						tinsert(OctoTable_func_otrisovkaLEFT, function()
								local textLEFT, iconLEFT, colorLEFT = "", nil, nil

								textLEFT = E.func_texturefromIcon(E.Icon_LFG) .. tostringall(v.textleft).."|r"
								iconLEFT = v.icon
								colorLEFT = E.Event_Color

								return textLEFT, iconLEFT, colorLEFT
						end)
					end
				end
				tinsert(OctoTable_func_otrisovkaCENT,
					function(CharInfo)
						local textCENT, tooltip, colorCENT = "", {}, nil
						if CharInfo.MASLENGO.CurrencyID[1166] ~= nil then
							textCENT = CharInfo.MASLENGO.CurrencyID[1166]
						end
						return textCENT, tooltip, colorCENT
				end)
				tinsert(OctoTable_func_otrisovkaLEFT,
					function(CharInfo)
						local textLEFT, iconLEFT, colorLEFT = "", nil, nil
						local colorCENT = E.Event_Color

						textLEFT = E.func_currencyName(1166)
						iconLEFT = E.func_GetCurrencyIcon(1166)
						colorLEFT = E.Event_Color

						return textLEFT, iconLEFT, colorLEFT
				end)
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[201] then
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					local v = Octo_ToDo_DB_Other.Holiday[201]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil
					local v = Octo_ToDo_DB_Other.Holiday[201]

					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 201|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if v.desc == "HolidaysChildrensWeek" then
					tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
							local textCENT, tooltip, colorCENT = "", {}, nil
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
								if CharInfo.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
									end
								end
							end
							return textCENT, tooltip, colorCENT
					end)
					tinsert(OctoTable_func_otrisovkaLEFT, function()
							local textLEFT, iconLEFT, colorLEFT = "", nil, nil
							local colorCENT = E.Holiday_Color

							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT =  v.icon

							return textLEFT, iconLEFT, colorLEFT
					end)
				end
			end
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[341] then -- СОЛНЦЕВОРОТ
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					local v = Octo_ToDo_DB_Other.Holiday[341]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Holiday_Color..v.startTime.." - "..v.endTime.."|r"
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil
					local v = Octo_ToDo_DB_Other.Holiday[341]
					textLEFT = v.invitedBy..E.Holiday_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 341|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if v.desc == "HolidaysMidsummerFireFestival" then
					tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
							local textCENT, tooltip, colorCENT = "", {}, nil
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
								if CharInfo.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
									end
								end
							end
							return textCENT, tooltip, colorCENT
					end)
					tinsert(OctoTable_func_otrisovkaLEFT, function()
							local textLEFT, iconLEFT, colorLEFT = "", nil, nil

							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = E.Holiday_Color

							return textLEFT, iconLEFT, colorLEFT
					end)
				end
				if v.desc == "TheSpinnerofSummerTales" then
					tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
							local textCENT, tooltip, colorCENT = "", {}, nil
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
								if CharInfo.GUID == E.curGUID then
									for index, questID in ipairs(v.questID) do
										tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
									end
								end
							end
							return textCENT, tooltip, colorCENT
					end)
					tinsert(OctoTable_func_otrisovkaLEFT, function()
							local textLEFT, iconLEFT, colorLEFT = "", nil, nil

							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = E.Holiday_Color

							return textLEFT, iconLEFT, colorLEFT
					end)
				end
			end
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					if CharInfo.MASLENGO.LFGInstance[286] and CharInfo.MASLENGO.LFGInstance[286].donetoday ~= nil then
						textCENT = textCENT .. CharInfo.MASLENGO.LFGInstance[286].donetoday
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil

					textLEFT = E.func_texturefromIcon(E.Icon_LFG) .. E.func_LFGdungName(286)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					if CharInfo.MASLENGO.ItemsInBag[23247] ~= nil then
						textCENT = textCENT..CharInfo.MASLENGO.ItemsInBag[23247]
					end

					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil

					textLEFT = E.func_GetItemNameByID(23247)
					iconLEFT = E.func_GetItemIconByID(23247)
					colorLEFT = E.Holiday_Color

					return textLEFT, iconLEFT, colorLEFT
			end)
		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------
		if Octo_ToDo_DB_Other.ActiveHoliday[1691] then -- Алчный посланец
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					local v = Octo_ToDo_DB_Other.Holiday[1691]
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Red_Color..v.startTime.." - "..v.endTime.."|r"
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil
					local v = Octo_ToDo_DB_Other.Holiday[1691]

					textLEFT = v.invitedBy..E.Red_Color..v.title.."|r".. E.White_Color.." ("..v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.." id: 1691|r" or "")
					iconLEFT = v.iconTexture
					colorLEFT = E.Red_Color

					return textLEFT, iconLEFT, colorLEFT
			end)




			for _, v in ipairs(E.OctoTable_UniversalQuest) do
				if v.desc == "HolidaysAGreedyEmissary" then
					tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
							local textCENT, tooltip, colorCENT = "", {}, nil
							if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
								textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							end
							if CharInfo.GUID == E.curGUID then
								for index, questID in ipairs(v.questID) do
									tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
								end
							end
							return textCENT, tooltip, colorCENT
					end)
					tinsert(OctoTable_func_otrisovkaLEFT, function()
							local textLEFT, iconLEFT, colorLEFT = "", nil, nil

							textLEFT = tostringall(v.textleft).."|r"
							iconLEFT = v.icon
							colorLEFT = E.Red_Color

							return textLEFT, iconLEFT, colorLEFT
					end)
				end
			end




			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					if CharInfo.MASLENGO.CurrencyID[3309] ~= nil then
						textCENT = CharInfo.MASLENGO.CurrencyID[3309]
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					local textLEFT, iconLEFT, colorLEFT = "", nil, nil

					textLEFT = E.func_currencyName(3309)
					iconLEFT = E.func_GetCurrencyIcon(3309)
					colorLEFT = E.Red_Color

					return textLEFT, iconLEFT, colorLEFT
			end)

		end
		----------------------------------------------------------------
		----------------------------------------------------------------
		----------------------------------------------------------------







	end
	if Octo_ToDo_DB_Vars.DebugInfo == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				for _, v in next, (E.OctoTable_UniversalQuest) do
					if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] == E.DONE then
						tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
					end
				end
				if #tooltip ~= 0 then
					textCENT = E.Green_Color.."Выполненные|r"
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return E.DEVTEXT..E.Blue_Color.."ALL|r"
		end)
		local list = {}
		for _, v in next, (E.OctoTable_UniversalQuest) do
			tinsert(list, v.desc)
		end
		E.func_TableRemoveDuplicates(list)
		tsort(list)
		for i, value in ipairs(list) do
			tinsert(OctoTable_func_otrisovkaCENT,
				function(CharInfo)
					local textCENT, tooltip, colorCENT = "", {}, nil
					tooltip[#tooltip+1] = {E.DEVTEXT, ""}
					for _, v in next, (E.OctoTable_UniversalQuest) do
						if v.desc == value then
							tooltip[#tooltip+1] = {tostringall("Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset), CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]}
							textCENT = value
						end
					end
					return textCENT, tooltip, colorCENT
			end)
			tinsert(OctoTable_func_otrisovkaLEFT,
				function(CharInfo)
					return E.DEVTEXT..i
			end)
		end
	end
	if Octo_ToDo_DB_Vars.Quests == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.numQuests ~= 0 then
					textCENT = CharInfo.classColorHex..CharInfo.numQuests.."/"..CharInfo.maxNumQuestsCanAccept.."|r"
					local questIDs = {}
					for questID in next, CharInfo.MASLENGO.Quests do
						questIDs[#questIDs+1] = questID
					end
					tsort(questIDs, E.func_Reverse_order)
					for i = 1, #questIDs do
						local questID = questIDs[i]
						tooltip[i] = {E.func_questName(questID), CharInfo.MASLENGO.Quests[questID]}
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return QUESTS_LABEL
		end)
		for _, v in ipairs(E.OctoTable_UniversalQuest) do
			if v.desc == "Storyline" then
				tinsert(OctoTable_func_otrisovkaCENT, function(CharInfo)
						local textCENT, tooltip, colorCENT = "", {}, nil
						if CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset] ~= nil then
							textCENT = CharInfo.MASLENGO.UniversalQuest["Octopussy_"..v.desc.."_"..v.name_save.."_"..v.reset]
							if CharInfo.GUID == E.curGUID then
								for index, questID in ipairs(v.questID) do
									tooltip[#tooltip+1] = {index..". "..E.func_questName(questID), E.func_CheckCompletedByQuestID(questID)}
								end
							end
						end
						return textCENT, tooltip, colorCENT
				end)
				tinsert(OctoTable_func_otrisovkaLEFT, function()
						return tostringall(v.textleft).."|r", v.icon, E.Holiday_Color
				end)
			end
		end
	end
	if Octo_ToDo_DB_Vars.Dungeons == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				local ServerTime = GetServerTime()
				for instanceID, v in next, (CharInfo.MASLENGO.journalInstance) do
					if v then
						for difficultyID, w in next, (v) do
							if w.vivod ~= nil then
								tooltip[#tooltip+1] = {w.instanceName.."("..w.difficultyName..") "..E.Red_Color..E.func_SecondsToClock(w.instanceReset-ServerTime).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..instanceID.."|r" or ""), w.vivod}
							end
						end
					end
				end
				for dungeonID, v in next, (CharInfo.MASLENGO.LFGInstance) do
					if v then
						if CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday ~= nil then
							tooltip[#tooltip+1] = {CharInfo.MASLENGO.LFGInstance[dungeonID].D_name..(E.DebugIDs and E.Gray_Color.. " id:"..dungeonID.."|r" or ""), CharInfo.MASLENGO.LFGInstance[dungeonID].donetoday}
						end
					end
				end
				for worldBossID, v in next, (CharInfo.MASLENGO.SavedWorldBoss) do
					if v then
						tooltip[#tooltip+1] = {E.func_texturefromIcon(E.Icon_WorldBoss).. v.name .." ".. E.Red_Color..E.func_SecondsToClock(v.reset).."|r"..(E.DebugIDs and E.Gray_Color.. " id:"..worldBossID.."|r" or ""), " "}
					end
				end
				if #tooltip ~= 0 then
					textCENT = E.Gray_Color..DUNGEONS.."|r"
				else
					textCENT = ""
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return DUNGEONS
		end)
	end
	if Octo_ToDo_DB_Vars.Items == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				for index, itemID in ipairs(E.OctoTable_itemID_ALL) do
					if CharInfo.MASLENGO.ItemsInBag[itemID] ~= nil then
						tooltip[#tooltip+1] = {E.func_texturefromIcon(E.func_GetItemIconByID(itemID))..E.func_GetItemNameByID(itemID), CharInfo.MASLENGO.ItemsInBag[itemID]}
					end
				end
				if #tooltip ~= 0 then
					textCENT = E.Gray_Color..ITEMS.."|r"
				else
					textCENT = ""
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return ITEMS
		end)
	end
	if Octo_ToDo_DB_Vars.Professions == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
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
						tooltip[#tooltip+1] = {leftText, RightText}
						if charProf[i].child ~= nil then
							for expIndex, v in ipairs(charProf[i].child) do
								if v.QWEskillLevel ~= nil and v.QWEskillLevel ~= 0 and v.QWEprofessionName ~= nil then
									for expI, j in ipairs(E.OctoTable_Expansions) do
										if expIndex == j.revers then
											tooltip[#tooltip+1] = {"     "..E.func_texturefromIcon(j.icon).." "..j.color..j.nameVeryShort.."|r ", v.QWEskillLevel.."/"..v.QWEmaxSkillLevel}
										end
									end
								end
							end
						end
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return PROFESSIONS_BUTTON
		end)
	end
	if Octo_ToDo_DB_Vars.Gold == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				if CharInfo.Money then
					textCENT = E.func_CompactNumberFormat(CharInfo.Money/10000)
				end
				if CharInfo.MoneyOnLogin ~= 0 then
					if CharInfo.Money < CharInfo.MoneyOnLogin then
						textCENT = textCENT..E.Red_Color.."-|r"
						tooltip[#tooltip+1] = {"lost: ", E.Red_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					elseif CharInfo.Money > CharInfo.MoneyOnLogin then
						textCENT = textCENT..E.Green_Color.."+|r"
						tooltip[#tooltip+1] = {"received: ", E.Green_Color..E.func_CompactNumberFormat((CharInfo.Money - CharInfo.MoneyOnLogin)/10000).."|r "..E.func_texturefromIcon(E.Icon_Money)}
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return BONUS_ROLL_REWARD_MONEY, E.Icon_Money
		end)
	end
	if Octo_ToDo_DB_Vars.ItemLevel == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
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
						tooltip[#tooltip+1] = {string.format(LFG_LIST_ITEM_LEVEL_CURRENT_PVP, CharInfo.avgItemLevelPvp)}
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return STAT_AVERAGE_ITEM_LEVEL
		end)
	end
	if Octo_ToDo_DB_Vars.WasOnline == true then
		tinsert(OctoTable_func_otrisovkaCENT,
			function(CharInfo)
				local textCENT, tooltip, colorCENT = "", {}, nil
				local color = "|cffFFFFFF"
				if CharInfo.loginHour and CharInfo.loginDay then
					if CharInfo.GUID == E.curGUID then
						textCENT = E.Green_Color..FRIENDS_LIST_ONLINE.."|r"
						tooltip[#tooltip+1] = {"Время после релоуда: "..CharInfo.classColorHex.. E.func_SecondsToClock(GetServerTime() - CharInfo.time).."|r"}
						tooltip[#tooltip+1] = {string.format(TIME_PLAYED_ALERT, CharInfo.classColorHex..E.func_SecondsToClock(GetSessionTime()).."|r"      )}
					else
						if CharInfo.needResetWeekly == true then
							color = E.Gray_Color
						elseif CharInfo.needResetDaily == true then
							color = E.Red_Color
						end
						textCENT = color..E.FriendsFrame_GetLastOnline(CharInfo.time).."|r"
						tooltip[#tooltip+1] = {color..E.FriendsFrame_GetLastOnlineText(CharInfo.time, CharInfo.classColorHex).."|r"}
						tooltip[#tooltip+1] = {" ", " "}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginDay.."|r"}
						tooltip[#tooltip+1] = {" ", color..CharInfo.loginHour.."|r"}
					end
				end
				return textCENT, tooltip, colorCENT
		end)
		tinsert(OctoTable_func_otrisovkaLEFT,
			function(CharInfo)
				return L["Was online"]
		end)
	end
	return OctoTable_func_otrisovkaCENT, OctoTable_func_otrisovkaLEFT
end