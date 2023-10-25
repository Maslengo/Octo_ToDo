local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Func = {}
----------------------------------------------------------------
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
local L = LibStub("AceLocale-3.0"):GetLocale("OctoTODO")
_G["OctoTODO"] = OctoTODO
local LibStub, ldb, ldbi = LibStub, LibStub("LibDataBroker-1.1"), LibStub("LibDBIcon-1.0")
----------------------------------------------------------------
function E.Octo_Func.utf8charbytes(s, i)
	i = i or 1
	local c = strbyte(s, i)
	if c > 0 and c <= 127 then
		return 1
	elseif c >= 194 and c <= 223 then
		local c2 = strbyte(s, i + 1)
		return 2
	elseif c >= 224 and c <= 239 then
		local c2 = strbyte(s, i + 1)
		local c3 = strbyte(s, i + 2)
		return 3
	elseif c >= 240 and c <= 244 then
		local c2 = strbyte(s, i + 1)
		local c3 = strbyte(s, i + 2)
		local c4 = strbyte(s, i + 3)
		return 4
	else
	end
end
local utf8charbytes = E.Octo_Func.utf8charbytes
----------------------------------------------------------------
function E.Octo_Func.utf8len(s)
	local pos = 1
	local bytes = strlen(s)
	local len = 0
	while pos <= bytes do
		len = len + 1
		pos = pos + utf8charbytes(s, pos)
	end
	return len
end
local utf8len = E.Octo_Func.utf8len
----------------------------------------------------------------
function E.Octo_Func.utf8sub(s, i, j)
	j = j or -1
	local pos = 1
	local bytes = strlen(s)
	local len = 0
	local l = (i >= 0 and j >= 0) or utf8len(s)
	local startChar = (i >= 0) and i or l + i + 1
	local endChar = (j >= 0) and j or l + j + 1
	if startChar > endChar then
		return ""
	end
	local startByte, endByte = 1, bytes
	while pos <= bytes do
		len = len + 1
		if len == startChar then
			startByte = pos
		end
		pos = pos + utf8charbytes(s, pos)
		if len == endChar then
			endByte = pos - 1
			break
		end
	end
	return strsub(s, startByte, endByte)
end
local utf8sub = E.Octo_Func.utf8sub
----------------------------------------------------------------
function E.Octo_Func.utf8replace(s, mapping)
	local pos = 1
	local bytes = strlen(s)
	local charbytes
	local newstr = ""
	while pos <= bytes do
		charbytes = utf8charbytes(s, pos)
		local c = strsub(s, pos, pos + charbytes - 1)
		newstr = newstr..(mapping[c] or c)
		pos = pos + charbytes
	end
	return newstr
end
local utf8replace = E.Octo_Func.utf8replace
----------------------------------------------------------------
function E.Octo_Func.utf8upper(s)
	return utf8replace(s, E.Octo_Table.utf8_lc_uc)
end
local utf8upper = E.Octo_Func.utf8upper
----------------------------------------------------------------
function E.Octo_Func.utf8lower(s)
	return utf8replace(s, E.Octo_Table.utf8_uc_lc)
end
local utf8lower = E.Octo_Func.utf8lower
----------------------------------------------------------------
function E.Octo_Func.utf8reverse(s)
	local bytes = strlen(s)
	local pos = bytes
	local charbytes
	local newstr = ""
	while pos > 0 do
		c = strbyte(s, pos)
		while c >= 128 and c <= 191 do
			pos = pos - 1
			c = strbyte(pos)
		end
		charbytes = utf8charbytes(s, pos)
		newstr = newstr..strsub(s, pos, pos + charbytes - 1)
		pos = pos - 1
	end
	return newstr
end
local utf8reverse = E.Octo_Func.utf8reverse
----------------------------------------------------------------
function E.Octo_Func.WA_Utf8Sub(input, size)
	local output = ""
	if type(input) ~= "string" then
		return output
	end
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then
			return output
		end
		if byte < 128 then
			output = output..input:sub(i, i)
			size = size - 1
		elseif byte < 192 then
			output = output..input:sub(i, i)
		elseif byte < 244 then
			output = output..input:sub(i, i)
			size = size - 1
		end
		i = i + 1
	end
	while (true) do
		local byte = input:byte(i)
		if byte and byte >= 128 and byte < 192 then
			output = output..input:sub(i, i)
		else
			break
		end
		i = i + 1
	end
	return output
end
local WA_Utf8Sub = E.Octo_Func.WA_Utf8Sub
----------------------------------------------------------------
function E.Octo_Func.func_hex2rgb(self)
	self = self:gsub("|cff", "")
	return tonumber("0x"..self:sub(1, 2)), tonumber("0x"..self:sub(3, 4)), tonumber("0x"..self:sub(5, 6))
end
local func_hex2rgb = E.Octo_Func.func_hex2rgb
----------------------------------------------------------------
function E.Octo_Func.func_rgb2hex(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	-- print ("c"..string.format("%02x", math.floor(a*255))..E.Octo_Func.utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255))))
	return "|c"..string.format("%02x", math.floor(a*255))..E.Octo_Func.utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
end
local func_rgb2hex = E.Octo_Func.func_rgb2hex
----------------------------------------------------------------
function E.Octo_Func.func_rgb2hexDEV(r, g, b, a)
	local r, g, b, a = r, g, b, a
	if not a then
		a = 1
	end
	-- print ("c"..string.format("%02x", math.floor(a*255))..E.Octo_Func.utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255))))
	return "c"..string.format("%02x", math.floor(a*255))..E.Octo_Func.utf8upper(string.format("%02x%02x%02x", math.floor(r*255), math.floor(g*255), math.floor(b*255)))
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
function E.Octo_Func.WA_GetClassColor(classFilename)
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[classFilename]
	if color then
		return color.colorStr
	end
	return "ffffffff"
