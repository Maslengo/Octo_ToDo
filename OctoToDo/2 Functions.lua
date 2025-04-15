local GlobalAddonName, E = ...
E.GlobalAddonName = GlobalAddonName
E.PromiseItem = {}
E.PromiseSpell = {}
E.PromiseQuest = {}
local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
----------------------------------------------------------------
local LibStub = LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
local LibDataBroker = LibStub("LibDataBroker-1.1")
local LibDBIcon = LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
-- console -> export "art"
function E.func_IsClassic() if E.interfaceVersion > 10000 and E.interfaceVersion < 20000 then return true else return false end end
function E.func_IsBC() if E.interfaceVersion > 20000 and E.interfaceVersion < 30000 then return true else return false end end
function E.func_IsWOTLK() if E.interfaceVersion > 30000 and E.interfaceVersion < 40000 then return true else return false end end
function E.func_IsCataclysm() if E.interfaceVersion > 40000 and E.interfaceVersion < 50000 then return true else return false end end
function E.func_IsMOP() if E.interfaceVersion > 50000 and E.interfaceVersion < 60000 then return true else return false end end
function E.func_IsWOD() if E.interfaceVersion > 60000 and E.interfaceVersion < 70000 then return true else return false end end
function E.func_IsLegion() if E.interfaceVersion > 70000 and E.interfaceVersion < 80000 then return true else return false end end
function E.func_IsBFA() if E.interfaceVersion > 80000 and E.interfaceVersion < 90000 then return true else return false end end
function E.func_IsShadowlands() if E.interfaceVersion > 90000 and E.interfaceVersion < 100000 then return true else return false end end
function E.func_IsDragonflight() if E.interfaceVersion > 100000 and E.interfaceVersion < 110000 then return true else return false end end
function E.func_IsTWW() if E.interfaceVersion > 110000 and E.interfaceVersion < 120000 then return true else return false end end
function E.func_IsMidnight() if E.interfaceVersion > 120000 and E.interfaceVersion < 130000 then return true else return false end end
function E.func_IsTLT() if E.interfaceVersion > 130000 and E.interfaceVersion < 140000 then return true else return false end end
function E.func_IsRetail() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE end
function E.func_IsPTR() return GetCurrentRegion() >= 72 end
----------------------------------------------------------------
function E.func_GetItemIcon(itemID)
	tinsert(E.PromiseItem, itemID)
	return C_Item.GetItemIconByID(itemID)
end
function E.func_GetItemName(itemID)
	tinsert(E.PromiseItem, itemID)
	local vivod = C_Item.GetItemNameByID(itemID) or SEARCH_LOADING_TEXT
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..itemID.."|r"
	end
	return vivod
end
function E.func_GetSpellIcon(spellID)
	tinsert(E.PromiseSpell, spellID)
	return C_Spell.GetSpellTexture(spellID)
end
function E.func_GetSpellName(spellID)
	tinsert(E.PromiseSpell, spellID)
	local vivod = C_Spell.GetSpellName(spellID)
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..spellID.."|r"
	end
	return vivod
end
function E.func_GetCurrencyIcon(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	local iconFileID = E.Icon_QuestionMark
	if info then
		iconFileID = info.iconFileID
	end
	return iconFileID
end
function E.func_currencyName(currencyID)
	if currencyID then
		local vivod
		local AWide = ""
		local ATrans = ""
		local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID) or false
		if isAccountTransferableCurrency == true then
			AWide = E.Icon_AccountTransferable
		end
		local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID) or false
		if isAccountWideCurrency == true then
			AWide = E.Icon_AccountWide
		end
		local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
		if info then
			local name = info.name
			local iconFileID = info.iconFileID
			local quality = info.quality
			local r, g, b = E.func_GetItemQualityColor(quality)
			local color = CreateColor(r, g, b, 1)
			local currencyName = color:WrapTextInColorCode(name)
			vivod = ATrans..AWide..currencyName
		else
			vivod = ATrans..AWide..E.Red_Color..RETRIEVING_ITEM_INFO.."|r"
		end
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..E.Gray_Color.." id:"..currencyID.."|r"
		end
		return vivod
	else
		return "currencyID = NIL"
	end
end
function E.func_questName(questID, useLargeIcon)
	tinsert(E.PromiseQuest, questID)
	local vivod = ""
	local useLargeIcon = useLargeIcon or true
	local isAccountQuest = C_QuestLog.IsAccountQuest(questID)
	local isCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)
	local title = C_QuestLog.GetTitleForQuestID(questID)
	if title then
		vivod = vivod..QuestUtils_DecorateQuestText(questID, title, useLargeIcon)
	else
		vivod = vivod..E.Red_Color.."hidden?".."|r"
	end
	if isAccountQuest then
		vivod = E.Icon_AccountWide.."|cffFFFF00"..vivod.."|r"
	end
	if isCompletedOnAccount then
		vivod = E.Icon_AccountWide.."|cff9fc5e8"..vivod.."|r"
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..questID.."|r"
	end
	return vivod
end
function E.func_reputationName(reputationID)
	if reputationID and E.OctoTable_Reputations[reputationID] then
		local vivod = ""
		local side = E.OctoTable_Reputations[reputationID].side or "-"
		local icon = E.OctoTable_Reputations[reputationID].icon

		local color = E.White_Color
		local factionname = ""
		if side == "Alliance" then
			vivod = E.func_texturefromIcon(E.Icon_Alliance) .. vivod
		elseif side == "Horde" then
			vivod = E.func_texturefromIcon(E.Icon_Horde) .. vivod
		end
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		local name
		if repInfo then
			vivod = vivod.. repInfo.name
		else
			local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID)
			if reputationInfo.name then
				vivod = vivod.. reputationInfo.name
			elseif E.OctoTable_Reputations[reputationID] then
				vivod = vivod.. E.OctoTable_Reputations[reputationID].name
			else
				vivod = vivod.. reputationID.. " (UNKNOWN)"
			end
		end
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..E.Gray_Color.." id:"..reputationID.."|r"
		end

		local friendData = C_GossipInfo.GetFriendshipReputation(reputationID)
		local isFriend = friendData and true or false

		if isFriend then
			if (friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0) then
				local texture = friendData.texture or error
				vivod = E.func_texturefromIcon(texture) .. vivod
			end
		end

		-- local isMajor = C_Reputation.IsMajorFaction(reputationID) and true or false
		-- if isMajor then
		-- 	local majorData = C_MajorFactions.GetMajorFactionData(reputationID) or 0
		-- 	if majorData ~= 0 then
		-- 		local textureKit = majorData.textureKit or 0
		-- 		if textureKit ~= 0 then
		-- 			local KitIcon = E.func_texturefromIcon(string.format("Interface\\ICONS\\UI_MajorFactions_%s", textureKit))
		-- 			-- local KitIcon = E.func_texturefromIcon(string.format("Interface\\ICONS\\UI_MajorFactions_%s_256", textureKit))
		-- 			print (KitIcon, textureKit)
		-- 			vivod = "|cffFF00FF"..textureKit.."|r" .. KitIcon.. vivod
		-- 		end
		-- 	end
		-- end
		if icon ~= 134400 then
			vivod = E.func_texturefromIcon(icon)..vivod
		end
		local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
		if isAccountWide == true then
			vivod = E.Icon_AccountWide..vivod
		end

		return vivod
	else
		return "|cffFF0000noname|r"
	end
end



function E.func_reputationIconString(reputationID)
	local icon = E.Icon_Empty
	local side = E.OctoTable_Reputations[reputationID].side

	if side == "Alliance" then
		icon = E.Icon_Alliance
	elseif side == "Horde" then
		icon = E.Icon_Horde
	end
	return E.func_texturefromIcon(icon)

end







function E.func_reputationNameSIMPLE(reputationID)
	local vivod = ""
	if reputationID and type(reputationID) == "number" then
		-- local isAccountWide = C_Reputation.IsAccountWideReputation(reputationID) or false
		-- if isAccountWide == true then
		-- vivod = E.Icon_AccountWide..vivod
		-- end
		local repInfo = C_Reputation.GetFactionDataByID(reputationID)
		local name
		if repInfo then
			name = repInfo.name
		else
			local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID or 0)
			name = reputationInfo.name or E.Red_Color..SEARCH_LOADING_TEXT.."|r"
		end
		vivod = vivod..name
		-- if E.DebugIDs == true and vivod ~= nil then
		-- vivod = vivod..E.Gray_Color.." id:"..reputationID.."|r"
		-- end
		vivod = vivod
	else
		vivod = reputationID
	end
	return vivod
end
----------------------------------------------------------------
-- ITEM UTILS
----------------------------------------------------------------
function E.func_GetItemInfo(itemInfo) -- Item ID, Link or name
	return C_Item.GetItemInfo(itemInfo)
end
----------------------------------------------------------------
function E.func_GetItemCount(itemID, includeBank, includeUses, includeReagentBank)
	return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetItemLink(itemID)
	local _, link = E.func_GetItemInfo(itemID)
	return link
end
----------------------------------------------------------------
function E.func_GetItemQuality(itemID)
	return C_Item.GetItemQualityByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemQualityColorID(itemID)
	return ITEM_QUALITY_COLORS[E.func_GetItemQuality(itemID)]
end
----------------------------------------------------------------
function E.func_GetItemQualityColor(quality)
	local r, g, b = C_Item.GetItemQualityColor(quality)
	return r, g, b
end
----------------------------------------------------------------
function E.IsAnimaItemByID(itemID)
	return C_Item.IsAnimaItemByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemCurrentLevel(itemID)
	return C_Item.GetDetailedItemLevelInfo(itemID)
end
----------------------------------------------------------------
function E.func_GetItemMaxStackSize(itemID)
	return C_Item.GetItemMaxStackSizeByID(itemID)
end
----------------------------------------------------------------
function E.func_IsItemStackable(itemID)
	local maxStackSize = E.func_GetItemMaxStackSize(itemID)
	return maxStackSize and maxStackSize > 1
end
----------------------------------------------------------------
function E.func_GetItemInventoryType(itemID)
	return C_Item.GetItemInventoryTypeByID(itemID)
end
----------------------------------------------------------------
function E.func_GetItemInventoryTypeName(itemID)
	local _, _, _, itemEquipLoc = C_Item.GetItemInfoInstant(itemID)
	return itemEquipLoc
end
----------------------------------------------------------------
function E.func_IsItemDataCached(itemID)
	return C_Item.IsItemDataCachedByID(itemID)
end
----------------------------------------------------------------
function E.func_itemName(itemID)
	local itemName = C_Item.GetItemNameByID(itemID) or E.Red_Color..SEARCH_LOADING_TEXT.."|r" -- RETRIEVING_ITEM_INFO
	local itemQuality = select(3, E.func_GetItemInfo(itemID))
	local vivod
	if itemQuality then
		vivod = ITEM_QUALITY_COLORS[itemQuality].color:WrapTextInColorCode(itemName)
	else
		vivod = itemName
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..itemID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_itemTexture(itemID)
	local icon = C_Item.GetItemIconByID(itemID) or E.Icon_QuestionMark
	return E.func_texturefromIcon(icon)
end
----------------------------------------------------------------
function E.func_spellTexture(spellID)
	local icon = E.func_GetSpellIcon(spellID) or E.Icon_QuestionMark
	return E.func_texturefromIcon(icon)
end
----------------------------------------------------------------
function E.func_GetItemCooldown(itemID)
	local start, duration = C_Item.GetItemCooldown(itemID)
	-- local start = C_Item.GetItemCooldown(itemID).startTimeSeconds or 0
	-- local duration = C_Item.GetItemCooldown(itemID).durationSeconds or 0
	-- local start = C_Container.GetItemCooldown(itemID).startTime or 0
	-- local duration = C_Container.GetItemCooldown(itemID).duration or 0
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E.func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
-- SPELLS
----------------------------------------------------------------
function E.func_GetSpellSubtext(spellID)
	local vivod = C_Spell.GetSpellSubtext(spellID)
	-- if E.DebugIDs == true and vivod ~= nil then
	--   vivod = vivod..E.Gray_Color.." id:"..spellID.."|r"
	-- end
	return vivod
end
----------------------------------------------------------------
function E.func_GetSpellNameFull(spellID)
	local name = E.func_GetSpellName(spellID)
	local subText = E.func_GetSpellSubtext(spellID)
	local vivod = subText and #subText > 0 and name.."("..subText..")" or name
	-- if E.DebugIDs == true and vivod ~= nil then
	--   vivod = vivod..E.Gray_Color.." id:"..spellID.."|r"
	-- end
	return vivod
end
----------------------------------------------------------------
function E.func_GetSpellDescription(spellID)
	return C_Spell.GetSpellDescription(spellID)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_GetSpellCooldown(spellID)
	local start = C_Spell.GetSpellCooldown(spellID).startTime
	local duration = C_Spell.GetSpellCooldown(spellID).duration
	local vivod = 0
	if start > 0 and duration > 0 then
		vivod = (start + duration - GetTime())
	end
	return E.func_CompactNumberSimple(vivod)
end
----------------------------------------------------------------
function E.COMPLETE()
	-- return E.Purple_Color..">>".."Complete".."<<".."|r"
	-- return E.Purple_Color..">"..COMPLETE.."<".."|r"
	return E.Purple_Color..">"..QUEST_WATCH_QUEST_READY.."<".."|r"
end
----------------------------------------------------------------
function E.func_hex2rgb(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2)), tonumber("0x"..hex:sub(3, 4)), tonumber("0x"..hex:sub(5, 6))
end
----------------------------------------------------------------
function E.func_hex2rgbNUMBER(hex)
	hex = hex:gsub("|cff", "")
	return tonumber("0x"..hex:sub(1, 2))/255, tonumber("0x"..hex:sub(3, 4))/255, tonumber("0x"..hex:sub(5, 6))/255, 1
end
----------------------------------------------------------------
function E.func_rgb2hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "|c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
----------------------------------------------------------------
function E.func_percent(percent, maxvalue)
	return (maxvalue*percent)/100
end
----------------------------------------------------------------
function E.func_Gradient(text, firstColor, secondColor)
	if not firstColor then firstColor = "|cffD177FF" end
	if not secondColor then secondColor = "|cff63A4E0" end
	local vivod = ""
	local str = ""
	local total = utf8len(text)-1
	local r1, g1, b1 = E.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.func_hex2rgb(secondColor)
	local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
	local r3 = r1
	local g3 = g1
	local b3 = b1
	for i = 1, total do
		str = str..("|cff%02x%02x%02x%s|r"):format(math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5), utf8sub(text, i, i))
		r3 = r3 + rdelta
		g3 = g3 + gdelta
		b3 = b3 + bdelta
	end
	vivod = str..secondColor..utf8sub(text, utf8len(text)).."|r"
	return vivod
