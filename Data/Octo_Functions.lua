local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
local inspectScantipFUNC = nil
if not inspectScantipFUNC then
	inspectScantipFUNC = CreateFrame("GameTooltip", "OctoToDoScanningTooltipFUNC", nil, "GameTooltipTemplate")
	inspectScantipFUNC:SetOwner(UIParent, "ANCHOR_NONE")
end
----------------------------------------------------------------
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
-- local utf8len, utf8sub, utf8reverse, utf8upper, utf8lower = string.utf8len, string.utf8sub, string.utf8reverse, string.utf8upper, string.utf8lower
local utf8charbytes = E.Octo_Func.utf8charbytes
local utf8len = E.Octo_Func.utf8len
local utf8sub = E.Octo_Func.utf8sub
local utf8replace = E.Octo_Func.utf8replace
local utf8upper = E.Octo_Func.utf8upper
local utf8lower = E.Octo_Func.utf8lower
local utf8reverse = E.Octo_Func.utf8reverse
----------------------------------------------------------------
-- function E.Octo_Func.Octo_IsClassic()
-- 	local build = 1
-- 	local WOW_currentBuild = tonumber(GetBuildInfo():match("(.-)%."))
-- 	if build == WOW_currentBuild then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
-- --------------------------------------------------------------
-- function E.Octo_Func.Octo_IsWrathClassic()
-- 	local build = 3
-- 	local WOW_currentBuild = tonumber(GetBuildInfo():match("(.-)%."))
-- 	if build == WOW_currentBuild then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
-- --------------------------------------------------------------
-- function E.Octo_Func.Octo_IsRetail()
-- 	local build = 11
-- 	local WOW_currentBuild = tonumber(GetBuildInfo():match("(.-)%."))
-- 	if build == WOW_currentBuild then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
----------------------------------------------------------------
function E.Octo_Func.func_hex2rgb(self)
	self = self:gsub("|cff", "")
	return tonumber("0x"..self:sub(1, 2)), tonumber("0x"..self:sub(3, 4)), tonumber("0x"..self:sub(5, 6))
end
local func_hex2rgb = E.Octo_Func.func_hex2rgb
----------------------------------------------------------------
function E.Octo_Func.func_rgb2hex(r, g, b, a)
	local r = r or 1
	local g = g or 1
	local b = b or 1
	local a = a or 1
	if not a then
		a = 1
	end
	return "|c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
local func_rgb2hex = E.Octo_Func.func_rgb2hex
----------------------------------------------------------------
function E.Octo_Func.func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	return "c"..string.format("%02x", math.floor(a*255))..utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
local func_rgb2hexDEV = E.Octo_Func.func_rgb2hexDEV
----------------------------------------------------------------
function E.Octo_Func.func_percent(percent, maxvalue)
	if tonumber(percent) and tonumber(maxvalue) then
		return (maxvalue*percent)/100
	end
	return false
end
local func_percent = E.Octo_Func.func_percent
----------------------------------------------------------------
function E.Octo_Func.func_Gradient(text, firstColor, secondColor)
	local vivod = ""
	local maslengo = ""
	local total = utf8len(text)-1
	local r1, g1, b1 = E.Octo_Func.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.Octo_Func.func_hex2rgb(secondColor)
	local rdelta, gdelta, bdelta = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
	local r3 = r1
	local g3 = g1
	local b3 = b1
	for i = 1, total do
		maslengo = maslengo..("|cff%02x%02x%02x%s|r"):format(math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5), utf8sub(text, i, i))
		r3 = r3 + rdelta
		g3 = g3 + gdelta
		b3 = b3 + bdelta
	end
	vivod = maslengo..secondColor..utf8sub(text, utf8len(text)).."|r"
	return vivod
end
local Gradient = E.Octo_Func.func_Gradient
----------------------------------------------------------------
function E.Octo_Func.GenerateUniqueID()
	local s = {}
	for i=1, 11 do
		tinsert(s, E.Octo_Table.OctoTable_bytetoB64[math.random(0, 63)])
	end
	return table.concat(s)
