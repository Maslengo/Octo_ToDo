local GlobalAddonName, E = ...
local L = E.L

function E.func_Tooltip_Chars(CharInfo)
	local tooltip = {}
	local pd = CharInfo.PlayerData
	local color = E.COLOR_SKYBLUE
	local classColorHex = pd.classColorHex or E.COLOR_GREEN
	local Name = pd.Name or ""
	local curServer = pd.curServer or ""
	local guildName = pd.guildName or ""
	local guildRankName = pd.guildRankName or ""
	local guildRankIndex = pd.guildRankIndex or 0
	local PlayerDurability = pd.PlayerDurability or 100
	local RaceLocal = pd.RaceLocal or ""
	local UnitLevel = pd.UnitLevel or 0
	local UnitXPPercent = pd.UnitXPPercent or 0
	local WarMode = pd.WarMode or false
	local Chromie_name = pd.Chromie_name or ""
	local curLocation = pd.curLocation or ""
	local usedSlots_BAGS = pd.usedSlots_BAGS or 0
	local totalSlots_BAGS = pd.totalSlots_BAGS or 0
	local usedSlots_BANK = pd.usedSlots_BANK
	local totalSlots_BANK = pd.totalSlots_BANK
	local numQuests = pd.numQuests or 0
	local realTotalTime = pd.realTotalTime or 0
	local specIcon = pd.specIcon or 0
	local specTexture = E.func_texturefromIcon(specIcon)
	local durColor = E.func_GetColorGradient(PlayerDurability, 0, 100)

	local playerNameWithLevel = E.func_CharInfo_NickName(CharInfo, true)
	local playerServer = E.func_CharInfo_Server(CharInfo, true)
	local guild = E.func_CharInfo_Guild(CharInfo, true)
	local mail = E.func_CharInfo_Mail(CharInfo)
	local durability = E.func_CharInfo_Durability(CharInfo, true)


	if Name ~= "" and curServer ~= "" then
		tooltip[#tooltip + 1] = {
			specTexture..playerNameWithLevel.." "..playerServer,
			-- specTexture..classColorHex..Name.."|r ("..curServer..")",
			mail
		}
	end
	if guildName ~= "" and guildRankName ~= "" and guildRankIndex > 0 then
		tooltip[#tooltip + 1] = {
			guild
		}
	end

		tooltip[#tooltip + 1] = {
			STAT_AVERAGE_ITEM_LEVEL..": "..
			E.func_CharInfo_ItemLevel(CharInfo),
			durability
		}

	-- if RaceLocal ~= "" then
	-- 	if UnitLevel ~= E.currentMaxLevel and UnitXPPercent > 0 then
	-- 		tooltip[#tooltip + 1] = {
	-- 			format(TOOLTIP_UNIT_LEVEL_RACE, UnitLevel, RaceLocal)
	-- 		}
	-- 	else
	-- 		tooltip[#tooltip + 1] = { RaceLocal, "" }
	-- 	end
	-- end


	-- if WarMode then
	-- 	tooltip[#tooltip + 1] = {
	-- 		E.COLOR_SKYBLUE..ERR_PVP_WARMODE_TOGGLE_ON.."|r"
	-- 	}
	-- end


	if Chromie_name ~= "" then
		-- tooltip[#tooltip + 1] = { " ", " " }
		tooltip[#tooltip + 1] = {
			E.func_texturefromIcon("ChromieMap", nil, nil, true)..E.func_GetNPCName(167032)..": "..E.COLOR_GREEN..Chromie_name.."|r"
		}
	end


	-- if curLocation ~= "" then
	-- 	-- tooltip[#tooltip + 1] = { " ", " " }
	-- 	tooltip[#tooltip + 1] = {
	-- 		E.func_texturefromIcon(132319)..FRIENDS_LIST_ZONE..classColorHex..curLocation.."|r"
	-- 	}
	-- end


	-- if usedSlots_BAGS > 0 and totalSlots_BAGS > 0 then
	-- 	local icon = E.func_texturefromIcon(133634)
	-- 	local textLeft = icon..BAG_NAME_BACKPACK..": "..classColorHex..usedSlots_BAGS.."/"..totalSlots_BAGS.."|r"
	-- 	if usedSlots_BANK and totalSlots_BANK then
	-- 		textLeft = textLeft.." "..BANK..": "..classColorHex..usedSlots_BANK.."/"..totalSlots_BANK.."|r"
	-- 	end
	-- 	tooltip[#tooltip + 1] = { textLeft, "" }
	-- end


	if realTotalTime > 0 then
		tooltip[#tooltip + 1] = { " ", "" }
		tooltip[#tooltip + 1] = {
			string.format(TIME_PLAYED_TOTAL,classColorHex..E.func_SecondsToClock(realTotalTime)).."|r"
		}
	end


	-- if CharInfo.MASLENGO and CharInfo.MASLENGO.Items and CharInfo.MASLENGO.Items.Bags and CharInfo.MASLENGO.Items.Bags[122284] then
	-- 	tooltip[#tooltip + 1] = { " ", "" }
	-- 	tooltip[#tooltip + 1] = {
	-- 		E.func_GetItemName(122284),
	-- 		CharInfo.MASLENGO.Items.Bags[122284]
	-- 	}
	-- end








	if E.DebugCharacterInfo then
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {color..E.DEVTEXT.."|r", ""}
		if pd.tmstp_Daily then
			tooltip[#tooltip+1] = {
				color.."tmstp_Daily|r",
				classColorHex..E.func_SecondsToClock(pd.tmstp_Daily - GetServerTime()).."|r"
			}
		end
		if pd.tmstp_Weekly then
			tooltip[#tooltip+1] = {
				color.."tmstp_Weekly|r",
				classColorHex..E.func_SecondsToClock(pd.tmstp_Weekly - GetServerTime()).."|r"
			}
		end
		tooltip[#tooltip+1] = {
			color.."GUID|r",
			E.COLOR_PURPLE..pd.GUID.."|r"
		}
		tooltip[#tooltip+1] = {
			color.."hasMail|r",
			pd.hasMail and E.func_texturefromIcon(E.Icon_MailBox)..classColorHex.."true|r" or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."Chromie_canEnter|r",
			pd.Chromie_canEnter and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."Chromie_UnitChromieTimeID|r",
			color..tostring(pd.Chromie_UnitChromieTimeID or "").."|r"
		}
		tooltip[#tooltip+1] = {
			color.."Chromie_name|r",
			color..tostring(pd.Chromie_name or "").."|r"
		}
		tooltip[#tooltip+1] = {
			color.."BattleTag|r",
			E.COLOR_BLUE..pd.BattleTag.."|r"
		}
		tooltip[#tooltip+1] = {
			color.."BattleTagLocal|r",
			E.COLOR_BLUE..pd.BattleTagLocal.."|r"
		}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {
			color.."GameLimitedMode_IsActive|r",
			pd.GameLimitedMode_IsActive and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."levelCapped20|r",
			pd.levelCapped20 and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."PlayerCanEarnExperience|r",
			pd.PlayerCanEarnExperience and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {color.."buildVersion|r", classColorHex..pd.buildVersion.."|r"}
		tooltip[#tooltip+1] = {color.."buildNumber|r", classColorHex..pd.buildNumber.."|r"}
		tooltip[#tooltip+1] = {color.."buildDate|r", classColorHex..pd.buildDate.."|r"}
		tooltip[#tooltip+1] = {color.."interfaceVersion|r", classColorHex..pd.interfaceVersion.."|r"}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {color.."currentTier|r", classColorHex..pd.currentTier.."|r"}
		tooltip[#tooltip+1] = {
			color.."IsPublicBuild|r",
			pd.IsPublicBuild and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {
			color.."max LVL|r",
			pd.GetRestrictedAccountData_rLevel and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."max Money|r",
			pd.GetRestrictedAccountData_rMoney and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {
			color.."Authenticator|r",
			pd.IsAccountSecured and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."IsRestrictedAccount|r",
			pd.IsRestrictedAccount and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."IsTrialAccount|r",
			pd.IsTrialAccount and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."IsVeteranTrialAccount|r",
			pd.IsVeteranTrialAccount and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {" ", ""}
		tooltip[#tooltip+1] = {
			color.."PlayerDurability|r",
			pd.PlayerDurability and E.TRUE or color.."false|r"
		}
		tooltip[#tooltip+1] = {
			color.."CharDBVersion|r",
			color..tostring(pd.CharDBVersion or "").."|r"
		}
		tooltip[#tooltip+1] = {
			color.."CurrentRegion|r",
			color..tostring(pd.CurrentRegion or "").."|r"
		}
		tooltip[#tooltip+1] = {
			color.."CurrentRegionName|r",
			color..tostring(pd.CurrentRegionName or "").."|r"
		}
	end
	-- tooltip[#tooltip+1] = {"---"}
	tooltip[#tooltip+1] = {"Shift +"..E.LEFT_MOUSE_ICON..L["LMB"]}
	return tooltip
end