end
----------------------------------------------------------------
function E.func_GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, E.OctoTable_bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function E.func_GenerateUniqueColor()
	local s = {}
	for i=1, 6 do
		tinsert(s, E.OctoTable_bytetoB64Color[math.random(0, 15)])
	end
	return table.concat(s)
end
----------------------------------------------------------------
function E.func_PlaySoundFile_whisper(fileName)
	if fileName then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Memes\\"..fileName..".ogg", "Master")
	end
end
----------------------------------------------------------------
function E.func_CompactNumberFormat(number)
	local number = number or 0
	if number == 0 then
		return 0
	elseif number < 1000 then
		return (math.floor((number+0.5)-0.5)/10)*10
	elseif number < 1000000 then
		return (math.floor(number/100)/10).."k"
	else
		return (math.floor(number/100000)/10).."m"
	end
end
----------------------------------------------------------------
function E.func_CompactNumberSimple(number)
	local number = number or 0
	if number == 0 then
		return 0
	else
		return math.floor(number+.5)
	end
end
function E.func_UnitFaction(unit)
	local englishFaction, localizedFaction = UnitFactionGroup(unit)
	return englishFaction
end
----------------------------------------------------------------
function E.func_texturefromIcon(icon, iconSize)
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconSize or 16)..":"..(iconSize or 16)..":::64:64:4:60:4:60|t"
end
E.Icon_Alliance = 255140-- E.func_texturefromIcon(255140) -- 132486
E.Icon_Horde = 255142 -- 132485
E.Icon_Kyrian = 3641395
E.Icon_Necrolord = 3641396
E.Icon_NightFae = 3641394
E.Icon_Venthyr = 3641397
E.Icon_WorldBoss = 3528312
E.Icon_Rares = 135903
E.Icon_Money = 133784
if E.func_UnitFaction("PLAYER") == "Horde" then
	E.Icon_Faction = 2565244
elseif E.func_UnitFaction("PLAYER") == "Alliance" then
	E.Icon_Faction = 2565243
else
	E.Icon_Faction = 620830
end
E.Icon_MailBox = "Interface/AddOns/"..E.GlobalAddonName.."/Media/ElvUI/Mail0.tga"
function E.func_texturefromIconEVENT(icon, iconSize)
	return "|T"..(icon or E.Icon_QuestionMark)..":"..(iconSize or 16)..":"..(iconSize or 16)..":::128:128:0:91:0:91|t"
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_currencyName_NOCOLOR(currencyID)
	local vivod
	local AWide = ""
	local ATrans = ""
	local isAccountTransferableCurrency = C_CurrencyInfo.IsAccountTransferableCurrency(currencyID) or false
	if isAccountTransferableCurrency == true then
		AWide = E.Icon_AccountTransferable
	end
	local isAccountWideCurrency = C_CurrencyInfo.IsAccountWideCurrency(currencyID) or false
	if isAccountWideCurrency == true then
		AWide = E.Icon_AccountWide
	end
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	if info then
		local name = info.name
		-- local iconFileID = info.iconFileID
		-- local quality = info.quality
		-- local r, g, b = C_Item.GetItemQualityColor(quality)
		-- local color = CreateColor(r, g, b, 1)
		-- local currencyName = color:WrapTextInColorCode(name)
		vivod = ATrans..AWide..name
	else
		vivod = ATrans..AWide..E.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..currencyID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_currencyIcon(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	local iconFileID = E.Icon_QuestionMark
	if info then
		iconFileID = info.iconFileID
	end
	return E.func_texturefromIcon(iconFileID)
end
----------------------------------------------------------------
function E.func_currencyquantity(currencyID)
	local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	local quantity
	if info then
		quantity = info.quantity or 0
	end
	return quantity
end
----------------------------------------------------------------
function E.func_SecondsToClock(time)
	time = tonumber(time) or 0
	if time <= 0 then
		return "" -- "0"..(L["time_SECOND"])
	end
	local years = floor(time / 31536000) -- 86400*365
	local days = floor(time % 31536000 / 86400)
	local hours = floor(time % 86400 / 3600)
	local mins = floor(time % 3600 / 60)
	local secs = floor(time % 60)
	-- Формируем строку по частям
	local parts = {}
	if years > 0 then
		table.insert(parts, years..(L["time_YEAR"] or "y").." ")
		table.insert(parts, days..(L["time_DAY"] or "d").." ")
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif days > 0 then
		table.insert(parts, days..(L["time_DAY"] or "d").." ")
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, mins..(L["time_MINUTE"] or "m"))
	elseif hours > 0 then
		table.insert(parts, hours..(L["time_HOUR"] or "h").." ")
		table.insert(parts, string.format("%02d", mins)..(L["time_MINUTE"] or "m"))
	elseif time >= 60 then
		table.insert(parts, mins..(L["time_MINUTE"] or "m").." ")
		if time < 600 then -- Только для 1-9 минут добавляем секунды
			table.insert(parts, secs..(L["time_SECOND"] or "s"))
		end
	else
		table.insert(parts, secs..(L["time_SECOND"] or "s"))
	end
	return table.concat(parts)
end
function E.ChatFrame_TimeBreakDown(time)
	local days = floor(time / (60 * 60 * 24))
	local hours = floor((time - (days * (60 * 60 * 24))) / (60 * 60))
	local minutes = floor((time - (days * (60 * 60 * 24)) - (hours * (60 * 60))) / 60)
	local seconds = mod(time, 60)
	return days, hours, minutes, seconds
end
----------------------------------------------------------------
function E.func_tmstpDayReset(time)
	local time = time or 1
	return (math.ceil((tonumber(GetServerTime()) - E.thursdayReset)/(E.daytime*time))*E.daytime*time)+E.thursdayReset
end
----------------------------------------------------------------
function E.func_CheckCompletedByQuestID(questID)
	local vivod
	local TEST = ""
	if C_QuestLog.IsFailed(questID) then return "|cffFF0000>"..FAILED.."<|r" end
	if C_QuestLog.IsQuestFlaggedCompleted(questID) == true then
		vivod = E.DONE
	elseif C_QuestLog.IsComplete(questID) == true then
		vivod = E.COMPLETE()
	elseif C_QuestLog.IsQuestFlaggedCompleted(questID) == false and C_QuestLog.IsOnQuest(questID) == false then
		vivod = E.NONE
	elseif C_QuestLog.IsOnQuest(questID) == true --[[and C_QuestLog.IsComplete(questID) == false ]]then
		local objectives = C_QuestLog.GetQuestObjectives(questID)
		if objectives == nil then
			return ""
		end
		for i = 1, #objectives do
			if objectives[i] then
				local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, i, false)
				if objectiveType == "progressbar" then
					TEST = E.Red_Color..GetQuestProgressBarPercent(questID).."%|r"
				else
					if finished then
						TEST = E.Yellow_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
					else
						TEST = E.Red_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
					end
				end
			end
			vivod = vivod and vivod.."»"..TEST or TEST
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_OnlyFirstWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z
end
----------------------------------------------------------------
function E.func_OnlyLastWord(text)
	local text = tostring(text)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", text)
	return z or y or x or w or v or u or t or s or r or q or p or i or n or m or l or k or j or i or h or g or f or e or d or c or b or a
end
----------------------------------------------------------------
function E.func_InList(k, t, p)
	for _, v in next, (t) do
		if (p and v[p]==k) or (not p and v==k) then
			return true
		end
	end
end
----------------------------------------------------------------
function E.func_achievementComplete(achievementID)
	if not achievementID then
		return false
	end
	local completed = select(4, GetAchievementInfo(achievementID))
	return completed
end
----------------------------------------------------------------
function E.func_achievementName(achievementID)
	local vivod = select(2, GetAchievementInfo(achievementID))
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..achievementID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_achievementIcon(achievementID)
	local Icon = select(10, GetAchievementInfo(achievementID))
	return Icon
end
----------------------------------------------------------------
function E.func_achievementDescription(achievementID)
	local description = select(8, GetAchievementInfo(achievementID)) or ""
	return description
end
----------------------------------------------------------------
function E.func_achievementvivod(achievementID)
	local vivod
	local completed = select(4, GetAchievementInfo(achievementID))
	local wasEarnedByMe = select(13, GetAchievementInfo(achievementID))
	local earnedBy = select(14, GetAchievementInfo(achievementID))
	if completed == true then
		vivod = E.DONE
	else
		local numCriteria = GetAchievementNumCriteria(achievementID)
		if numCriteria ~= 0 then
			local count = 0
			for i = 1, numCriteria do
				local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i, false)
				if numCriteria == 1 then
					if quantity == 0 then
						vivod = E.Red_Color..quantity.." / "..reqQuantity.."|r"
					else
						vivod = quantity.." / "..reqQuantity
					end
				else
					if completedCrit == true then
						count = count + 1
					end
					if count == 0 then
						vivod = E.Red_Color..count.." / "..numCriteria.."|r"
					else
						vivod = count.." / "..numCriteria
					end
				end
			end
		else
			vivod = E.Red_Color.."0 / 1".."|r"
		end
	end
	return vivod or "CHETNET"
end
----------------------------------------------------------------
function E.func_achievementcriteriaString(achievementID, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(achievementID))
	local description = select(8, GetAchievementInfo(achievementID))
	local numCriteria = GetAchievementNumCriteria(achievementID)
	for i = 1, numCriteria do
		local criteriaString, _, completedCrit, quantity = GetAchievementCriteriaInfo(achievementID, i, false)
		local color = E.White_Color
		if completedCrit == true then
			color = E.Green_Color
		elseif completedCrit == false and quantity == 0 then
			color = E.Gray_Color
		end
		if criteriaString and criteriaString ~= "" then
			vivod = vivod..color..criteriaString.."|n|r"
		else
			vivod = vivod..color..description.."|r"
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_achievementquantity(achievementID, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(achievementID))
	local description = select(8, GetAchievementInfo(achievementID))
	local numCriteria = GetAchievementNumCriteria(achievementID)
	for i = 1, numCriteria do
		local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(achievementID, i, false)
		local color = E.White_Color
		if completedCrit == true then
			color = E.Green_Color
		elseif completedCrit == false and quantity == 0 then
			color = E.Gray_Color
		end
		if quantity then
			vivod = vivod..color..quantity.." / "..reqQuantity.."|n|r"
		else
			vivod = vivod..color.."0/1PIZZA".."|r"
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_CurServerShort(text)
	local text = (text):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		text = utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	else
		text = utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
	end
	return text
end
----------------------------------------------------------------
function E.func_GetMapName(mapID)
	if not mapID then return end
	local info = C_Map.GetMapInfo(mapID)
	if info then
		local name = info.name
		return tostring(name)
	end
end
----------------------------------------------------------------
function E.func_npcName(npcName)
	local inspectScantipFUNC = nil
	if not inspectScantipFUNC then
		inspectScantipFUNC = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFUNC", nil, "GameTooltipTemplate")
		inspectScantipFUNC:SetOwner(UIParent, "ANCHOR_NONE")
	end
	local vivod = "|cffFF0000error|r"
	if not npcName then return E.NONE end
	if npcName then
		inspectScantipFUNC:SetHyperlink("unit:Creature-0-0-0-0-"..npcName)
		if inspectScantipFUNC:NumLines() > 0 then
			vivod = _G["OctoToDoScanningTooltipFUNCTextLeft1"]:GetText()
			return vivod
		end
		inspectScantipFUNC:ClearLines()
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..npcName.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_RIOColor(RIOscore)
	local hexColor = E.Gray_Color
	if not RIOscore or RIOscore == 0 then
		return hexColor
	end
	for _, v in next, (E.OctoTable_RIO_COLORS) do
		if RIOscore <= v.score then
			hexColor = E.func_rgb2hex(v.color[1], v.color[2], v.color[3])
		end
	end
	return hexColor
end
----------------------------------------------------------------
function E.func_encryption(text)
	local text = utf8reverse(tostring(text))
	local text = strsplit("-", text)
	local vivod = ""
	vivod = utf8lower(text:gsub("0", ""):gsub("1", ""):gsub("2", ""):gsub("3", ""):gsub("4", ""):gsub("5", ""):gsub("6", ""):gsub("7", ""):gsub("8", ""):gsub("9", ""))
	return vivod
end
----------------------------------------------------------------
function E.func_GetClassColor(className) -- C_ClassColor.GetClassColor(classFilename)
	local color = (RAID_CLASS_COLORS)[className]
	if color then
		return color.colorStr:gsub("^ff", "")
	end
	return "ffffff"
end
E.className = select(1, UnitClass("PLAYER"))
E.classFilename = select(2, UnitClass("PLAYER"))
E.classId = select(3, UnitClass("PLAYER"))
E.classColor = E.func_GetClassColor(E.classFilename)
local r, g, b = GetClassColor(E.classFilename)
if (r == 1 and g == 1 and b == 1) then
	r = 150/255
	g = 89/255
	b = 255/255
end
E.classColorHexCurrent = E.func_rgb2hex(r, g, b)
E.curCharName = UnitFullName("PLAYER")
E.curServer = GetRealmName()
E.curServerShort = E.func_CurServerShort(GetRealmName())
E.Class_Priest_Color_Alternative = "|cff9659FF"--"|cff7157FF"
-- if E.classColorHexCurrent == "|cffFFFFFF" then
-- 	E.classColorHexCurrent = E.Class_Priest_Color_Alternative
-- end
E.Class_Warrior_Color = "|cffC69B6D"
E.Class_Paladin_Color = "|cffF48CBA"
E.Class_Hunter_Color = "|cffAAD372"
E.Class_Rogue_Color = "|cffFFF468"
E.Class_Priest_Color = "|cffFFFFFF"
E.Class_Shaman_Color = "|cff0070DD"
E.Class_Mage_Color = "|cff3FC7EB"
E.Class_Warlock_Color = "|cff8788EE"
E.Class_Monk_Color = "|cff00FF98"
E.Class_Druid_Color = "|cffFF7C0A"
E.Class_DemonHunter_Color = "|cffA330C9"
E.Class_DeathKnight_Color = "|cffC41E3A"
E.Class_Evoker_Color = "|cff33937F"
----------------------------------------------------------------
function E.func_Reverse_order(a, b)
	return b < a