end
local WA_GetClassColor = E.Octo_Func.WA_GetClassColor
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
		-- PlaySoundFile("Interface\\Addons\\"..GlobalAddonName.."\\Media\\sound\\Naruto\\"..self..".ogg", "Master")
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
	if not size then
		size = 14
	end
	if not self or self == 0 then
		self = 134400
	end
	return "|T"..self..":"..size..":"..size..":::64:64:4:60:4:60|t"
end
local func_texturefromIcon = E.Octo_Func.func_texturefromIcon
----------------------------------------------------------------
function E.Octo_Func.func_questName(self)
	local title = C_QuestLog.GetTitleForQuestID(self)
	if title then
		return title
	else
		return E.Octo_Globals.Red_Color.."notitle".."|r"
	end
end
local func_questName = E.Octo_Func.func_questName
----------------------------------------------------------------
function E.Octo_Func.func_reputationName(self)
	local name = GetFactionInfoByID(self)
	if not name then
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
function E.Octo_Func.func_itemName(itemID)
	local itemName, _, itemQuality = GetItemInfo(itemID)
	if itemQuality then
		local r, g, b = GetItemQualityColor(itemQuality)
		local color = CreateColor(r, g, b, 1)
		local itemNameColored = color:WrapTextInColorCode(itemName)
		return itemNameColored or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	end
	return itemName or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	-- local itemName = E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
	-- if C_Item.DoesItemExistByID(itemID) then
	-- local item = Item:CreateFromItemID(itemID)
	-- if item:IsItemDataCached() then
	-- itemName = item:GetItemName()
	-- else
	-- item:ContinueOnItemLoad(function()
	-- itemName = item:ч()
	-- end)
	-- end
	-- return itemName
	-- end
end
local func_itemName = E.Octo_Func.func_itemName
----------------------------------------------------------------
function E.Octo_Func.func_itemName_NOCOLOR(self)
	local itemName = GetItemInfo(self)
	return itemName or E.Octo_Globals.Red_Color..RETRIEVING_ITEM_INFO.."|r"
end
local func_itemName_NOCOLOR = E.Octo_Func.func_itemName_NOCOLOR
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
function E.Octo_Func.func_currencyicon(self)
	local info = C_CurrencyInfo.GetCurrencyInfo(self)
	if info then
		iconFileID = info.iconFileID
	else
		iconFileID = 134400
	end
	return "|T"..iconFileID..":16:16:::64:64:4:60:4:60|t"
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
	local years, days, hours, mins, secs = "", "", "", "", ""
	local self = tonumber(self)
	if self <= 0 or self == nil then
		return "0:00"
	elseif self >= (86400*365) then
		years = floor(self / (86400*365))
		days = floor(mod(self, 31536000) / 86400)	-- 365 дней в году
		hours = floor(mod(self, 86400) / 3600) -- * 24 часа в дне
		mins = floor(mod(self, 3600) / 60)	-- * 60 минут в часу
		return years..L["y. "]..days..L["d. "]..hours..L["h. "]..mins..L["m. "]
	elseif self >= 86400 then
		days = floor(self / 86400)
		hours = floor(mod(self, 86400) / 3600)
		mins = floor(mod(self, 3600) / 60)
		return days..L["d. "]..hours..L["h. "]..mins..L["m. "]
	elseif self >= 3600 then
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return hours..L["h. "]..mins..L["m. "]
	elseif self >= 600 then
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%02.f", math.floor(self/60 - (hours*60)))
		return mins..L["m. "]
	else
		hours = string.format("%01.f", math.floor(self/3600))
		mins = string.format("%01.f", math.floor(self/60 - (hours*60)))
		return mins..L["m. "]
	end
end
local SecondsToClock = E.Octo_Func.SecondsToClock
----------------------------------------------------------------
function E.Octo_Func.Empty_Zero(self)
	if self == 0 then
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
local All_objectives = E.Octo_Func.All_objectives
----------------------------------------------------------------
-- function E.Octo_Func.HandleDefaultBindings(binding_name, default_key)
-- 	local bind1, bind2 = GetBindingKey(binding_name)
-- 	local action = GetBindingAction(default_key)
-- 	if bind1 == nil and bind2 == nil and action == "" then
-- 		SetBinding(default_key, binding_name)
-- 	end
-- end
-- local HandleDefaultBindings = E.Octo_Func.HandleDefaultBindings
----------------------------------------------------------------
function E.Octo_Func.func_Octo_LoadAddOn(GlobalAddonName)
	if select(5, GetAddOnInfo(GlobalAddonName)) == "DISABLED" then
		EnableAddOn(GlobalAddonName)
		LoadAddOn(GlobalAddonName)
	end
end
local func_Octo_LoadAddOn = E.Octo_Func.func_Octo_LoadAddOn
----------------------------------------------------------------
function E.Octo_Func.CheckCompletedByQuestID(self)
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
				-- if self == 77414 then
				-- print (objectiveType, objectiveText, finished)
				-- end
				if objectiveType == "progressbar" then
					TEST = E.Octo_Globals.Red_Color..GetQuestProgressBarPercent(self).."%|r"
				else
					if finished then
						TEST = E.Octo_Globals.Yellow_Color..(objectives[i].numFulfilled).."/"..(objectives[i].numRequired).."|r"
						-- TEST = E.Octo_Globals.Yellow_Color..(objectives[i].numFulfilled).."|r"
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
		self = E.Octo_Func.WA_Utf8Sub(a, 1)..E.Octo_Func.WA_Utf8Sub(b, 1):upper() else self = E.Octo_Func.WA_Utf8Sub(a, 3):lower()
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
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

