local GlobalAddonName, E = ...
local L = LibStub("AceLocale-3.0"):GetLocale(E.MainAddonName)
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
	local usedSlots_BANK               = pd.usedSlots_BANK
	local totalSlots_BANK              = pd.totalSlots_BANK
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
		if usedSlots_BANK and totalSlots_BANK then
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