end
----------------------------------------------------------------
function E.func_CheckReputationByRepID(reputationID)
	local vivod = ""
	local repInfo = C_Reputation.GetFactionDataByID(reputationID)
	local color = E.Gray_Color
	local reaction = 0
	if repInfo then
		reaction = repInfo.reaction
		--local standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
	end
	if (reaction == 1 or reaction == 2) then
		color = E.Red_Color
	elseif (reaction == 3) then
		color = E.Orange_Color
	elseif (reaction == 4 or reaction == 5) then
		color = E.Yellow_Color
	elseif (reaction == 6 or reaction == 7 or reaction == 8) then
		color = E.Green_Color
	end
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID)
	if C_Reputation.IsFactionParagon(reputationID) then
		local currentValue = C_Reputation.GetFactionParagonInfo(reputationID)
		local _, threshold, rewardQuestID, hasRewardPending = C_Reputation.GetFactionParagonInfo(reputationID)
		if threshold then
			local value = currentValue % threshold
			color = E.Blue_Color
			vivod = color..(value).."/"..(threshold).."|r"
			if hasRewardPending then
				vivod = E.func_CheckCompletedByQuestID(rewardQuestID)
			end
		end
	elseif C_Reputation.IsMajorFaction(reputationID) then
		local data = C_MajorFactions.GetMajorFactionData(reputationID) or 0
		if data ~= 0 then
			local currentValue = data.renownReputationEarned%data.renownLevelThreshold
			local totalValue = data.renownLevelThreshold
			local standing = data.renownLevel
			vivod = (currentValue).."/"..(totalValue)..color.."("..(standing)..")|r"
		end
	elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
		local friendshipFactionID = reputationInfo.friendshipFactionID or 0
		local reactionThreshold = reputationInfo.reactionThreshold or 0
		local nextThreshold = reputationInfo.nextThreshold or 0
		local standing = reputationInfo.standing or 0
		local currentValue = standing-reactionThreshold
		local totalValue = nextThreshold-reactionThreshold
		local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
		local currentLevel, maxLevel
		if rankInfo then
			currentLevel = rankInfo.currentLevel or 0
			maxLevel = rankInfo.maxLevel or 0
		end
		--standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
		vivod = color..(currentValue).."/"..(totalValue) --..standingTEXT.."|r"
		if currentLevel == maxLevel then
			vivod = color.."Done|r "
		end
	else
		if repInfo then
			local barMin = repInfo.currentReactionThreshold
			local barMax = repInfo.nextReactionThreshold
			local barValue = repInfo.currentStanding
			if barValue then
				local currentValue = barValue-barMin
				local totalValue = barMax-barMin
				local nextThreshold = reputationInfo.nextThreshold or 0
				vivod = color..(currentValue).."/"..(totalValue) --.." ("..standingTEXT..")|r"
				if currentValue == totalValue then -- or nextThreshold == 0 then
					vivod = color.."Done|r"
				end
			end
		end
	end
	return vivod
end



function E.func_CheckReputationFULL(reputationID)
	local SHOWFULL = false
	local FIRST = 0
	local SECOND = 0
	local vivod = ""
	local color = E.Pink_Color
	local reaction = 0
	local standingTEXT = ""
	local description = ""
	local error = 0 --("|cffFF0000".."nil".."|r")
	local isSimple = C_Reputation.GetFactionDataByID(reputationID) and true or false
	local simpleData = C_Reputation.GetFactionDataByID(reputationID)
	local isParagon = C_Reputation.IsFactionParagon(reputationID)
	local friendData = C_GossipInfo.GetFriendshipReputation(reputationID)
	local isFriend = friendData and true or false
	-- if friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0 then
	--     isFriend = true
	-- end
	local isMajor = C_Reputation.IsMajorFaction(reputationID)
	if isSimple then
		reaction = simpleData.reaction
		description = simpleData.description
		standingTEXT = GetText("FACTION_STANDING_LABEL"..reaction, UnitSex("player"))
	end
	if (reaction == 1 or reaction == 2) then
		color = E.Red_Color
	elseif (reaction == 3) then
		color = E.Orange_Color
	elseif (reaction == 4 or reaction == 5) then
		color = E.Yellow_Color
	elseif (reaction == 6 or reaction == 7 or reaction == 8) then
		color = E.Green_Color
	end
	if isParagon then
		local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(reputationID)
		if threshold then
			local value = currentValue % threshold
			color = E.Blue_Color
			vivod = value.."/"..threshold
			if tooLowLevelForParagon then
				vivod = vivod .. " (low)"
			end
			FIRST = value
			SECOND = threshold
			if hasRewardPending then
				vivod = E.func_CheckCompletedByQuestID(rewardQuestID)
			end
		end
	elseif isMajor then
		local majorData = C_MajorFactions.GetMajorFactionData(reputationID) or 0
		if majorData ~= 0 then
			local textureKit = majorData.textureKit
			local currentValue = majorData.renownReputationEarned%majorData.renownLevelThreshold
			local totalValue = majorData.renownLevelThreshold
			local standing = majorData.renownLevel
			vivod = currentValue.."/"..totalValue..color.."("..(standing)..")|r"
			-- vivod = currentValue.."/"..totalValue .. " |cffFF00FF("..textureKit..")|r"

			FIRST = currentValue
			second = totalValue
		end
	elseif (friendData and friendData.friendshipFactionID and friendData.friendshipFactionID > 0) then
		local friendshipFactionID = friendData.friendshipFactionID or error
		local standing = friendData.standing or error
		local maxRep = friendData.maxRep or error
		local name = friendData.name or error
		local text = friendData.text or error
		local texture = friendData.texture or error
		local reaction = friendData.reaction or error
		local reactionThreshold = friendData.reactionThreshold or error
		local nextThreshold = friendData.nextThreshold or error
		local reversedColor = friendData.reversedColor or error
		local overrideColor = friendData.overrideColor or error
		local currentValue = standing-reactionThreshold
		local totalValue = nextThreshold-reactionThreshold
		local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
		local currentLevel, maxLevel
		if rankInfo then
			currentLevel = rankInfo.currentLevel or 0
			maxLevel = rankInfo.maxLevel or 0
		end

		if currentLevel == maxLevel then
			FIRST = currentLevel
			SECOND = maxLevel
			vivod = FIRST.."/"..SECOND
		else
			standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
			if SHOWFULL then
				FIRST = standing
				SECOND = maxRep
			else
				FIRST = currentValue
				SECOND = totalValue
			end
			vivod = FIRST.."/"..SECOND..standingTEXT
		end
		-- vivod = E.func_texturefromIcon(texture)..vivod


	else
		if isSimple then
			local barMin = simpleData.currentReactionThreshold
			local barMax = simpleData.nextReactionThreshold
			local barValue = simpleData.currentStanding
			if barValue then
				local currentValue = barValue-barMin
				local totalValue = barMax-barMin
				-- local nextThreshold = friendData.nextThreshold or 0



				if currentValue == totalValue then -- or nextThreshold == 0 then
					FIRST = 1
					SECOND = 1
					vivod = standingTEXT
				else
					if SHOWFULL then
						if barMin < 0 then
							FIRST = barMin
							SECOND = 42000
						else
							FIRST = barMin
							SECOND = barMax
						end
					else
						if barMin < 0 then
							FIRST = currentValue
							SECOND = totalValue
						else
							FIRST = currentValue
							SECOND = totalValue
						end
					end
					vivod = FIRST.."/"..SECOND
				end





			end
		end
	end
	return FIRST, SECOND, vivod, color, standingTEXT, description
end



function E.func_GetReputationStandingColor(reputationID)
	local repInfo = C_Reputation.GetFactionDataByID(reputationID)
	local color = E.Gray_Color
	if repInfo then
		local reaction = repInfo.reaction
		if (reaction == 1 or reaction == 2) then
			color = E.Red_Color
		end
		if (reaction == 3) then
			color = E.Orange_Color
		end
		if (reaction == 4 or reaction == 5) then
			color = E.Yellow_Color
		end
		if (reaction == 6 or reaction == 7 or reaction == 8) then
			color = E.Green_Color
		end
		if C_Reputation.IsFactionParagon(reputationID) then
			local threshold = select(2, C_Reputation.GetFactionParagonInfo(reputationID))
			if threshold then
				color = E.Blue_Color
			end
		end
		-- print (reaction, color..reaction.."|r")
	end
	return color
end
function E.func_CheckRepCURSTANDING(reputationID)
	local vivod1 = 0
	local vivod2 = 0
	local checkrepid = 1741+9999
	local repInfo = C_Reputation.GetFactionDataByID(reputationID)
	if repInfo then
		local barMin = repInfo.currentReactionThreshold
		local barMax = repInfo.nextReactionThreshold
		local barValue = repInfo.currentStanding
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(reputationID or 0)
		if C_Reputation.IsFactionParagon(reputationID) then
			local currentValue = C_Reputation.GetFactionParagonInfo(reputationID) or 0
			local _, threshold = C_Reputation.GetFactionParagonInfo(reputationID)
			if threshold then
				vivod1 = currentValue % threshold
				vivod2 = threshold
			end
			if reputationID == checkrepid then
				print (reputationID, "paragon", vivod1, vivod2)
			end
		elseif C_Reputation.IsMajorFaction(reputationID) then
			local data = C_MajorFactions.GetMajorFactionData(reputationID) or 0
			if data ~= 0 then
				local currentValue = data.renownReputationEarned%data.renownLevelThreshold
				local totalValue = data.renownLevelThreshold
				vivod1 = currentValue
				vivod2 = totalValue
			end
			if reputationID == checkrepid then
				print (reputationID, "major", vivod1, vivod2)
			end
		elseif (reputationInfo and reputationInfo.friendshipFactionID and reputationInfo.friendshipFactionID > 0) then
			local friendshipFactionID = reputationInfo.friendshipFactionID or 0
			local reactionThreshold = reputationInfo.reactionThreshold or 0
			local nextThreshold = reputationInfo.nextThreshold or 0
			local standing = reputationInfo.standing or 0
			local currentValue = standing-reactionThreshold
			local totalValue = nextThreshold-reactionThreshold
			local rankInfo = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
			local currentLevel, maxLevel
			if rankInfo then
				currentLevel = rankInfo.currentLevel or 0
				maxLevel = rankInfo.maxLevel or 0
			end
			-- standingTEXT = " ("..currentLevel.."/"..maxLevel..")"
			vivod1 = currentValue
			vivod2 = totalValue
			if currentLevel == maxLevel then
				vivod1 = 100
				vivod2 = 100
			end
			if reputationID == checkrepid then
				print (reputationID, "friend", vivod1, vivod2)
			end
		else
			if barValue then
				local currentValue = barValue-barMin
				local totalValue = barMax-barMin
				local nextThreshold = reputationInfo.nextThreshold or 0
				vivod1 = currentValue
				vivod2 = totalValue
				if currentValue == totalValue then -- or nextThreshold == 0 then
					vivod1 = 100
					vivod2 = 100
				end
				if reputationID == checkrepid then
					print (reputationID, "else", vivod1, vivod2)
				end
			end
		end
	end
	return vivod1, vivod2, color
end
----------------------------------------------------------------
function E.func_CurrentNumQuests()
	local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
	local numQuests = 0
	for i = 1, numShownEntries do
		local info = C_QuestLog.GetInfo(i) -- questLogIndex
		if info then
			if info.questID ~= 0 then
				if (not info.isHeader and not info.isHidden) then
					numQuests = numQuests + 1
				else
					numQuests = numQuests
				end
			end
		end
	end
	return numQuests
end
----------------------------------------------------------------
function E.ReloadUI()
	return ReloadUI
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetAddOnMetadata(name, variable)
	local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
	return GetAddOnMetadata(name, variable)
end
----------------------------------------------------------------
function E.GetAddOnInfo(name)
	local GetAddOnInfo = C_AddOns.GetAddOnInfo
	return GetAddOnInfo(name)
end
----------------------------------------------------------------
function E.EnableAddOn(name, character)
	local EnableAddOn = C_AddOns.EnableAddOn
	return EnableAddOn(name, character)
end
----------------------------------------------------------------
function E.DisableAddOn(name, character)
	local DisableAddOn = C_AddOns.DisableAddOn
	return DisableAddOn(name, character)
end
----------------------------------------------------------------
function E.LoadAddOn(name)
	local LoadAddOn = C_AddOns.LoadAddOn
	return LoadAddOn(name)
end
----------------------------------------------------------------
function E.IsAddOnLoaded(name)
	local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
	return IsAddOnLoaded(name)
end
----------------------------------------------------------------
function E.func_LoadAddOn(AddonName)
	local LoadAddOn = C_AddOns.LoadAddOn
	local loaded, reason = LoadAddOn(AddonName)
	if not loaded and reason == "DISABLED" then
		E.EnableAddOn(AddonName)
		E.LoadAddOn(AddonName)
	end
end
----------------------------------------------------------------
function E.func_AddonTitle(AddonName)
	local AddonTitle = C_AddOns.GetAddOnMetadata(AddonName, "Title")
	return AddonTitle
end
----------------------------------------------------------------
function E.func_AddonNotes(AddonName)
	local AddonNotes = C_AddOns.GetAddOnMetadata(AddonName, "Notes")
	return AddonNotes
end
----------------------------------------------------------------
function E.func_AddonAuthor(AddonName)
	local AddonAuthor = C_AddOns.GetAddOnMetadata(AddonName, "Author")
	return AddonAuthor
end
----------------------------------------------------------------
function E.func_AddonVersion(AddonName)
	local AddonVersion = C_AddOns.GetAddOnMetadata(AddonName, "Version")
	return AddonVersion
end
----------------------------------------------------------------
function E.func_AddonIconTexture(AddonName)
	local AddonIconTexture = C_AddOns.GetAddOnMetadata(AddonName, "IconTexture")
	return AddonIconTexture
end
----------------------------------------------------------------
----------------------------------------------------------------
-- C_AddOns.DoesAddOnExist(name)
-- C_AddOns.GetAddOnDependencies(name)
-- C_AddOns.GetAddOnOptionalDependencies(name)
-- C_AddOns.GetNumAddOns()
-- C_AddOns.GetScriptsDisallowedForBeta()
-- C_AddOns.IsAddOnLoaded(name)
-- C_AddOns.IsAddOnLoadOnDemand(name)
-- C_AddOns.IsAddonVersionCheckEnabled()
-- C_AddOns.ResetAddOns()
-- C_AddOns.ResetDisabledAddOns()
-- C_AddOns.SaveAddOns()
-- C_AddOns.SetAddonVersionCheck(enabled)
-- C_AddOns.DisableAllAddOns([character])
-- C_AddOns.EnableAllAddOns([character])
-- C_AddOns.GetAddOnEnableState(name [, character])
-- C_AddOns.IsAddOnLoadable(name [, character [, demandLoaded]])
----------------------------------------------------------------
function E.IsInArray(arr, subj)
	for i = 1, #arr do
		if arr[i] == subj then
			return i
		end
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_EmptyZero(value)
	if tonumber(value) == 0 then
		return "" --Red_Color.."NEEDDELETE|r"
	end
	return value