end
local GenerateUniqueID = E.Octo_Func.GenerateUniqueID
----------------------------------------------------------------
function E.Octo_Func.GenerateUnique_Color()
	local s = {}
	for i=1, 6 do
		tinsert(s, E.Octo_Table.OctoTable_bytetoB64_Color[math.random(0, 15)])
	end
	return table.concat(s)
end
local GenerateUnique_Color = E.Octo_Func.GenerateUnique_Color
----------------------------------------------------------------
function E.Octo_Func.TableConcat(table1, table2)
	for i=1, #table2 do
		table1[#table1+1] = table2[i]
	end
	return table1
end
local TableConcat = E.Octo_Func.TableConcat
----------------------------------------------------------------
function E.Octo_Func.PlaySoundFile_whisper(self)
	if self then
		PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Memes\\"..self..".ogg", "Master")
	end
end
local PlaySoundFile_whisper = E.Octo_Func.PlaySoundFile_whisper
----------------------------------------------------------------
function E.Octo_Func.CompactNumberFormat(self)
	if not self then
		self = 0
	end
	if self == 0 then
		return 0
	elseif self < 1000 then
		return (math.floor((self+0.5)-0.5)/10)*10
	elseif self < 1000000 then
		return (math.floor(self/100)/10).."k"
	else
		return (math.floor(self/100000)/10).."m"
	end
end
local CompactNumberFormat = E.Octo_Func.CompactNumberFormat
----------------------------------------------------------------
function E.Octo_Func.func_texturefromIcon(self, size)
	local show = true -- TYT
	if show == true then
		if not size then
			size = 14
		end
		if not self or self == 0 then
			self = 134400
		end
		return "|T"..self..":"..size..":"..size..":::64:64:4:60:4:60|t"
	else
		return ""
	end
end
local func_texturefromIcon = E.Octo_Func.func_texturefromIcon
----------------------------------------------------------------
function E.Octo_Func.func_questName(self)
	local title = "notitle"
	if IsRetail() == true then
		title = C_QuestLog.GetTitleForQuestID(self)
		if title then
			return title
		else
			return E.Octo_Globals.Red_Color.."notitle".."|r"
		end
	end
	return title
end
local func_questName = E.Octo_Func.func_questName
----------------------------------------------------------------
function E.Octo_Func.func_reputationName(self)
	local repInfo = C_Reputation.GetFactionDataByID(self)
	local name
	if repInfo then
		name = repInfo.name
	else
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(self or 0)
		name = reputationInfo.name or E.Octo_Globals.Red_Color.."NONAME".."|r"
	end
	local color = "|cffFFFFFF"
	local r = "|r"
	if self == 1168 then
		color = "|cff909090"
	end
	return color..name..r
end
local func_reputationName = E.Octo_Func.func_reputationName
----------------------------------------------------------------
function E.Octo_Func.func_itemName_NOCOLOR(itemID)
	local itemName_NOCOLOR = LibThingsLoad:GetItemName(itemID) or "itemName_NOCOLOR"
	return itemName_NOCOLOR
end
local func_itemName_NOCOLOR = E.Octo_Func.func_itemName_NOCOLOR
----------------------------------------------------------------
function E.Octo_Func.func_itemName(itemID)
	local itemName = func_itemName_NOCOLOR(itemID) or "itemName"
	local itemQuality = select(3, GetItemInfo(itemID))
	if itemQuality then
		-- local r, g, b = ITEM_QUALITY_COLORS[itemQuality].color
		-- local r, g, b = GetItemQualityColor(itemQuality)
		-- local color = CreateColor(r, g, b, 1)
		-- local itemNameColored = color:WrapTextInColorCode(itemName)
		local itemNameColored = ITEM_QUALITY_COLORS[itemQuality].color:WrapTextInColorCode(itemName)
		return itemNameColored or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
	return itemName or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
end
local func_itemName = E.Octo_Func.func_itemName
----------------------------------------------------------------
function E.Octo_Func.func_itemTexture(self)
	local itemTexture = select(10, GetItemInfo(self)) or 134400
	return E.Octo_Func.func_texturefromIcon(itemTexture)
end
local func_itemTexture = E.Octo_Func.func_itemTexture
----------------------------------------------------------------
function E.Octo_Func.func_currencyName(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		local name = info.name
		local iconFileID = info.iconFileID
		local quality = info.quality
		local r, g, b = GetItemQualityColor(quality)
		local color = CreateColor(r, g, b, 1)
		local currencyName = color:WrapTextInColorCode(name)
		return currencyName
	else
		return E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
end
local func_currencyName = E.Octo_Func.func_currencyName
----------------------------------------------------------------
function E.Octo_Func.func_currencyName_NOCOLOR(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		local name = info.name
		-- local iconFileID = info.iconFileID
		-- local quality = info.quality
		-- local r, g, b = GetItemQualityColor(quality)
		-- local color = CreateColor(r, g, b, 1)
		-- local currencyName = color:WrapTextInColorCode(name)
		return name
	else
		return E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
end
local func_currencyName_NOCOLOR = E.Octo_Func.func_currencyName_NOCOLOR
----------------------------------------------------------------
function E.Octo_Func.func_currencyicon(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		iconFileID = info.iconFileID
	else
		iconFileID = 134400
	end
	return E.Octo_Func.func_texturefromIcon(iconFileID)
end
local func_currencyicon = E.Octo_Func.func_currencyicon
----------------------------------------------------------------
function E.Octo_Func.func_currencyquantity(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		quantity = info.quantity or 0
	end
	return quantity
end
local func_currencyquantity = E.Octo_Func.func_currencyquantity
----------------------------------------------------------------
function E.Octo_Func.func_spellName(self)
	local name = GetSpellInfo(self)
	return name
end
local func_spellName = E.Octo_Func.func_spellName
----------------------------------------------------------------
function E.Octo_Func.SecondsToClock(self)
	-- local years, days, hours, mins, secs = "", "", "", "", ""
	local years, days, hours, mins, secs = 0, 0, 0, 0, 0
	local self = tonumber(self)
	if self <= 0 or self == nil then --
		return "0:00"
	elseif self >= (86400*365) then -- год
		years = floor(self / (86400*365))
		days = floor(mod(self, 31536000) / 86400)
		hours = floor(mod(self, 86400) / 3600)
		mins = floor(mod(self, 3600) / 60)
		return years..L["y. "]..days..L["d. "]..hours..L["h. "]..mins..L["m. "]
	elseif self >= 86400 then -- 24ч
		days = floor(self / 86400)
		hours = floor(mod(self, 86400) / 3600)
		mins = floor(mod(self, 3600) / 60)
		return days..L["d. "]..hours..L["h. "]..mins..L["m. "]
	elseif self >= 3600 then -- 1 час
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return hours..L["h. "]..mins..L["m. "]
	elseif self >= 600 then -- 10 минут
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return mins..L["m. "]
	elseif self >= 60 then -- минута
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%01.f", math.floor(self/60 - (hours*60)))
		return mins..L["m. "]
	else
		return self..L["s. "]
	end
end
local SecondsToClock = E.Octo_Func.SecondsToClock
----------------------------------------------------------------
function E.Octo_Func.Empty_Zero(self)
	if tonumber(self) == 0 then
		return ""
	end
	return self
end
local Empty_Zero = E.Octo_Func.Empty_Zero
----------------------------------------------------------------
function E.Octo_Func.tmstpDayReset(self)
	local self = self or 1
	return (math.ceil((tonumber(GetServerTime()) - E.Octo_Globals.thursdayReset)/(E.Octo_Globals.daytime*self))*E.Octo_Globals.daytime*self)+E.Octo_Globals.thursdayReset
end
local tmstpDayReset = E.Octo_Func.tmstpDayReset
----------------------------------------------------------------
function E.Octo_Func.All_objectives(self)
	if IsRetail() == true then
		local Octopussy = ""
		local objectives = C_QuestLog.GetQuestObjectives(self)
		local text, objectiveType, finished, fulfilled, required = GetQuestObjectiveInfo(self, 1, false)
		if objectives == nil then
			return ""
		end
		if objectiveType == "progressbar" then
			return "|cffFF0000"..GetQuestProgressBarPercent(self).."%|r"
		end
		if objectives then
			if objectives[5] then
				Octopussy = Octopussy..(objectives[5].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[5].text.."|r\n"
				Octopussy = Octopussy..(objectives[4].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[4].text.."|r\n"
				Octopussy = Octopussy..(objectives[3].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[3].text.."|r\n"
				Octopussy = Octopussy..(objectives[2].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[2].text.."|r\n"
				Octopussy = Octopussy..(objectives[1].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[1].text.."|r\n"
			elseif objectives[4] then
				Octopussy = Octopussy..(objectives[4].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[4].text.."|r\n"
				Octopussy = Octopussy..(objectives[3].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[3].text.."|r\n"
				Octopussy = Octopussy..(objectives[2].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[2].text.."|r\n"
				Octopussy = Octopussy..(objectives[1].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[1].text.."|r\n"
			elseif objectives[3] then
				Octopussy = Octopussy..(objectives[3].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[3].text.."|r\n"
				Octopussy = Octopussy..(objectives[2].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[2].text.."|r\n"
				Octopussy = Octopussy..(objectives[1].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[1].text.."|r\n"
			elseif objectives[2] then
				Octopussy = Octopussy..(objectives[2].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[2].text.."|r\n"
				Octopussy = Octopussy..(objectives[1].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[1].text.."|r\n"
			elseif objectives[1] then
				Octopussy = Octopussy..(objectives[1].finished and E.Octo_Globals.Gray_Color or E.Octo_Globals.White_Color) ..objectives[1].text.."|r\n"
			end
		end
		return Octopussy
	end
end
local All_objectives = E.Octo_Func.All_objectives
----------------------------------------------------------------
function E.Octo_Func.func_Octo_LoadAddOn(GlobalAddonName)
	if select(5, C_AddOns.GetAddOnInfo(GlobalAddonName)) == "DISABLED" then
		C_AddOns.EnableAddOn(GlobalAddonName)
		C_AddOns.LoadAddOn(GlobalAddonName)
	end
end
local func_Octo_LoadAddOn = E.Octo_Func.func_Octo_LoadAddOn
----------------------------------------------------------------
function E.Octo_Func.CheckCompletedByQuestID(self)
	if IsRetail() == true then
		local vivod
		local TEST = ""
		if C_QuestLog.IsQuestFlaggedCompleted(self) == true then
			vivod = (E.Octo_Globals.DONE)
		elseif C_QuestLog.IsComplete(self) == true then
			vivod = E.Octo_Globals.Purple_Color..">>СДАЙ<<|r"
		elseif C_QuestLog.IsQuestFlaggedCompleted(self) == false and C_QuestLog.IsOnQuest(self) == false then
			vivod = (E.Octo_Globals.NONE)
		elseif C_QuestLog.IsOnQuest(self) == true --[[and C_QuestLog.IsComplete(self) == false ]]then
			local objectives = C_QuestLog.GetQuestObjectives(self)
			if objectives == nil then
				return ""
			end
			for i = 1, #objectives do
				if objectives[i] then
					local objectiveText, objectiveType, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(self, i, false)
					if objectiveType == "progressbar" then
						TEST = E.Octo_Globals.Red_Color..GetQuestProgressBarPercent(self).."%|r"
					else
						if finished then
							TEST = E.Octo_Globals.Yellow_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
						else
							TEST = E.Octo_Globals.Red_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
						end
					end
				end
				vivod = vivod and vivod.."»"..TEST or TEST
			end
		end
		return vivod
	end
end
local CheckCompletedByQuestID = E.Octo_Func.CheckCompletedByQuestID
----------------------------------------------------------------
function E.Octo_Func.OnlyFirstWord(self)
	self = tostring(self)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", self)
	return a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z
end
local OnlyFirstWord = E.Octo_Func.OnlyFirstWord
----------------------------------------------------------------
function E.Octo_Func.OnlyLastWord(self)
	self = tostring(self)
	local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z = strsplit(" ", self)
	return z or y or x or w or v or u or t or s or r or q or p or i or n or m or l or k or j or i or h or g or f or e or d or c or b or a
end
local OnlyLastWord = E.Octo_Func.OnlyLastWord
----------------------------------------------------------------
function E.Octo_Func.InList(k, t, p)
	for _, v in pairs(t) do
		if (p and v[p]==k) or (not p and v==k) then
			return true
		end
	end
end
local InList = E.Octo_Func.InList
----------------------------------------------------------------
function E.Octo_Func.func_achievementID(self)
	return E.Octo_Globals.Yellow_Color.." (id: "..self..")".."|r"
end
local func_achievementID = E.Octo_Func.func_achievementID
----------------------------------------------------------------
function E.Octo_Func.func_achievementComplete(self)
	if not self then
		return false
	end
	local completed = select(4, GetAchievementInfo(self))
	return completed
end
local func_achievementComplete = E.Octo_Func.func_achievementComplete
----------------------------------------------------------------
function E.Octo_Func.func_achievementName(self)
	local Name = select(2, GetAchievementInfo(self))
	return Name..E.Octo_Func.func_achievementID(self)
end
local func_achievementName = E.Octo_Func.func_achievementName
----------------------------------------------------------------
function E.Octo_Func.func_achievementIcon(self)
	local Icon = select(10, GetAchievementInfo(self))
	return E.Octo_Func.func_texturefromIcon(Icon)
end
local func_achievementIcon = E.Octo_Func.func_achievementIcon
----------------------------------------------------------------
function E.Octo_Func.func_achievementvivod(self)
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	if completed == true then
		vivod = E.Octo_Globals.DONE
	else
		local numCriteria = GetAchievementNumCriteria(self)
		if numCriteria ~= 0 then
			local count = 0
			for i = 1, numCriteria do
				local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(self, i, false)
				if numCriteria == 1 then
					if quantity == 0 then
						vivod = E.Octo_Globals.Red_Color..quantity.." / "..reqQuantity.."|r"
					else
						vivod = quantity.." / "..reqQuantity
					end
				else
					if completedCrit == true then
						count = count + 1
					end
					if count == 0 then
						vivod = E.Octo_Globals.Red_Color..count.." / "..numCriteria.."|r"
					else
						vivod = count.." / "..numCriteria
					end
				end
			end
		else
			vivod = E.Octo_Globals.Red_Color.."0 / 1".."|r"
		end
	end
	return vivod
end
local func_achievementvivod = E.Octo_Func.func_achievementvivod
----------------------------------------------------------------
function E.Octo_Func.func_achievementcriteriaString(self, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	local description = select(8, GetAchievementInfo(self))
	local numCriteria = GetAchievementNumCriteria(self)
	local criteriaString, _, completedCrit, quantity = GetAchievementCriteriaInfo(self, i, false)
	local color = E.Octo_Globals.White_Color
	if completedCrit == true then
		color = E.Octo_Globals.Green_Color
	elseif completedCrit == false and quantity == 0 then
		color = E.Octo_Globals.Red_Color
	end
	if criteriaString and criteriaString ~= "" then
		vivod = vivod..color..criteriaString.."|r"
	else
		vivod = vivod..color..description.."|r"
	end
	return vivod
end
local func_achievementcriteriaString = E.Octo_Func.func_achievementcriteriaString
----------------------------------------------------------------
function E.Octo_Func.func_achievementquantity(self, i)
	i = i or 1
	local vivod = ""
	local completed = select(4, GetAchievementInfo(self))
	local description = select(8, GetAchievementInfo(self))
	local numCriteria = GetAchievementNumCriteria(self)
	local _, _, completedCrit, quantity, reqQuantity = GetAchievementCriteriaInfo(self, i, false)
	local color = E.Octo_Globals.White_Color
	if completedCrit == true then
		color = E.Octo_Globals.Green_Color
	elseif completedCrit == false and quantity == 0 then
		color = E.Octo_Globals.Red_Color
	end
	if quantity then
		vivod = vivod..color..quantity.." / "..reqQuantity.."|r"
	else
		vivod = vivod..color.."0/1PIZDA".."|r"
	end
	return vivod
end
local func_achievementquantity = E.Octo_Func.func_achievementquantity
----------------------------------------------------------------
function E.Octo_Func.func_achievementdescription(self)
	local description = select(8, GetAchievementInfo(self))
	return description
end
local func_achievementdescription = E.Octo_Func.func_achievementdescription
----------------------------------------------------------------
function E.Octo_Func.func_CurServerShort(self)
	local text = (self):gsub("-", " "):gsub("'", " ")
	local a, b = strsplit(" ", text)
	if b then
		self = utf8sub(a, 1, 1):upper()..utf8sub(b, 1, 1):upper()
	else
		self = utf8sub(a, 1, 1):upper()..utf8sub(a, 2, 3):lower()
	end
	return self
end
local func_CurServerShort = E.Octo_Func.func_CurServerShort
----------------------------------------------------------------
function E.Octo_Func.func_GetMapName(self)
	if not self then return end
	local info = C_Map.GetMapInfo(self)
	if info then
		local name = info.name
		return tostring(name)
	end
end
local func_GetMapName = E.Octo_Func.func_GetMapName
----------------------------------------------------------------
function E.Octo_Func.func_npcName(self)
	local name = "|cffFF0000error|r"
	if not self then return E.Octo_Globals.NONE end
	if self then
		inspectScantipFUNC:SetHyperlink("unit:Creature-0-0-0-0-"..self)
		if inspectScantipFUNC:NumLines() > 0 then
			name = _G["OctoToDoScanningTooltipFUNCTextLeft1"]:GetText()
			return name
		end
		inspectScantipFUNC:ClearLines()
	end
	return name
end
local func_npcName = E.Octo_Func.func_npcName
----------------------------------------------------------------
function E.Octo_Func.RIO_Color(self)
	local hexColor = E.Octo_Globals.Gray_Color
	if not self or self == 0 then return hexColor end
	for _, v in pairs(E.Octo_Table.OctoTable_RIO_COLORS) do
		if self <= v.score then
			hexColor = E.Octo_Func.func_rgb2hex(v.color[1],v.color[2],v.color[3])
		end
	end
	return hexColor
end
local RIO_Color = E.Octo_Func.RIO_Color
----------------------------------------------------------------
function E.Octo_Func.encryption(self)
	local self = utf8reverse(tostring(self))
	local text = strsplit("-", self)
	local vivod = ""
	vivod = utf8lower(text:gsub("0", ""):gsub("1", ""):gsub("2", ""):gsub("3", ""):gsub("4", ""):gsub("5", ""):gsub("6", ""):gsub("7", ""):gsub("8", ""):gsub("9", ""))
	return vivod
end
local encryption = E.Octo_Func.encryption
----------------------------------------------------------------
function E.Octo_Func.GetClassColor(self) -- C_ClassColor.GetClassColor(classFilename)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[self]
	if color then
		return color.colorStr:gsub("^ff", "")
	end
	return "ffffff"
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------