end
----------------------------------------------------------------
-- https://warcraft.wiki.gg/wiki/API_GetAccountExpansionLevel
function E.func_CurrentExpansion()
	if LE_EXPANSION_LEVEL_CURRENT ~= nil then
		return LE_EXPANSION_LEVEL_CURRENT+1
	else
		return 1
	end
end
----------------------------------------------------------------
function E.func_EventName(eventID)
	local vivod
	local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
	local monthDay = currentCalendarTime.monthDay -- The current day of the month [1-31]
	local month = 0 -- currentCalendarTime.month -- The current month [1-12]
	local numEvents = C_Calendar.GetNumDayEvents(month, monthDay)
	for i = 1, numEvents do
		local eID = C_Calendar.GetDayEvent(month, monthDay, i).eventID
		if eID == eventID then
			vivod = C_Calendar.GetDayEvent(month, monthDay, i).title
		end
	end
	if E.DebugIDs == true and vivod ~= nil then
		vivod = vivod..E.Gray_Color.." id:"..eventID.."|r"
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionName(skillLine)
	local vivod = ""
	if skillLine then
		local name = C_TradeSkillUI.GetTradeSkillDisplayName(skillLine)
		vivod = name
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..E.Gray_Color.." id:"..skillLine.."|r"
		end
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionIcon(skillLine)
	local vivod = ""
	if skillLine then
		local icon = C_TradeSkillUI.GetTradeSkillTexture(skillLine)
		vivod = E.func_texturefromIcon(icon)
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionSkillLevel(skillLine)
	local vivod = ""
	if skillLine then
		local skillLevel = select(3, GetProfessionInfo(skillLine))
		vivod = skillLevel
	end
	return vivod
end
----------------------------------------------------------------
function E.func_ProfessionMaxSkillLevel(skillLine)
	local vivod = ""
	if skillLine then
		local maxSkillLevel = select(4, GetProfessionInfo(skillLine))
		vivod = maxSkillLevel
	end
	return vivod
end
----------------------------------------------------------------
function E.START()
	local timer = debugprofilestart()
	return timer
end
----------------------------------------------------------------
function E.STOP()
	local timer = E.func_CompactNumberSimple(debugprofilestop())
	local vivod = E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	vivod = vivod..timer
	return DEFAULT_CHAT_FRAME:AddMessage(vivod.. "|cff63A4E0 ms.|r")
end
----------------------------------------------------------------
function E.func_dungeonName(dungeonID)
	if dungeonID then
		local vivod = C_ChallengeMode.GetMapUIInfo(dungeonID)
		if E.DebugIDs == true and vivod ~= nil then
			vivod = vivod..E.Gray_Color.." id:"..dungeonID.."|r"
		end
		return vivod
	end
end
----------------------------------------------------------------
function E.func_dungeontimeLimit(dungeonID)
	if dungeonID then
		local timeLimit = select(3, C_ChallengeMode.GetMapUIInfo(dungeonID))
		return timeLimit
	end
end
----------------------------------------------------------------
function E.func_dungeonIcon(dungeonID)
	if dungeonID then
		local texture = select(4, C_ChallengeMode.GetMapUIInfo(dungeonID))
		return texture
	end
end
----------------------------------------------------------------
function E.FriendsFrame_GetLastOnlineText(time, color)
	if not time then
		return FRIENDS_LIST_OFFLINE
	else
		return string.format(BNET_LAST_ONLINE_TIME, color..E.FriendsFrame_GetLastOnline(time).."|r")
	end
end
----------------------------------------------------------------
function E.FriendsFrame_GetLastOnline(timeDifference, isAbsolute)
	if (not isAbsolute) then
		timeDifference = time() - timeDifference
	end
	if (timeDifference < SECONDS_PER_MIN) then
		return LASTONLINE_SECS
	elseif (timeDifference >= SECONDS_PER_MIN and timeDifference < SECONDS_PER_HOUR) then
		return format(LASTONLINE_MINUTES, floor(timeDifference / SECONDS_PER_MIN))
	elseif (timeDifference >= SECONDS_PER_HOUR and timeDifference < SECONDS_PER_DAY) then
		return format(LASTONLINE_HOURS, floor(timeDifference / SECONDS_PER_HOUR))
	elseif (timeDifference >= SECONDS_PER_DAY and timeDifference < SECONDS_PER_MONTH) then
		return format(LASTONLINE_DAYS, floor(timeDifference / SECONDS_PER_DAY))
	elseif (timeDifference >= SECONDS_PER_MONTH and timeDifference < SECONDS_PER_YEAR) then
		return format(LASTONLINE_MONTHS, floor(timeDifference / SECONDS_PER_MONTH))
	else
		return format(LASTONLINE_YEARS, floor(timeDifference / SECONDS_PER_YEAR))
	end
end
----------------------------------------------------------------
function E.func_TableMerge(table1, table2)
	for k, v in pairs(table2) do
		if table1[k] == nil or type(table1[k]) ~= type(table2[k]) then
			table1[k] = v
			-- print("replacing key", k, v)
		elseif type(v) == "table" then
			table1[k] = MergeTable(table1[k], table2[k])
		end
	end
	return table1
end
----------------------------------------------------------------
function E.func_TableConcat(table1, table2)
	for i = 1, #table2 do
		table1[#table1+1] = table2[i]
	end
	return table1
end
----------------------------------------------------------------
function E.func_TableRemoveDuplicates(table1)
	if type(table1) ~= "table" then
		table1 = {}
	end
	local table2 = {}
	local i = 1
	while table1[i] do
		local value = table1[i]
		if table2[value] then
			tremove(table1, i)
		else
			i = i + 1
		end
		table2[value] = true
	end
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.func_coloredText(fontstring)
	if not fontstring then
		return nil
	end
	local text = fontstring:GetText()
	if not text then
		return nil
	end
	local r, g, b, a = fontstring:GetTextColor()
	return E.func_rgb2hex(r, g, b, a)..text.."|r"
end
----------------------------------------------------------------
function E:func_SetBackdrop(frame, hexcolor, BackdropAlpha, edgeAlpha)
	-- local r, g, b = GetClassColor(E.classFilename)
	local r, g, b = E.func_hex2rgbNUMBER(E.classColorHexCurrent)
	local bgCr, bgCg, bgCb, bgCa = E.bgCr, E.bgCg, E.bgCb, E.bgCa
	if hexcolor then
		bgCr, bgCg, bgCb = self.func_hex2rgbNUMBER(hexcolor)
	end
	if BackdropAlpha then
		bgCa = BackdropAlpha
	end
	edgeAlpha = edgeAlpha or 1
	frame:SetBackdrop({
			bgFile = E.bgFile,
			edgeFile = E.edgeFile,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0},
	})
	frame.r = bgCr
	frame.g = bgCg
	frame.b = bgCb
	frame.a = bgCa
	frame:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
	frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
	if not frame.isInit then
		frame.isInit = true
		frame:HookScript("OnEnter", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, frame.a)
				self:SetBackdropBorderColor(r, g, b, 1)
		end)
		frame:HookScript("OnLeave", function(self)
				self:SetBackdropColor(self.r, self.g, self.b, frame.a)
				self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		end)
		if frame.icon then
			frame.icon:SetAllPoints(frame)
			frame:SetScript("OnShow", function(self)
					self.icon:SetVertexColor(1, 1, 1, 1)
			end)
			-- frame:SetScript("OnEnter", function(self)
			--     self.icon:SetVertexColor(r, g, b, 1)
			-- end)
			-- frame:SetScript("OnLeave", function(self)
			--     self.icon:SetVertexColor(1, 1, 1, 1)
			--     GameTooltip:ClearLines()
			--     GameTooltip:Hide()
			-- end)
			frame:SetScript("OnMouseDown", function(self)
					self.icon:SetVertexColor(1, 0, 0, .5)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self.icon:SetVertexColor(r, g, b, 1)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
			end)
		end
	end
end
----------------------------------------------------------------
function E:func_CreateUtilsButton(frame, title, height, indent)
	local curHeight = height
	local indent = indent or 0
	----------------------------------------------------------------
	-- OctoToDo_CloseButton
	----------------------------------------------------------------
	local OctoToDo_CloseButton = CreateFrame("Button", "OctoToDo_CloseButton", frame)
	OctoToDo_CloseButton:SetSize(curHeight, curHeight)
	OctoToDo_CloseButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, indent)
	OctoToDo_CloseButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(E.WOW_Artifact_Color..CLOSE.."|r")
			GameTooltip:Show()
	end)
	OctoToDo_CloseButton:SetScript("OnClick", function()
			frame:Hide()
	end)
	OctoToDo_CloseButton:SetScript("OnKeyDown", function(self, key)
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:GetParent():Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
	end)
	OctoToDo_CloseButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_CloseButton.icon = OctoToDo_CloseButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_CloseButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\CloseTest.tga")
	OctoToDo_CloseButton.icon:SetAllPoints()
	----------------------------------------------------------------
	-- OctoToDo_OptionsButton
	----------------------------------------------------------------
	local OctoToDo_OptionsButton = CreateFrame("Button", "OctoToDo_OptionsButton", frame)
	OctoToDo_OptionsButton:SetSize(curHeight, curHeight)
	OctoToDo_OptionsButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-curHeight)*1, indent)
	OctoToDo_OptionsButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:AddLine(E.WOW_Artifact_Color..OPTIONS.."|r")
			GameTooltip:Show()
	end)
	OctoToDo_OptionsButton:SetScript("OnClick", function()
			-- frame:SetShown(not frame:IsShown())
			if frame and frame:IsShown() then
				frame:Hide()
			end
			if SettingsPanel:IsVisible() and frame:IsVisible() then
				HideUIPanel(SettingsPanel)
			else
				Settings.OpenToCategory(E.func_AddonTitle(E.GlobalAddonName), true)
			end
	end)
	OctoToDo_OptionsButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_OptionsButton.icon = OctoToDo_OptionsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_OptionsButton.icon:SetTexture("Interface\\AddOns\\OctoToDo\\Media\\IconTexture\\"..title)
	OctoToDo_OptionsButton.icon:SetAllPoints()
	----------------------------------------------------------------
	-- OctoToDo_AbandonButton
	----------------------------------------------------------------
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
	----------------------------------------------------------------
	StaticPopupDialogs[GlobalAddonName.."Abandon_All_Quests"] = {
		text = E.Red_Color.."!!! ACHTUNG !!!|r\n"..E.WOW_Artifact_Color.."Отменить все задания?|r",
		button1 = YES,
		button2 = NO,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function()
			C_Timer.After(1, AbandonQuests)
		end,
	}
	local OctoToDo_AbandonButton = CreateFrame("Button", "OctoToDo_AbandonButton", frame)
	OctoToDo_AbandonButton:SetSize(curHeight, curHeight)
	OctoToDo_AbandonButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-curHeight)*2, indent)
	OctoToDo_AbandonButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			if E.func_CurrentNumQuests() > 0 then
				GameTooltip:AddLine(E.WOW_Artifact_Color..L["Abandon All Quests"].."|r".." ("..E.func_CurrentNumQuests()..")")
				GameTooltip:AddLine(" ")
			else
				GameTooltip:AddLine(L["No quests"], r, g, b)
			end
			local numShownEntries = C_QuestLog.GetNumQuestLogEntries()
			local list = {}
			for i = 1, numShownEntries do
				if E.func_CurrentNumQuests() ~= 0 then
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
				GameTooltip:AddDoubleLine(E.func_questName(questID), E.func_CheckCompletedByQuestID(questID), 1, 1, 1, 1, 1, 1)
			end
			GameTooltip:Show()
	end)
	OctoToDo_AbandonButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_AbandonButton:SetScript("OnClick", function()
			if E.func_CurrentNumQuests() > 0 then
				StaticPopup_Show(GlobalAddonName.."Abandon_All_Quests")
			end
	end)
	OctoToDo_AbandonButton.icon = OctoToDo_AbandonButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_AbandonButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow72.tga")
	OctoToDo_AbandonButton.icon:SetAllPoints()
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	-- OctoToDo_EventsButton
	----------------------------------------------------------------
	-- local OctoToDo_EventsButton = CreateFrame("Button", "OctoToDo_EventsButton", frame, "BackDropTemplate")
	local OctoToDo_EventsButton = CreateFrame("Button", "OctoToDo_EventsButton", frame)
	OctoToDo_EventsButton:SetSize(curHeight, curHeight)
	OctoToDo_EventsButton:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-curHeight)*3, indent)
	OctoToDo_EventsButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
			GameTooltip:ClearLines()
			local curdatetable = date("*t")
			-- fpde(date("*t"))
			-- [1] = {
			-- ["hour"] = 2,
			-- ["min"] = 15,
			-- ["wday"] = 1,
			-- ["day"] = 30,
			-- ["month"] = 3,
			-- ["year"] = 2025,
			-- ["sec"] = 28,
			-- ["yday"] = 89,
			-- ["isdst"] = "false",
			-- },
			local curdate = (FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year))
			-- local curdate = E:func_fixdate(curdatetable.day).."/"..E:func_fixdate(curdatetable.month).."/"..E:func_fixdate(curdatetable.year)
			GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..(L["Current Date"]).."|r", E.WOW_Artifact_Color..(curdate.."|r"))
			GameTooltip:AddDoubleLine(" ", " ")
			local count = 0
			local sorted = {}
			for k, v in pairs (E.HolidayForButton) do
				tinsert(sorted, k)
			end
			sort(sorted, function(a, b) return E.HolidayForButton[a].priority < E.HolidayForButton[b].priority end)
			for i, eventID in ipairs(sorted) do
				local v = E.HolidayForButton[eventID]
				count = count + 1
				-- if v.Active == true then
				--   -- BRAWL_TOOLTIP_ENDS - Заканчивается через %s
				--   -- СЕЙЧАС
				--   GameTooltip:AddDoubleLine(--[[E.func_texturefromIcon(v.iconTexture)..]]E.Green_Color..v.title.."|r"..E.White_Color.." (".. string.format(BRAWL_TOOLTIP_ENDS, v.ENDS)..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Green_Color..v.startTime.." - "..v.endTime.."|r")
				-- elseif v.Possible == true then
				--   -- БУДУЩЕЕ
				--   GameTooltip:AddDoubleLine(--[[E.func_texturefromIcon(v.iconTexture)..]]E.Gray_Color..v.title .." ("..v.event_duration..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				-- else
				--   -- ПРОШЛОЕ
				--   GameTooltip:AddDoubleLine(--[[E.func_texturefromIcon(v.iconTexture)..]]E.Gray_Color..v.title .." ("..v.event_duration..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				-- end
				if v.Active == true then
					-- СЕЙЧАС
					GameTooltip:AddDoubleLine(v.invitedBy..E.func_texturefromIconEVENT(v.iconTexture)..E.Green_Color..v.title.."|r"..E.White_Color.." (".. v.ENDS..")|r"..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Green_Color..v.startTime.." - "..v.endTime.."|r")
				elseif v.Possible == true then
					-- БУДУЩЕЕ
					GameTooltip:AddDoubleLine(v.invitedBy..E.func_texturefromIconEVENT(v.iconTexture)..E.Gray_Color..v.title ..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				else
					-- ПРОШЛОЕ
					GameTooltip:AddDoubleLine(v.invitedBy..E.func_texturefromIconEVENT(v.iconTexture)..E.Gray_Color..v.title ..(E.DebugIDs and E.Gray_Color.. " id:"..eventID.."|r" or ""), E.Gray_Color..v.startTime.." - "..v.endTime.."|r")
				end
			end
			if count == 0 then
				GameTooltip:AddLine("No Data")
			end
			GameTooltip:AddDoubleLine(" ", " ")
			GameTooltip:Show()
	end)
	OctoToDo_EventsButton:SetScript("OnLeave", function(self)
			GameTooltip:ClearLines()
			GameTooltip:Hide()
	end)
	OctoToDo_EventsButton:SetScript("OnClick", function()
			frame:Hide()
			fpde(E.HolidayForButton)
	end)
	OctoToDo_EventsButton.icon = OctoToDo_EventsButton:CreateTexture(nil, "BACKGROUND")
	OctoToDo_EventsButton.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\ElvUI\\Arrow6.tga")
	OctoToDo_EventsButton.icon:SetAllPoints()
	-- E:func_SetBackdrop(OctoToDo_EventsButton)
	----------------------------------------------------------------
	-- OctoToDo_FramerateFrame GetFramerate()
	----------------------------------------------------------------
		-- local vars = OctoToDo_DB_Vars.OctoToDo_FramerateFrame
		-- if vars.Shown then
	local OctoToDo_FramerateFrame = CreateFrame("Frame", "OctoToDo_FramerateFrame", frame)
	OctoToDo_FramerateFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", (-curHeight)*4, indent)
	OctoToDo_FramerateFrame:SetSize(curHeight*2, curHeight)
	OctoToDo_FramerateFrame:SetFrameStrata("HIGH")
	OctoToDo_FramerateFrame.text_fps = OctoToDo_FramerateFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	OctoToDo_FramerateFrame.text_fps:SetPoint("CENTER", 0, 0)
	OctoToDo_FramerateFrame.text_fps:SetFontObject(OctoFont12)
	OctoToDo_FramerateFrame.text_fps:SetJustifyV("MIDDLE")
	OctoToDo_FramerateFrame.text_fps:SetJustifyH("CENTER")
	OctoToDo_FramerateFrame.text_fps:SetTextColor(.31, 1, .47, 1)
	C_Timer.NewTicker(1, function()
			local fps = math.floor(GetFramerate())
			OctoToDo_FramerateFrame.text_fps:SetText(fps)
	end)
end
----------------------------------------------------------------
function E:func_CreateMinimapButton(addonName, title, vars, frame, func, frameString)
	-- print (MinimapName, title)
	local MinimapName = E.func_AddonTitle(E.GlobalAddonName).." » "..title
	local info = {
		type = "data source",
		text = MinimapName,
		icon = "Interface\\AddOns\\OctoToDo\\Media\\IconTexture\\"..title,
		OnEnter = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
			GameTooltip_SetTitle(GameTooltip, MinimapName)
			GameTooltip:Show()
		end,
		OnLeave = function()
			GameTooltip:Hide()
		end,
	}
	info.OnClick = function(_, button)
		if button == "LeftButton" then
			if not InCombatLockdown() then
				if func then
					func()
				end
				if frame then
					for index, frames in ipairs(E.OctoTable_Frames) do
						if frame ~= frames and frames:IsShown() then
							frames:Hide()
						end
					end
					frame:SetShown(not frame:IsShown())
				end
				if SettingsPanel:IsVisible() and frame:IsVisible() then
					HideUIPanel(SettingsPanel)
				end
				if GameMenuFrame:IsVisible() and frame:IsVisible() then
					HideUIPanel(GameMenuFrame)
				end
			end
		end
	end
	local ldb_icon = LibDataBroker:NewDataObject(MinimapName, info)
	if vars.minimapPos == nil then vars.minimapPos = 244 end
	LibDBIcon:Register(MinimapName, ldb_icon, vars.minimap)
	LibDBIcon:Show(MinimapName)
end
----------------------------------------------------------------
function E.func_TooltipOnEnter(frame, first, second)
	if not frame.tooltip then
		return
	elseif #frame.tooltip == 0 then
		return
	end
	GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT", 0, 0)
	if first then GameTooltip:AddLine(" ") end
	for _, value in next, (frame.tooltip) do
		GameTooltip:AddDoubleLine(value[1], value[2], 1, 1, 1, 1, 1, 1)
	end
	if second then GameTooltip:AddLine(" ") end
	GameTooltip:Show()
end
----------------------------------------------------------------
function E:func_fixdate(date)
	-- GameTooltip:AddDoubleLine(E.WOW_Artifact_Color..(L["Current Date"]).."|r", E.WOW_Artifact_Color..(date("%d/%m/%Y").."|r"))
	-- local curdate = (FormatShortDate(curdatetable.day, curdatetable.month, curdatetable.year))
	local vivod = ("%.2d"):format(date)
	--return format("%.2d", date)
	return vivod
end
----------------------------------------------------------------
function E:func_IsAvailable(id, curType)
	if id and curType then
		if curType == "spell" and IsSpellKnown(id) then
			return true
		elseif curType == "item" and C_Item.GetItemCount(id, false, false, false) > 0 then
			return true
		elseif curType == "toy" and PlayerHasToy(id) then
			return true
		else
			return false
		end
	end
end
-- /dump C_Item.GetItemCount(141605)
----------------------------------------------------------------
function E:func_IsOnCD(id, curType)
	local id = id or nil
	local curType = curType or nil
	if id and curType then
		if curType == "spell" and C_Spell.GetSpellCooldown(id).startTime > 0 then
			return true
		elseif curType == "item" and select(2, C_Item.GetItemCooldown(id)) > 0 then
			return true
		elseif curType == "toy" and select(2, C_Item.GetItemCooldown(id)) > 0 then
			return true
		else
			return false
		end
	end
end
-- /dump PlayerHasToy(172924)
function E:FrameColor(frame, id, curType)
	if E:func_IsAvailable(id, curType) == false then
		frame:SetBackdropBorderColor(0, 0, 0, .5)
		frame.icon:SetVertexColor(1, 1, 1, .5)
		frame.icon:SetDesaturated(true)
	else
		if E:func_IsOnCD(id, curType) == true then
			frame.icon:SetVertexColor(1, 0, 0, 1)
		else
			frame.icon:SetVertexColor(1, 1, 1, 1)
		end
	end
end
----------------------------------------------------------------
function E:CreateUsableSpellFrame(id, point, parent, rPoint, x, y, size, curType)
	if id and type(id) == "number" then
		local curType = curType or "spell"
		local frame = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate, BackDropTemplate")
		frame:Hide()
		frame:SetPoint(point, parent, rPoint, x, y)
		frame:SetSize(size, size)
		local _, classFilename = UnitClass("PLAYER")
		local r, g, b = GetClassColor(classFilename)
		local edgeAlpha = 1
		frame.icon = frame:CreateTexture(nil, "BACKGROUND")
		frame.icon:SetAllPoints()
		if curType == "item" or curType == "toy" then
			frame.icon:SetTexture(E.func_GetItemIcon(id))
		else
			frame.icon:SetTexture(E.func_GetSpellIcon(id))
		end
		frame.icon:SetTexCoord(.10, .90, .10, .90) -- zoom 10%
		frame:SetBackdrop({
				bgFile = E.bgFile,
				edgeFile = E.edgeFile,
				edgeSize = 1,
				insets = {left = 0, right = 0, top = 0, bottom = 0},
		})
		frame:SetBackdropColor(0, 0, 0, 0)
		frame:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
		frame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
		frame:SetAttribute("type", "macro")
		if not InCombatLockdown() then
			if curType == "item" or curType == "toy" then
				frame:SetAttribute("macrotext", "/use item:"..id)
			else
				frame:SetAttribute("macrotext", "/cast "..C_Spell.GetSpellName(id))
			end
		end
		if not frame.isInit then
			frame.isInit = true
			frame:SetScript("OnShow", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnEnter", function(self)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
					E:FrameColor(self, id, curType)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 10)
					GameTooltip:ClearLines()
					if curType == "item" or curType == "toy" then
						GameTooltip:AddDoubleLine(E.func_GetItemName(id), E.func_SecondsToClock(E.func_GetItemCooldown(id)))
					else
						GameTooltip:AddDoubleLine(E.func_GetSpellName(id), E.func_SecondsToClock(E.func_GetSpellCooldown(id)))
						GameTooltip:AddDoubleLine(E.func_GetSpellSubtext(id))
					end
					GameTooltip:Show()
			end)
			frame:SetScript("OnLeave", function(self)
					self:SetBackdropBorderColor(0, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
			end)
			frame:SetScript("OnMouseDown", function(self)
					self:SetBackdropBorderColor(1, 0, 0, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
			frame:SetScript("OnMouseUp", function(self)
					self:SetBackdropBorderColor(r, g, b, edgeAlpha)
					E:FrameColor(self, id, curType)
			end)
		end
	end
end
function E.func_DebugPath()
	local stack = debugstack(2)
	local vivod1 = stack:match("Interface/AddOns/(.-):%d+") or "unknown"
	local vivod2 = vivod1:gsub("]", "")
	return tostring(vivod2)
end
----------------------------------------------------------------
function E.RegisterMyEventsToFrames(frame, MyEventsTable, DebugPath)
	for _, event in ipairs(MyEventsTable) do frame:RegisterEvent(event) end
	frame:SetScript("OnEvent",
		function(self, event, ...)
			if self[event] then
				self[event](self, ...)
			else
				DEFAULT_CHAT_FRAME:AddMessage(E.KILLTEXT.. E.Event_Color..event.."|r"..E.KILLTEXT..DebugPath)
				self:UnregisterEvent(event)
				self.event = nil
			end
	end)
end
----------------------------------------------------------------
function E.func_Reason(reason)
	local vivod = ""
	if reason == "CORRUPT" then vivod = ADDON_CORRUPT end
	if reason == "DEMAND_LOADED" then vivod = ADDON_DEMAND_LOADED end
	if reason == "DEP_BANNED" then vivod = ADDON_DEP_BANNED end
	if reason == "DEP_CORRUPT" then vivod = ADDON_DEP_CORRUPT end
	if reason == "DEP_DEMAND_LOADED" then vivod = ADDON_DEP_DEMAND_LOADED end
	if reason == "DEP_DISABLED" then vivod = ADDON_DEP_DISABLED end
	if reason == "DEP_EXCLUDED_FROM_BUILD" then vivod = ADDON_DEP_EXCLUDED_FROM_BUILD end
	if reason == "DEP_INSECURE" then vivod = ADDON_DEP_INSECURE end
	if reason == "DEP_INTERFACE_VERSION" then vivod = ADDON_DEP_INTERFACE_VERSION end
	if reason == "DEP_LOADABLE" then vivod = ADDON_DEP_LOADABLE end
	if reason == "DEP_MISSING" then vivod = ADDON_DEP_MISSING end
	if reason == "DEP_NO_ACTIVE_INTERFACE" then vivod = ADDON_DEP_NO_ACTIVE_INTERFACE end
	if reason == "DEP_NOT_AVAILABLE" then vivod = ADDON_DEP_NOT_AVAILABLE end
	if reason == "DEP_USER_ADDONS_DISABLED" then vivod = ADDON_DEP_USER_ADDONS_DISABLED end
	if reason == "DEP_WRONG_ACTIVE_INTERFACE" then vivod = ADDON_DEP_WRONG_ACTIVE_INTERFACE end
	if reason == "DEP_WRONG_GAME_TYPE" then vivod = ADDON_DEP_WRONG_GAME_TYPE end
	if reason == "DEP_WRONG_LOAD_PHASE" then vivod = ADDON_DEP_WRONG_LOAD_PHASE end
	if reason == "EXCLUDED_FROM_BUILD" then vivod = ADDON_EXCLUDED_FROM_BUILD end
	if reason == "INSECURE" then vivod = ADDON_INSECURE end
	if reason == "INTERFACE_VERSION" then vivod = ADDON_INTERFACE_VERSION end
	if reason == "MISSING" then vivod = ADDON_MISSING end
	if reason == "NO_ACTIVE_INTERFACE" then vivod = ADDON_NO_ACTIVE_INTERFACE end
	if reason == "NOT_AVAILABLE" then vivod = ADDON_NOT_AVAILABLE end
	if reason == "USER_ADDONS_DISABLED" then vivod = ADDON_USER_ADDONS_DISABLED end
	if reason == "WRONG_ACTIVE_INTERFACE" then vivod = ADDON_WRONG_ACTIVE_INTERFACE end
	if reason == "WRONG_GAME_TYPE" then vivod = ADDON_WRONG_GAME_TYPE end
	if reason == "WRONG_LOAD_PHASE" then vivod = ADDON_WRONG_LOAD_PHASE end
	return vivod
end
----------------------------------------------------------------
function E.func_CreateInfoFrame(text, point, parent, rPoint, x, y, sizeW, sizeH)
	local frame = CreateFrame("frame", nil, parent, "BackDropTemplate")
	frame:SetPoint(point, parent, rPoint, x, y)
	frame:SetSize(sizeW, sizeH)
	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.text:SetAllPoints()
	frame.text:SetFontObject(OctoFont11)
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetJustifyH("LEFT")
	frame.text:SetTextColor(1, 1, 1, 1)
	frame.text:SetText(text)
end
----------------------------------------------------------------
function E.func_CreatePlayersFrame()
	local frame = CreateFrame("frame", nil, parent, "BackDropTemplate")
	frame:SetPoint(point, parent, rPoint, x, y)
	frame:SetSize(sizeW, sizeH)
	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	frame.text:SetAllPoints()
	frame.text:SetFontObject(OctoFont11)
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetJustifyH("LEFT")
	frame.text:SetTextColor(1, 1, 1, 1)
	frame.text:SetText(text)
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
E.OctoTable_Empty = {}
E.Modules = {}
E.Timers = {}
E.spacer = "  "
-------------------------------------------------------------------------
E.FULL_WIDTH = 3.60
E.edgeFile = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\border\\01 Octo.tga"
E.bgFile = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\border\\01 Octo.tga"
E.OctoFont = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\font\\01 Octo.TTF"
E.fontObject9 = CreateFont("OctoFont9")
E.fontObject9:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.fontObject9:SetFont(E.OctoFont, 9, "OUTLINE")
E.fontObject10 = CreateFont("OctoFont10")
E.fontObject10:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.fontObject10:SetFont(E.OctoFont, 10, "OUTLINE")
E.fontObject11 = CreateFont("OctoFont11")
E.fontObject11:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.fontObject11:SetFont(E.OctoFont, 11, "OUTLINE")
E.fontObject12 = CreateFont("OctoFont12")
E.fontObject12:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.fontObject12:SetFont(E.OctoFont, 12, "OUTLINE")
E.fontObject22 = CreateFont("OctoFont22")
E.fontObject22:CopyFontObject(SystemFont_Outline_Small)-- local font = GameFontHighlightSmallLeft
E.fontObject22:SetFont("Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\font\\02 Octo-Bold.TTF", 20, "OUTLINE")
E.AddonTexture_1 = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\AddonTexture_1.tga"
E.AddonTexture_2 = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\AddonTexture_2.tga"
E.AddonTexture_3 = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\AddonTexture_3.tga"
E.AddonTexture_4 = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\AddonTexture_4.tga"
E.AddonTexture_5 = "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\AddonTexture_5.tga"
E.currentTier = tonumber(GetBuildInfo():match("(.-)%."))
E.currentMaxLevel = GetMaxLevelForExpansionLevel(LE_EXPANSION_LEVEL_CURRENT)
E.currentExpansionName = _G['EXPANSION_NAME'..LE_EXPANSION_LEVEL_CURRENT] -- GetExpansionLevel()
----------------------------------------------------------------
E.IsPublicBuild = IsPublicBuild()
E.buildVersion = select(1, GetBuildInfo())
E.buildNumber = select(2, GetBuildInfo())
E.buildDate = select(3, GetBuildInfo())
E.interfaceVersion = select(4, GetBuildInfo())
E.currentTier = tonumber(GetBuildInfo():match("(.-)%."))
E.GetRestrictedAccountData_rLevel = select(1, GetRestrictedAccountData())
E.GetRestrictedAccountData_rMoney = select(2, GetRestrictedAccountData())
E.GetRestrictedAccountData_profCap = select(3, GetRestrictedAccountData())
E.IsAccountSecured = IsAccountSecured()
E.IsRestrictedAccount = IsRestrictedAccount() or false
E.IsTrialAccount = IsTrialAccount() or false
E.IsVeteranTrialAccount = IsVeteranTrialAccount() or false
E.BattleTag = select(2, BNGetInfo()) or "Trial Account"
E.BTAG = tostringall(strsplit("#", E.BattleTag))
E.GameVersion = GetCurrentRegion() >= 72 and "PTR" or "Retail"
E.BattleTagLocal = E.BTAG.." ("..E.GameVersion..")"
E.curGUID = UnitGUID("PLAYER")
E.GameLimitedMode_IsActive = GameLimitedMode_IsActive() or false
E.baseWowheadAzEsUrl = "https://%swowhead.com/azerite-essence/%s%s"
E.baseWowheadTradingPostActivityUrl = "https://%swowhead.com/trading-post-activity/%s%s"
E.baseArmoryUrl = "https://worldofwarcraft.blizzard.com/%s/character/%s/%s"
E.baseRaiderIoUrl = "https://raider.io/characters/%s/%s/%s"
E.strategies = {}
E.altStrategies = {}
E.thursdayReset = (1514358000-10800)
E.thursdayResetDay0US = 1514300400
E.daytime = 86400
-- E.currTime = tonumber(GetServerTime())
E.curExpansionMaxLevel = 70
E.scale = WorldFrame:GetWidth()/GetPhysicalScreenSize()/UIParent:GetScale()
E.MonitorWidth = GetPhysicalScreenSize()
E.MonitorHeight = select(2, GetPhysicalScreenSize())
E.BGALPHA = .1
E.Color_Quest_r = .3 -- 1
E.Color_Quest_g = .1 -- .7
E.Color_Quest_b = 0 -- 0
E.Color_Currency_r = 0 -- 0.79
E.Color_Currency_g = 0 -- 0.76
E.Color_Currency_b = .3 -- 0.67
E.Color_Crest_r = 0 -- 0
E.Color_Crest_g = .3 -- 0
E.Color_Crest_b = .3 -- 1
E.Color_Item_r = 0 -- 0
E.Color_Item_g = .3 -- 1
E.Color_Item_b = 0 -- 1
E.Color_Reputation_r = .3 -- 0
E.Color_Reputation_g = .3 -- 1
E.Color_Reputation_b = 0 -- 1
E.MainFrame_Position = -157
E.AnimationDuration = .2
E.isElvUI = select(4, C_AddOns.GetAddOnInfo("ElvUI"))
E.isRCLootCouncil = select(4, C_AddOns.GetAddOnInfo("isRCLootCouncil"))
E.isWeakAuras = select(4, C_AddOns.GetAddOnInfo("isWeakAuras"))
E.isTomTom = select(4, C_AddOns.GetAddOnInfo("isTomTom"))
E.isPlater = select(4, C_AddOns.GetAddOnInfo("isPlater"))
E.isOmniCD = select(4, C_AddOns.GetAddOnInfo("isOmniCD"))
E.bgCr = .08 -- 14/255
E.bgCg = .08 -- 14/255
E.bgCb = .08 -- 14/255
E.bgCa = .8
E.bgCaOverlay = .1
E.slider_scale = .8
E.multiplier = 2 - E.slider_scale
E.WorldofWarcraft_Color = "|cffD6AB7D" -- "|cff68CCEF"
E.TheBurningCrusade_Color = "|cffE43E5A" -- "|cff4FFF79"
E.WrathoftheLichKing_Color = "|cff3FC7EB" -- "|cff00A3FF"
E.Cataclysm_Color = "|cffFF7C0A" -- "|cffFFB300"
E.MistsofPandaria_Color = "|cff00EF88" -- "|cff00FFBA"
E.WarlordsofDraenor_Color = "|cffF48CBA" -- "|cffC86400"
E.Legion_Color = "|cffAAD372" -- "|cff1EFF00"
E.BattleforAzeroth_Color = "|cffFFF468" -- "|cff6464FF"
E.Shadowlands_Color = "|cff9798FE" -- "|cffC9C3AA"
E.Dragonflight_Color = "|cff53B39F" -- "|cffE8E379"
E.TheWarWithin_Color = "|cff90CCDD" -- "|cffB59377"
E.Midnight_Color = "|cff7B69FF" -- СИНИЙ
E.TheLastTitan_Color = "|cffF4C263" -- ЖЕЛТЫЙ
E.WOW_Poor_Color = "|cff9D9D9D"
E.WOW_Common_Color = "|cffFFFFFF"
E.WOW_Uncommon_Color = "|cff1EFF00"
E.WOW_Rare_Color = "|cff0070DD"
E.WOW_Epic_Color = "|cffA335EE"
E.WOW_Legendary_Color = "|cffFF8000"
E.WOW_Artifact_Color = "|cffD9CC80"
E.WOW_Heirloom_Color = "|cff00CCFF"
E.WOW_WoWToken_Color = "|cff00CCFF"
E.Kyrian_Color = "|cff6FA8DC"
E.Necrolord_Color = "|cff93C47D"
E.NightFae_Color = "|cffB4A7D6"
E.Venthyr_Color = "|cffEA9999"
E.Black_Color = "|cff000000"
E.DarkGray_Color = "|cff252525"
E.Gray_Color = "|cff757575" -- "|cff505050"
E.LightGray_Color = "|cff909090" -- "|cff757575"
E.White_Color = "|cffFFFFFF"
E.Addon_Left_Color = "|cffD177FF"
E.Addon_Right_Color = "|cff63A4E0"
E.Red_Color = "|cffFF4C4F"
E.Orange_Color = "|cffFF661A"
E.Darkorange_Color = "|cffFF8C00"
E.Gold_Color = "|cffFFD600"
E.Yellow_Color = "|cffFFF371" --"|cffFFFF00"
E.Greenyellow_Color = "|cffACFF2F"
E.Green_Color = "|cff4FFF79"
E.Cyan_Color = "|cff00FFFF"
E.Blue_Color = "|cff00A3FF"
E.Purple_Color = "|cffAF61FF"
E.Indigo_Color = "|cff4B0082"
E.Magenta_Color = "|cffFF00FF"
E.Pink_Color = "|cffFF69B3"
E.Skyblue_Color = "|cff87CDEB"
E.Steelblue_Color = "|cff4682B3"
E.Slategray_Color = "|cff708090"
E.Brown_Color = "|cff964B00"
E.Event_Color = "|cff4682B3"
E.Debug_Color = E.classColorHexCurrent -- "|cff4682B3"
----------------------------------------------------------------
E.Kyrian_r_Color = 0.44
E.Kyrian_g_Color = 0.66
E.Kyrian_b_Color = 0.86
E.Necrolord_r_Color = 0.58
E.Necrolord_g_Color = 0.77
E.Necrolord_b_Color = 0.49
E.NightFae_r_Color = 0.56
E.NightFae_g_Color = 0.49
E.NightFae_b_Color = 0.76
E.Venthyr_r_Color = 0.88
E.Venthyr_g_Color = 0.40
E.Venthyr_b_Color = 0.40
----------------------------------------------------------------
E.DONE = E.Green_Color.."Done".."|r"
E.NONE = E.Gray_Color.."None".."|r"
----------------------------------------------------------------
E.AccountWide = E.Blue_Color.."(A)".."|r"
E.AccountTransferable = E.Red_Color.."(T)".."|r"
E.Icon_AccountWide = E.Blue_Color.."(A)".."|r"
E.Icon_AccountTransferable = E.Red_Color.."(W)".."|r"
E.Icon_QuestionMark = 134400 or "Interface\\Icons\\INV_Misc_QuestionMark"
E.Icon_Empty = "Interface\\AddOns\\OctoToDo\\Media\\SimpleAddonManager\\spacerEMPTY"
E.OctoTable_Covenant = {
	[1] = {
		name = C_Covenants.GetCovenantData(1).name, -- "Kyrian",
		icon = 3641395,
		color = "|cff6FA8DC",
		r = 0.44,
		g = 0.66,
		b = 0.86,
	},
	[2] = {
		name = C_Covenants.GetCovenantData(2).name, -- "Venthyr",
		icon = 3641397,
		color = "|cffEA9999",
		r = 0.88,
		g = 0.40,
		b = 0.40,
	},
	[3] = {
		name = C_Covenants.GetCovenantData(3).name, -- "NightFae",
		icon = 3641394,
		color = "|cffB4A7D6",
		r = 0.56,
		g = 0.49,
		b = 0.76,
	},
	[4] = {
		name = C_Covenants.GetCovenantData(4).name, -- "Necrolord",
		icon = 3641396,
		color = "|cff93C47D",
		r = 0.58,
		g = 0.77,
		b = 0.49,
	},
}
----------------------------------------------------------------
E.menuBackdrop = {
	bgFile = E.bgFile,
	edgeFile = E.edgeFile,
	edgeSize = 1,
}
E.OctoTable_Frames = {}
E.listMaxSize = 30
E.DEVTEXT = "|T".. E.AddonTexture_1 ..":14:14:::64:64:4:60:4:60|t" .. E.Green_Color.. "DebugInfo|r: "
E.KILLTEXT = "|T".. "Interface\\Addons\\"..E.GlobalAddonName.."\\Media\\ElvUI\\Facepalm.tga" ..":14:14:::64:64:4:60:4:60|t"
----------------------------------------------------------------
E.OctoTable_bytetoB64 = {
	[0] =
	"a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p",
	"q", "r", "s", "t", "u", "v", "w", "x",
	"y", "z", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U", "V",
	"W", "X", "Y", "Z", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "(", ")",
}
--------------------------------------------------------------------------------
E.OctoTable_bytetoB64Color = {
	[0] =
	"0", "1", "2", "3", "4", "5", "6", "7", "8",
	"9", "A", "B", "C", "D", "E", "F",
}
E.OctoTable_RIO_COLORS = {
	{["score"] = 10000, ["color"] = {1, 0.5, 0}},
	{["score"] = 3975, ["color"] = {1, 0.5, 0}},
	{["score"] = 3900, ["color"] = {1, 0.49, 0.07}},
	{["score"] = 3875, ["color"] = {0.99, 0.49, 0.11}},
	{["score"] = 3850, ["color"] = {0.99, 0.48, 0.14}},
	{["score"] = 3825, ["color"] = {0.99, 0.48, 0.17}},
	{["score"] = 3805, ["color"] = {0.98, 0.47, 0.19}},
	{["score"] = 3780, ["color"] = {0.98, 0.47, 0.22}},
	{["score"] = 3755, ["color"] = {0.98, 0.46, 0.24}},
	{["score"] = 3730, ["color"] = {0.97, 0.45, 0.25}},
	{["score"] = 3705, ["color"] = {0.97, 0.45, 0.27}},
	{["score"] = 3685, ["color"] = {0.96, 0.44, 0.29}},
	{["score"] = 3660, ["color"] = {0.96, 0.44, 0.31}},
	{["score"] = 3635, ["color"] = {0.96, 0.43, 0.33}},
	{["score"] = 3610, ["color"] = {0.95, 0.42, 0.35}},
	{["score"] = 3585, ["color"] = {0.95, 0.42, 0.36}},
	{["score"] = 3565, ["color"] = {0.95, 0.41, 0.38}},
	{["score"] = 3540, ["color"] = {0.94, 0.41, 0.4}},
	{["score"] = 3515, ["color"] = {0.93, 0.4, 0.41}},
	{["score"] = 3490, ["color"] = {0.93, 0.39, 0.43}},
	{["score"] = 3465, ["color"] = {0.93, 0.39, 0.44}},
	{["score"] = 3445, ["color"] = {0.92, 0.38, 0.46}},
	{["score"] = 3420, ["color"] = {0.91, 0.38, 0.47}},
	{["score"] = 3395, ["color"] = {0.91, 0.37, 0.49}},
	{["score"] = 3370, ["color"] = {0.9, 0.36, 0.51}},
	{["score"] = 3345, ["color"] = {0.9, 0.36, 0.52}},
	{["score"] = 3325, ["color"] = {0.89, 0.35, 0.54}},
	{["score"] = 3300, ["color"] = {0.89, 0.35, 0.55}},
	{["score"] = 3275, ["color"] = {0.88, 0.34, 0.56}},
	{["score"] = 3250, ["color"] = {0.87, 0.33, 0.58}},
	{["score"] = 3225, ["color"] = {0.87, 0.33, 0.6}},
	{["score"] = 3205, ["color"] = {0.86, 0.32, 0.61}},
	{["score"] = 3180, ["color"] = {0.85, 0.32, 0.63}},
	{["score"] = 3155, ["color"] = {0.84, 0.31, 0.64}},
	{["score"] = 3130, ["color"] = {0.84, 0.31, 0.66}},
	{["score"] = 3105, ["color"] = {0.83, 0.3, 0.67}},
	{["score"] = 3085, ["color"] = {0.82, 0.29, 0.69}},
	{["score"] = 3060, ["color"] = {0.81, 0.29, 0.7}},
	{["score"] = 3035, ["color"] = {0.8, 0.28, 0.72}},
	{["score"] = 3010, ["color"] = {0.8, 0.27, 0.73}},
	{["score"] = 2985, ["color"] = {0.78, 0.27, 0.75}},
	{["score"] = 2965, ["color"] = {0.78, 0.27, 0.76}},
	{["score"] = 2940, ["color"] = {0.76, 0.26, 0.78}},
	{["score"] = 2915, ["color"] = {0.76, 0.25, 0.8}},
	{["score"] = 2890, ["color"] = {0.75, 0.25, 0.81}},
	{["score"] = 2865, ["color"] = {0.73, 0.24, 0.82}},
	{["score"] = 2845, ["color"] = {0.72, 0.24, 0.84}},
	{["score"] = 2820, ["color"] = {0.71, 0.23, 0.85}},
	{["score"] = 2795, ["color"] = {0.7, 0.23, 0.87}},
	{["score"] = 2770, ["color"] = {0.68, 0.22, 0.89}},
	{["score"] = 2745, ["color"] = {0.67, 0.22, 0.9}},
	{["score"] = 2725, ["color"] = {0.65, 0.21, 0.92}},
	{["score"] = 2700, ["color"] = {0.64, 0.21, 0.93}},
	{["score"] = 2660, ["color"] = {0.62, 0.23, 0.93}},
	{["score"] = 2635, ["color"] = {0.6, 0.25, 0.93}},
	{["score"] = 2610, ["color"] = {0.58, 0.27, 0.92}},
	{["score"] = 2585, ["color"] = {0.55, 0.29, 0.92}},
	{["score"] = 2560, ["color"] = {0.53, 0.31, 0.91}},
	{["score"] = 2540, ["color"] = {0.51, 0.32, 0.91}},
	{["score"] = 2515, ["color"] = {0.48, 0.34, 0.91}},
	{["score"] = 2490, ["color"] = {0.46, 0.35, 0.9}},
	{["score"] = 2465, ["color"] = {0.43, 0.36, 0.9}},
	{["score"] = 2440, ["color"] = {0.4, 0.37, 0.89}},
	{["score"] = 2420, ["color"] = {0.37, 0.38, 0.89}},
	{["score"] = 2395, ["color"] = {0.34, 0.4, 0.89}},
	{["score"] = 2370, ["color"] = {0.3, 0.4, 0.88}},
	{["score"] = 2345, ["color"] = {0.26, 0.42, 0.88}},
	{["score"] = 2320, ["color"] = {0.21, 0.42, 0.87}},
	{["score"] = 2300, ["color"] = {0.14, 0.43, 0.87}},
	{["score"] = 2275, ["color"] = {0, 0.44, 0.87}},
	{["score"] = 2195, ["color"] = {0.08, 0.45, 0.85}},
	{["score"] = 2170, ["color"] = {0.13, 0.46, 0.85}},
	{["score"] = 2145, ["color"] = {0.16, 0.47, 0.84}},
	{["score"] = 2120, ["color"] = {0.19, 0.48, 0.83}},
	{["score"] = 2100, ["color"] = {0.21, 0.49, 0.82}},
	{["score"] = 2075, ["color"] = {0.23, 0.5, 0.81}},
	{["score"] = 2050, ["color"] = {0.24, 0.51, 0.8}},
	{["score"] = 2025, ["color"] = {0.26, 0.51, 0.78}},
	{["score"] = 2000, ["color"] = {0.27, 0.53, 0.78}},
	{["score"] = 1980, ["color"] = {0.28, 0.53, 0.76}},
	{["score"] = 1955, ["color"] = {0.29, 0.55, 0.76}},
	{["score"] = 1930, ["color"] = {0.3, 0.55, 0.75}},
	{["score"] = 1905, ["color"] = {0.31, 0.56, 0.73}},
	{["score"] = 1880, ["color"] = {0.32, 0.57, 0.73}},
	{["score"] = 1860, ["color"] = {0.33, 0.58, 0.71}},
	{["score"] = 1835, ["color"] = {0.33, 0.59, 0.7}},
	{["score"] = 1810, ["color"] = {0.34, 0.6, 0.69}},
	{["score"] = 1785, ["color"] = {0.35, 0.61, 0.68}},
	{["score"] = 1760, ["color"] = {0.35, 0.62, 0.67}},
	{["score"] = 1740, ["color"] = {0.36, 0.63, 0.66}},
	{["score"] = 1715, ["color"] = {0.36, 0.64, 0.65}},
	{["score"] = 1690, ["color"] = {0.36, 0.65, 0.64}},
	{["score"] = 1665, ["color"] = {0.36, 0.66, 0.63}},
	{["score"] = 1640, ["color"] = {0.37, 0.67, 0.62}},
	{["score"] = 1620, ["color"] = {0.37, 0.68, 0.61}},
	{["score"] = 1595, ["color"] = {0.37, 0.69, 0.6}},
	{["score"] = 1570, ["color"] = {0.37, 0.7, 0.58}},
	{["score"] = 1545, ["color"] = {0.37, 0.71, 0.57}},
	{["score"] = 1520, ["color"] = {0.37, 0.72, 0.56}},
	{["score"] = 1500, ["color"] = {0.37, 0.73, 0.55}},
	{["score"] = 1475, ["color"] = {0.37, 0.74, 0.54}},
	{["score"] = 1450, ["color"] = {0.37, 0.75, 0.53}},
	{["score"] = 1425, ["color"] = {0.37, 0.76, 0.51}},
	{["score"] = 1400, ["color"] = {0.37, 0.77, 0.5}},
	{["score"] = 1380, ["color"] = {0.37, 0.78, 0.49}},
	{["score"] = 1355, ["color"] = {0.36, 0.79, 0.47}},
	{["score"] = 1330, ["color"] = {0.36, 0.8, 0.46}},
	{["score"] = 1305, ["color"] = {0.36, 0.82, 0.45}},
	{["score"] = 1280, ["color"] = {0.35, 0.82, 0.44}},
	{["score"] = 1260, ["color"] = {0.35, 0.84, 0.42}},
	{["score"] = 1235, ["color"] = {0.34, 0.84, 0.41}},
	{["score"] = 1210, ["color"] = {0.34, 0.85, 0.39}},
	{["score"] = 1185, ["color"] = {0.33, 0.87, 0.38}},
	{["score"] = 1160, ["color"] = {0.32, 0.87, 0.36}},
	{["score"] = 1140, ["color"] = {0.31, 0.89, 0.35}},
	{["score"] = 1115, ["color"] = {0.31, 0.9, 0.33}},
	{["score"] = 1090, ["color"] = {0.29, 0.91, 0.31}},
	{["score"] = 1065, ["color"] = {0.28, 0.92, 0.29}},
	{["score"] = 1040, ["color"] = {0.27, 0.93, 0.27}},
	{["score"] = 1020, ["color"] = {0.26, 0.94, 0.25}},
	{["score"] = 995, ["color"] = {0.24, 0.95, 0.23}},
	{["score"] = 970, ["color"] = {0.22, 0.96, 0.2}},
	{["score"] = 945, ["color"] = {0.2, 0.97, 0.17}},
	{["score"] = 920, ["color"] = {0.18, 0.98, 0.14}},
	{["score"] = 900, ["color"] = {0.15, 0.99, 0.09}},
	{["score"] = 875, ["color"] = {0.12, 1, 0}},
	{["score"] = 850, ["color"] = {0.22, 1, 0.13}},
	{["score"] = 825, ["color"] = {0.29, 1, 0.19}},
	{["score"] = 800, ["color"] = {0.35, 1, 0.24}},
	{["score"] = 775, ["color"] = {0.4, 1, 0.29}},
	{["score"] = 750, ["color"] = {0.44, 1, 0.33}},
	{["score"] = 725, ["color"] = {0.47, 1, 0.36}},
	{["score"] = 700, ["color"] = {0.51, 1, 0.4}},
	{["score"] = 675, ["color"] = {0.55, 1, 0.44}},
	{["score"] = 650, ["color"] = {0.58, 1, 0.47}},
	{["score"] = 625, ["color"] = {0.6, 1, 0.5}},
	{["score"] = 600, ["color"] = {0.64, 1, 0.53}},
	{["score"] = 575, ["color"] = {0.66, 1, 0.56}},
	{["score"] = 550, ["color"] = {0.69, 1, 0.59}},
	{["score"] = 525, ["color"] = {0.71, 1, 0.62}},
	{["score"] = 500, ["color"] = {0.74, 1, 0.65}},
	{["score"] = 475, ["color"] = {0.76, 1, 0.68}},
	{["score"] = 450, ["color"] = {0.79, 1, 0.71}},
	{["score"] = 425, ["color"] = {0.81, 1, 0.74}},
	{["score"] = 400, ["color"] = {0.83, 1, 0.77}},
	{["score"] = 375, ["color"] = {0.85, 1, 0.8}},
	{["score"] = 350, ["color"] = {0.88, 1, 0.83}},
	{["score"] = 325, ["color"] = {0.9, 1, 0.85}},
	{["score"] = 300, ["color"] = {0.92, 1, 0.88}},
	{["score"] = 275, ["color"] = {0.94, 1, 0.91}},
	{["score"] = 250, ["color"] = {0.96, 1, 0.94}},
	{["score"] = 225, ["color"] = {0.98, 1, 0.97}},
	{["score"] = 200, ["color"] = {1, 1, 1}},
}
----------------------------------------------------------------
local AddonManager = CreateFrame("Frame")
local profiles = {}
local currentProfile = "default"
function E.func_GetAddonIndex(name)
	local index = OctoToDo_AddonsTable.indexByName[name]
	return tonumber(index)
end
function E.func_GetAddonName(index)
	local name = select(1, C_AddOns.GetAddOnInfo(index))
	return name
end
function E.func_GetAddonTitle(index)
	local title = select(2, C_AddOns.GetAddOnInfo(index))
	return title
end
function E.func_GetAddonNotes(index)
	local notes = select(2, C_AddOns.GetAddOnInfo(index))
	return notes
end
function E.func_GetAddonLoadable(index, character)
	character = character or UnitName("player")
	local loadable = select(1, C_AddOns.IsAddOnLoadable(index, character));
	return loadable
end
function E.func_GetAddonReason(index, character)
	character = character or UnitName("player")
	local reason = select(2, C_AddOns.IsAddOnLoadable(index, character));
	return reason
end
function E.func_IsAddonInstalled(index) -- Исключаем отсутствующие аддоны
	local reason = select(5, C_AddOns.GetAddOnInfo(index))
	return reason ~= "MISSING"
end
function E.func_GetAddonSecurity(index)
	local security = select(6, C_AddOns.GetAddOnInfo(index))
	return security
end
function E.func_GetAddonUpdateAvailable(index)
	local updateAvailable = select(7, C_AddOns.GetAddOnInfo(index))
	return updateAvailable
end
function E.func_GetAddonVersion(index)
	local Version = C_AddOns.GetAddOnMetadata(index, "Version") or 0
	return Version
end
function E.func_GetAddonAuthor(index)
	local Author = C_AddOns.GetAddOnMetadata(index, "Author") or ""
	return Author
end
function E.func_GetAddoniconTexture(index)
	local iconTexture = C_AddOns.GetAddOnMetadata(index, "IconTexture")
	return iconTexture
end
function E.func_GetAddoniconAtlas(index)
	local iconAtlas = C_AddOns.GetAddOnMetadata(index, "IconAtlas")
	return iconAtlas
end
function E.func_GetAddonCategory(index)
	local Category = C_AddOns.GetAddOnMetadata(index, "Category")
	return Category
end
function E.func_GetAddonGroup(index)
	local Group = C_AddOns.GetAddOnMetadata(index, "Group")
	return Group
end
function E.func_IsAddOnLoaded(index)
	local loadedOrLoading = select(1, C_AddOns.IsAddOnLoaded(index))
	return loadedOrLoading
end
function E.func_GetAddOnEnableState(i, character)
	character = character or UnitName("player")
	return C_AddOns.GetAddOnEnableState(i, character)
end
function E.func_IsAddOnLoadable(index, character)
	local loadable = select(1, C_AddOns.IsAddOnLoadable(index, character)) -- reason 2
	return loadable
end
function E.func_DoesAddOnExist(index)
	return C_AddOns.DoesAddOnExist(index)
end
function E.func_IsAddOnDefaultEnabled(index)
	return C_AddOns.IsAddOnDefaultEnabled(index)
end
function E.func_GetAddOnDependenciesTable(index)
	return {C_AddOns.GetAddOnDependencies(index)}
end
function E.func_GetAddOnDependenciesSTR(index)
	return C_AddOns.GetAddOnDependencies(index)
end
function E.func_GetNumReps()
	local LineNumber = 0
	C_Reputation.ExpandAllFactionHeaders()
	for i = 1, C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(i)
		if factionData then
			if (factionData.isHeaderWithRep or not factionData.isHeader) then
				LineNumber = LineNumber + 1
			end
		end
	end
	return LineNumber
end
function E.func_GetNumAddOns()
	local NumAddOns = C_AddOns.GetNumAddOns()
	return NumAddOns
end
function E.func_EnableAddOn(name, character)
	character = character or UnitName("player")
	return C_AddOns.EnableAddOn(name, character)
end
function E.func_EnableAllAddOns(character) -- Включить все аддоны
	character = character or UnitName("player")
	return C_AddOns.EnableAllAddOns(character)
end
function E.func_DisableAddOn(name, character)
	character = character or UnitName("player")
	return C_AddOns.DisableAddOn(name, character)
end
function E.func_DisableAllAddons()
	for index, name in ipairs(E.func_GetAllAddons()) do
		if not OctoToDo_AddonsManager.lock.addons[name] then
			E.func_DisableAddOn(index)
		end
	end
end
function E.func_IsProfilerEnabled()
	return C_AddOnProfiler.IsEnabled()
end
function E.UpdatePerformance()
	if E.func_IsProfilerEnabled() then
		UpdateAddOnMemoryUsage()
		-- UpdateAddOnCPUUsage() -- НЕ РАБОТАЕТ?
	end
end
function E.func_IsAddonVersionCheckEnabled()
	return C_AddOns.IsAddonVersionCheckEnabled()
end
-- Получить список всех аддонов
function E.func_GetAllAddons()
	local addons = {}
	for index = 1, E.func_GetNumAddOns() do
		if E.func_IsAddonInstalled(index) then -- Исключаем отсутствующие аддоны
			table.insert(addons, E.func_GetAddonName(index))
		end
	end
	return addons
end
-- Показать список аддонов с их статусом
function E.func_ListAddons(filter)
	local addons = E.func_GetAllAddons()
	print ("Список аддонов ("..#addons.."):")
	for index, name in ipairs(addons) do
		if not filter or string.find(string.lower(name), string.lower(filter)) then
			local status = E.func_IsAddOnLoaded(index) and "|cff00ff00ВКЛ|r" or "|cffff0000ВЫКЛ|r"
			print(string.format("%3d. %s - %s", index, name, status))
		end
	end
end
function E.AddonListEntry_SetEnabled(index, character, enabled)
	if enabled == nil then
		enabled = C_AddOns.IsAddOnDefaultEnabled(index)
	end
	if enabled then
		E.func_EnableAddOn(index, character)
	else
		E.func_DisableAddOn(index, character)
	end
end
function E.AddonList_HasAnyChanged()
	if (AddonList.outOfDate and not E.func_IsAddonVersionCheckEnabled() or (not AddonList.outOfDate and E.func_IsAddonVersionCheckEnabled() and AddonList_HasOutOfDate())) then
		return true
	end
	for i=1,E.func_GetNumAddOns() do
		local character = nil
		character = UnitName("player")
		local enabled = (E.func_GetAddOnEnableState(i, character) > Enum.AddOnEnableState.None)
		if ( enabled ~= AddonList.startStatus[i] and E.func_GetAddonReason(i) ~= "DEP_DISABLED" ) then
			return true
		end
	end
	return false
end
function E.AddonTooltipBuildDepsString(index, color)
	color = color or "|cff000000"
	local deps = E.func_GetAddOnDependenciesTable(index)
	local depsString = ""
	for i, name in ipairs(deps) do
		if i == 1 then
			depsString = "Родители:|n" -- ADDON_DEPENDENCIES
		end
		depsString = depsString..color.."    "..(name).."|r|n"
	end
	return depsString
end
function E.IsAddonSelected(nameOrIndex, forSome, charGuid)
	if (forSome) then
		local state = E.func_GetAddOnEnableState(nameOrIndex, nil)
		return state == 1
	end
	-- local guid = charGuid or E.GetSelectedCharGuid()
	-- if (charGuid == true) then
	--     guid = nil
	-- end
	local state = E.func_GetAddOnEnableState(nameOrIndex, guid)
	return state == 2
end
-- function E.GetSelectedCharGuid()
--     if (selectedCharIndex >= 1) then return orderedCharList[selectedCharIndex + 1].guid end
--     return nil
-- end
function E.LocalizeCategoryName(name, isUserCategory)
	if (isUserCategory) then
		return name
	end
	return rawget(L, string.lower(name)) or name
end
function E.GetCategoryTables()
	local db = self:GetDb()
	local userCategories = db.categories
	local tocCategories = categoryTocTable
	return userCategories, tocCategories, fixedCategories
end
function E.CategoriesForAddon(name)
	local userTable, tocTable, fixedTable = E.GetCategoryTables()
	local resultText = ""
	local sep = ""
	for _, categoryTable in pairs(userTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText .. sep .. E.LocalizeCategoryName(categoryTable.name, userTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(tocTable) do
		if (categoryTable.addons[name]) then
			resultText = resultText .. sep .. E.LocalizeCategoryName(categoryTable.name, tocTable)
			sep = ", "
		end
	end
	for _, categoryTable in pairs(fixedTable) do
		if (categoryTable.prepare) then categoryTable:prepare() end
		if (categoryTable:addons(name)) then
			resultText = resultText .. sep .. categoryTable.name
			sep = ", "
		end
	end
	return resultText
end
function E.rec_toggle(index, state)
	if state then
		E.func_DisableAddOn(index)
		-- print ("|cffff0000отключен|r".. index)
	else
		E.func_EnableAddOn(index)
		-- print ("|cff00ff00включен|r".. index)
	end
	if OctoToDo_AddonsTable.depsByIndex[index] and not IsModifierKeyDown() then
		for i, depIndex in ipairs(OctoToDo_AddonsTable.depsByIndex[index]) do
			E.rec_toggle(depIndex, state)
		end
	end
end
-- Переключить аддон
function E.func_ToggleAddon(index, state)
	local addonName = C_AddOns.GetAddOnInfo(index)
	local enabled = E.func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E.rec_toggle(index, enabled)
end
-- СОЗДАЕТ ФРЕЙМЫ / РЕГИОНЫ(текстуры, шрифты) / ЧИЛДЫ / CALLBACK
function E.func_LockAddon(index)
	local name = E.func_GetAddonName(index)
	if OctoToDo_AddonsManager.lock.addons[name] then
		OctoToDo_AddonsManager.lock.addons[name] = false
	else
		OctoToDo_AddonsManager.lock.addons[name] = true
		-- E.func_EnableAddOn(index)
	end
end
function E.rec_lock(index)
	E.func_LockAddon(index)
	if OctoToDo_AddonsTable.depsByIndex[index] and not IsModifierKeyDown() then
		for i, depIndex in ipairs(OctoToDo_AddonsTable.depsByIndex[index]) do
			E.rec_lock(depIndex)
		end
	end
end
-- Переключить аддон
function E.func_lockAddonNEW(index, state)
	local addonName = C_AddOns.GetAddOnInfo(index)
	local enabled = E.func_GetAddOnEnableState(index, UnitName("player")) > Enum.AddOnEnableState.None
	E.rec_lock(index, enabled)
end
-- Сохранить текущий профиль
function E.func_SaveProfile(profileName)
	if not profileName or profileName == "" then
		profileName = currentProfile
	end
	OctoToDo_AddonsManager.profiles = OctoToDo_AddonsManager.profiles or {}
	OctoToDo_AddonsManager.profiles[profileName] = {}
	local addons = E.func_GetAllAddons()
	for index, name in ipairs(addons) do
		OctoToDo_AddonsManager.profiles[profileName][name] = E.func_IsAddOnLoaded(index)
	end
	print ("Профиль '"..profileName.." сохранен ("..#addons.." аддонов)")
end
-- Загрузить профиль
function E.func_LoadProfile(profileName)
	if not OctoToDo_AddonsManager.profiles[profileName] then
		print ("Профиль '"..profileName.." не найден")
		return
	end
	for name, enabled in pairs(OctoToDo_AddonsManager.profiles[profileName]) do
		if enabled then
			E.func_EnableAddOn(name)
		else
			E.func_DisableAddOn(name)
		end
	end
	currentProfile = profileName
	print ("Профиль '"..profileName.." загружен")
	-- ReloadUI()
end
-- Список профилей
function E.func_ListProfiles()
	print ("Доступные профили:")
	for name, _ in pairs(OctoToDo_AddonsManager.profiles) do
		print("- "..name)
	end
end
-- Обработчик команд
local function func_HandleCommand(msg)
	local command, arg1, arg2 = strsplit(" ", msg, 3)
	if command == "list" then
		E.func_ListAddons(arg1)
	elseif command == "toggle" then
		E.func_ToggleAddon(arg1)
	elseif command == "enableall" then
		E.func_EnableAllAddOns()
	elseif command == "disableall" then
		E.func_DisableAllAddons()
	elseif command == "save" then
		E.func_SaveProfile(arg1)
	elseif command == "load" then
		E.func_LoadProfile(arg1)
	elseif command == "profiles" then
		E.func_ListProfiles()
	else
		print ("Команды:")
		print("/uam list [фильтр] - список аддонов")
		print("/uam toggle <имя/номер> - переключить аддон")
		print("/uam enableall - включить все аддоны")
		print("/uam disableall - выключить все аддоны")
		print("/uam save [профиль] - сохранить текущие настройки")
		print("/uam load <профиль> - загрузить профиль")
		print("/uam profiles - список профилей")
	end
end
-- Инициализация при загрузке
-- Регистрируем команды
SLASH_UNIVERSALADDONMANAGER1 = "/uam"
SlashCmdList["UNIVERSALADDONMANAGER"] = func_HandleCommand
function E.GetAddonMetricPercent(addonName, metric, warningInLeftSide, def)
	if (not E.func_IsProfilerEnabled()) then
		return def or ""
	end
	local overall = C_AddOnProfiler.GetOverallMetric(metric)
	local addon = C_AddOnProfiler.GetAddOnMetric(addonName, metric)
	local relative = overall
	if (C_AddOnProfiler.GetApplicationMetric) then
		local app = C_AddOnProfiler.GetApplicationMetric(metric)
		relative = app - overall + addon
	end
	if relative <= 0 then
		return def or ""
	end
	local percent = addon / relative
	if (warningInLeftSide) then
		return E.GetWarningFor(percent)..E.FormatProfilerPercent(percent * 100.0)
	end
	return E.FormatProfilerPercent(percent * 100.0)..E.GetWarningFor(percent)
end
----------------------------------------------------------------
function E.FormatProfilerPercent(pct)
	local color = E.White_Color
	if (pct > 25) then color = E.Yellow_Color end
	if (pct > 50) then color = E.Orange_Color end
	if (pct > 80) then color = E.Red_Color end
	local vivod = string.format("%.2f", pct)
	return vivod
	-- return color:WrapText(string.format("%.2f", pct))..E.White_Color:WrapText("%")
end
----------------------------------------------------------------
function E.GetCVarNumber(name)
	-- if the CVar doesn't exist, the GetCVar returns "nothing" (not even nil) and the tonumber fails
	local number = tonumber(GetCVar(name) or nil)
	return number or tonumber(GetCVarDefault(name) or nil)
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetWarningFor(percent)
	local warningPercent = E.GetCVarNumber("addonPerformanceMsgWarning") or -1
	if (warningPercent > 0.0 and warningPercent < 1.0 and percent > warningPercent) then
		return " "..CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16)
	end
	return ""
end
----------------------------------------------------------------
----------------------------------------------------------------
function E.GetAddonMetricCount(addonName, metric)
	if (not E.func_IsProfilerEnabled()) then
		return ""
	end
	local count = C_AddOnProfiler.GetAddOnMetric(addonName, metric) or 0
	return count
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- function E.func_CompactMemory(memory)
--     if memory > 0 then
--         if memory > 1024 then
--             return string.format(ADDON_LIST_PERFORMANCE_MEMORY_MB, memory/1024)
--         else
--             return string.format(ADDON_LIST_PERFORMANCE_MEMORY_KB, memory)
--         end
--     else
--         return 0
--     end
-- end
----------------------------------------------------------------
function E.AddonTooltip_BuildDeps(...)
	local deps = ""
	for i=1, select("#", ...) do
		if i == 1 then
			deps = ADDON_DEPENDENCIES..select(i, ...)
		else
			deps = deps..", "..select(i, ...)
		end
	end
	return deps
end
----------------------------------------------------------------
function E.AddonList_IsAddOnLoadOnDemand(index)
	local lod = false
	if C_AddOns.IsAddOnLoadOnDemand(index) then
		local deps = E.func_GetAddOnDependenciesSTR(index)
		local okay = true
		for i = 1, select('#', deps) do
			local dep = select(i, deps)
			if ( dep and not E.func_IsAddOnLoaded(select(i, deps)) ) then
				okay = false
				break
			end
		end
		lod = okay
	end
	return lod
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
local function getFunction(fun)
	return (C_AddOns and C_AddOns[fun]) or _G[fun]
end
E.compat = {
	EnableAddOn = getFunction("EnableAddOn"),
	DisableAddOn = getFunction("DisableAddOn"),
	IsAddOnLoaded = getFunction("IsAddOnLoaded"),
	EnableAllAddOns = getFunction("EnableAllAddOns"),
	DisableAllAddOns = getFunction("DisableAllAddOns"),
	GetAddOnInfo = getFunction("GetAddOnInfo"),
	GetAddOnDependencies = getFunction("GetAddOnDependencies"),
	GetNumAddOns = getFunction("GetNumAddOns"),
	SaveAddOns = getFunction("SaveAddOns"),
	ResetAddOns = getFunction("ResetAddOns"),
	IsAddonVersionCheckEnabled = getFunction("IsAddonVersionCheckEnabled"),
	SetAddonVersionCheck = getFunction("SetAddonVersionCheck"),
	IsAddOnLoadOnDemand = getFunction("IsAddOnLoadOnDemand"),
	GetAddOnEnableState = (C_AddOns and C_AddOns.GetAddOnEnableState) or function(nameOrIndex, character)
		return GetAddOnEnableState(character, nameOrIndex) -- the old API has inverted parameters
	end
}
----------------------------------------------------------------
function E.func_NumPlayers()
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = OctoToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = OctoToDo_DB_Vars.LevelToShowMAX
	local sorted = {}
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == E.curServer)
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == E.curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	return #sorted or 1
end
function E.sorted()
	local ShowOnlyCurrentServer = OctoToDo_DB_Vars.ShowOnlyCurrentServer
	local ShowOnlyCurrentBattleTag = OctoToDo_DB_Vars.ShowOnlyCurrentBattleTag
	local LevelToShow = OctoToDo_DB_Vars.LevelToShow
	local LevelToShowMAX = OctoToDo_DB_Vars.LevelToShowMAX
	local sorted = {}
	for GUID, CharInfo in next, (OctoToDo_DB_Levels) do
		if ShowOnlyCurrentBattleTag == true then
			if (ShowOnlyCurrentServer == true
				and (CharInfo.curServer == E.curServer)
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.BattleTagLocal == E.BattleTagLocal)
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		else
			if ((ShowOnlyCurrentServer == true and (CharInfo.curServer == E.curServer))
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (ShowOnlyCurrentServer == false
				and (CharInfo.isShownPLAYER == true)
				and (CharInfo.UnitLevel >= LevelToShow)
				and (CharInfo.UnitLevel <= LevelToShowMAX))
			or (E.curGUID == CharInfo.GUID) then
				sorted[#sorted+1] = CharInfo
			end
		end
	end
	return sorted



	-- local list = sorted
	-- sort(list, function(a, b)
	-- 		local infoA = OctoToDo_DB_Levels[a]
	-- 		local infoB = OctoToDo_DB_Levels[b]
	-- 		if infoA and infoB then
	-- 			return
	-- 			infoA.curServer > infoB.curServer or
	-- 			infoA.curServer == infoB.curServer and infoA.UnitLevel > infoB.UnitLevel or
	-- 			infoA.UnitLevel == infoB.UnitLevel and infoA.avgItemLevel > infoB.avgItemLevel or
	-- 			infoA.avgItemLevel == infoB.avgItemLevel and infoB.Name > infoA.Name
	-- 		end
	-- 	end
	-- )

	-- return list
end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------