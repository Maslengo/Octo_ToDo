-- /fprint {Octo_ToDo_DB_Config, Octo_ToDo_DB_Other}
local GlobalAddonName, E = ...
local LibOctopussy = LibStub("LibOctopussy-1.0")
local function func_Reverse_order(a, b)
	return b < a
end
local editor_themes = {
	["Standard"] = {
		-- ["Table"] = "|c00ff3333",
		-- ["Arithmetic"] = "|c00ff3333",
		-- ["Relational"] = "|c00ff3333",
		-- ["Logical"] = "|c004444ff",
		["Special"] = "|c00ff3333",
		["Keyword"] = "|c004444ff",
		["Comment"] = "|c0000aa00",
		["Number"] = "|c00ff9900",
		["String"] = "|c00999999",
	},
	["Monokai"] = {
		-- ["Table"] = "|c00ffffff",
		-- ["Arithmetic"] = "|c00f92672",
		-- ["Relational"] = "|c00ff3333",
		-- ["Logical"] = "|c00f92672",
		["Special"] = "|c0066d9ef",
		["Keyword"] = "|c00f92672",
		["Comment"] = "|c0075715e",
		["Number"] = "|c00ae81ff",
		["String"] = "|c00e6db74",
	},
	["Obsidian"] = {
		-- ["Table"] = "|c00AFC0E5",
		-- ["Arithmetic"] = "|c00E0E2E4",
		-- ["Relational"] = "|c00B3B689",
		-- ["Logical"] = "|c0093C763",
		["Special"] = "|c00AFC0E5",
		["Keyword"] = "|c0093C763",
		["Comment"] = "|c0066747B",
		["Number"] = "|c00FFCD22",
		["String"] = "|c00EC7600",
	},
	["Sublime"] = {
		-- ["Table"] = "|c00ffffff",
		-- ["Arithmetic"] = "|c00f92672",
		-- ["Relational"] = "|c00ff3333",
		-- ["Logical"] = "|c00f92672",
		["Special"] = "|cff66d9ef", -- Голубой?
		["Keyword"] = "|cffF9EE98", -- Желтый
		["Comment"] = "|cff605A60", -- Серый
		["Number"] = "|cffCF6137", -- Оранж
		["String"] = "|cff829D61", -- Зелен
	},
}


local colorScheme = {
	[IndentationLib.tokens.TOKEN_SPECIAL] = editor_themes["Sublime"]["Special"],
	[IndentationLib.tokens.TOKEN_KEYWORD] = editor_themes["Sublime"]["Keyword"],
	[IndentationLib.tokens.TOKEN_COMMENT_SHORT] = editor_themes["Sublime"]["Comment"],
	[IndentationLib.tokens.TOKEN_COMMENT_LONG] = editor_themes["Sublime"]["Comment"],
	[IndentationLib.tokens.TOKEN_NUMBER] = editor_themes["Sublime"]["Number"],
	[IndentationLib.tokens.TOKEN_STRING] = editor_themes["Sublime"]["String"],
	[IndentationLib.tokens.TOKEN_IDENTIFIER] = "|cff7587A6", -- text color
	-- [IndentationLib.tokens.TOKEN_UNKNOWN] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LINEBREAK] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_WHITESPACE] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_ASSIGNMENT] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_EQUALITY] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_MINUS] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LEFTBRACKET] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_PERIOD] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_DOUBLEPERIOD] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_TRIPLEPERIOD] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LTE] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LT] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_GTE] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_GT] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_NOTEQUAL] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_COMMA] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_SEMICOLON] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_COLON] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LEFTPAREN] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_RIGHTPAREN] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_PLUS] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_SLASH] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_LEFTWING] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_RIGHTWING] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_CIRCUMFLEX] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_ASTERISK] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_RIGHTBRACKET] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_VERTICAL] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_TILDE] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_COLORCODE_START] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_COLORCODE_STOP] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_HASH] = "|cff000000",
	-- [IndentationLib.tokens.TOKEN_PERCENT] = "|cff000000",
	-- ellipsis, curly braces, table access
	["..."] = tableColor,
	["{"] = tableColor,
	["}"] = tableColor,
	["["] = tableColor,
	["]"] = tableColor,
	-- arithmetic operators
	["+"] = arithmeticColor,
	["-"] = arithmeticColor,
	["/"] = arithmeticColor,
	["*"] = arithmeticColor,
	[".."] = arithmeticColor,
	-- relational operators
	["=="] = relationColor,
	["<"] = relationColor,
	["<="] = relationColor,
	[">"] = relationColor,
	[">="] = relationColor,
	["~="] = relationColor,
	-- logical operators
	["and"] = logicColor,
	["or"] = logicColor,
	["not"] = logicColor,
	-- misc
	[0] = "|r",
}
----------------------------------------------------------------------------------------------------------------------------------
-- fprint
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local IndentationLib = IndentationLib
-- EDITBOX

-- /dump Octo_ToDoEditFrame:GetPoint()

local editFrame, editBox
if select(4, GetBuildInfo()) > 20000 then
	editFrame = CreateFrame("FRAME", GlobalAddonName.."EditFrame", UIParent, "MyAddonEditFrameTemplate")
	editFrame:ClearAllPoints()
	-- editFrame:SetPoint("TOP", -300, -(UIParent:GetHeight()/6))
	-- editFrame:SetPoint("TOPLEFT", nil, "TOPLEFT", 20, -20)
	editFrame:SetPoint("TOPLEFT", 20, -20)
	-- editFrame:EnableMouse(true)
	-- editFrame:HookScript("OnMouseDown", function(self) self:Hide() end)
	-- editFrame:HookScript("OnMouseUp", function(self) self:Hide() end)
	editFrame:SetScript("OnKeyDown", function(self, key)
		if key == GetBindingKey("TOGGLEGAMEMENU") then
			self:Hide()
			self:SetPropagateKeyboardInput(false)
		else
			self:SetPropagateKeyboardInput(true)
		end
	end)
	-- editFrame:RegisterForClicks("RightButtonUp")
	-- editFrame:SetScript("OnClick", function(self) self:Hide() end)
	editBox = editFrame.editFrame
end
local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do
		indentStr = indentStr.." "
	end
	for k, v in next, (msg) do
		k = (type(k) == "number" and "["..k.."]" or type(k) == "string" and '["'..k..'"]' or tostringall(k)).." ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			-- str = ("%s%s%s { -- %s\n"):format(str, indentStr, k, tostringall(v)) -- ТАБЛИЦА
			str = ("%s%s%s {\n"):format(str, indentStr, k) -- БЕЗ ТАБЛИЦЫ
			str = str..dumpEdit(indent + 1, v, tables)
			str = ("%s%s},\n"):format(str, indentStr)
		else
			v = type(v) == "string" and '"'..v:gsub("[\"\\]", "\\%1")..'"' or tostringall(v)
			str = ("%s%s%s %s,\n"):format(str, indentStr, k, v)
		end
	end
	if indent == 0 then
		IndentationLib.enable(editBox:GetEditBox(), colorScheme, 4)
		-- editor.editBox:SetText(editor.editBox:GetText().."\n")
		editBox:SetText(str)
		IndentationLib.indentEditbox(editBox:GetEditBox())
		editFrame:Show()
	else
		return str
	end
end
-- FPRINT
local LOCAL_FPrintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = LibOctopussy:func_Gradient(GlobalAddonName..": ", E.Addon_Left_Color, E.Addon_Right_Color)
		for i = 1, indent do
			indentStr = indentStr.." "
		end
		for k, v in next, (msg) do
			k = "["..tostringall(k).."] ="
			if type(v) == "table" then
				if allChildren or indent + 1 == 1 then
					frame:AddMessage(strjoin(" ", indentStr, k, "table: {"))
					sendMessage(frame, indent + 1, v, allChildren)
					frame:AddMessage(strjoin(" ", indentStr, " }"))
				else
					frame:AddMessage(strjoin(" ", indentStr, k, "table"))
				end
			else
				frame:AddMessage(strjoin(" ", indentStr, k, tostringall(v)))
			end
		end
	end
	local message = strjoin(" ", LibOctopussy:func_Gradient(GlobalAddonName..": ", E.Addon_Left_Color, E.Addon_Right_Color), tostringall(...))
	local mFrame = DEFAULT_CHAT_FRAME
	local i = 1
	repeat
		local frame = _G["ChatFrame"..i]
		if frame and frame:IsShown() then
			mFrame = frame
			break
		end
		i = i + 1
	until not frame
	mFrame:AddMessage(message)
	local first = select(1, ...)
	if first == "dump" or first == "dump1" then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		sendMessage(mFrame, 0, msg, first ~= "dump1")
	end
	if first == dumpe then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		dumpEdit(0, msg)
	end
end
local function fprint_inner(...)
	forceinsecure()
	local ok, err = pcall(LOCAL_FPrintHandler, ...)
	if not ok then
		geterrorhandler()(err)
	end
end
dump = "dump"
dump1 = "dump1"
dumpe = "dumpe"
function fprint(...)
	securecall(pcall, fprint_inner, ...)
end
function fpd(...) fprint(dump, ...) end
function fpd1(...) fprint(dump1, ...) end
function fpde(...) fprint(dumpe, ...) end
SLASH_FPRINT1 = "/fprint"
SlashCmdList["FPRINT"] = function(msg)
	local f, err = loadstring("return "..msg)
	if err then
		fprint(err:gsub("\"return ", "\""))
		return
	end
	local status, value = pcall(f)
	if status then
		fprint(dumpe, value)
	else
		fprint(value:gsub("\"return ", "\""))
	end
end
local function tToStr(t)
	local str = ""
	for _, v in ipairs(t) do
		str = str..v..","
	end
	return "{"..str:sub(1, -2).."}"
end
SLASH_MOUNTSLIST1 = "/mountslist"
SlashCmdList.MOUNTSLIST = function(full)
	if LibOctopussy:IsAddOnLoaded("Blizzard_Collections") then
		fprint("|cffff0000NEED RELOAD|r")
		-- return
	end
	fprint("begin /mountslist")
	full = full == "1"
	local tbl, types, currentTier, t, c, w = {}, {}, tonumber(GetBuildInfo():match("(.-)%.")), {}, 0, {}
	-- for k, v in next, (MountsJournal.mountsDB) do
	-- c = c + 1
	-- tbl[k] = v
	-- end
	-- for k in next, (MountsJournalFrame.mountTypes) do
	-- types[k] = 0
	-- end
	local i, j, str = 0, 0, ""
	local mountsIDs = C_MountJournal.GetMountIDs()
	sort(mountsIDs, func_Reverse_order)
	for _, id in ipairs(mountsIDs) do
		local mountType = select(5, C_MountJournal.GetMountInfoExtraByID(id))
		if types[mountType] == nil then
			local name = C_MountJournal.GetMountInfoByID(id)
			fprint(("Unregistred mount type:%s, ID:%s, name: %s"):format(mountType, id, name))
		else
			types[mountType] = types[mountType] + 1
		end
		local name, spellID, icon, _,_,_,_, isFactionSpecific, faction = C_MountJournal.GetMountInfoByID(id)
		if isFactionSpecific then name = name.." ("..(faction == 0 and FACTION_HORDE or FACTION_ALLIANCE).. ")" end
		if full then
			local v = tbl[id]
			if not v then
				j = j + 1
				v = {currentTier, 0, 0}
			end
			tinsert(t, {id, v[1], v[2], v[3], spellID, name})
		elseif not tbl[id] then
			j = j + 1
			str = strjoin(str ~= "" and "\n" or "", str, ("[%s] = true, -- %s %s %s"):format(id, LibOctopussy:func_texturefromIcon(icon), spellID, name))
		end
		i = i + 1
		w[id] = true
	end
	for k, v in next, (types) do
		if v == 0 then
			fprint(("No mounts with type: %d"):format(k))
		end
	end
	if full then
		sort(t, function(a,b) return a[2]<b[2] or a[2]==b[2] and a[1]<b[1] end)
		for _, m in ipairs(t) do
			local ids = type(m[3]) == "table" and tToStr(m[3]) or m[3]
			str = strjoin(str ~= "" and "\n" or "", str, ("[%s] = {%s, %s, %s}, -- %s %s"):format(m[1], m[2], ids, m[4], m[5], m[6]))
		end
	end
	for id in next, (tbl) do
		if not w[id] then
			fprint("wtf", id)
		end
	end
	if j > 0 or full then
		editBox:SetText(str)
		editFrame:Show()
	end
	fprint(("Mounts: %s. In base %s. Not in base: %s."):format(i, c, j))
	fprint("end /mountslist")
end
------------------------------
-- отделил
SLASH_OCTOLISTITEMS1 = "/OCTOLISTITEMS"
SlashCmdList.OCTOLISTITEMS = function(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ALL):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ALL):FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	promise1:Then(function()
			sort(list1, func_Reverse_order)
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..LibOctopussy:func_itemTexture(id1)..LibOctopussy:func_itemName(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..LibOctopussy:func_itemTexture(id2)..LibOctopussy:func_itemName(id2).."\n"
			end
			fprint("begin /OCTOLISTITEMS")
			editBox:SetText(str)
			editFrame:Show()
			fprint("end /OCTOLISTITEMS")
	end)
end
------------------------------
SLASH_OCTOLISTQUESTS1 = "/OCTOLISTQUESTS"
SlashCmdList.OCTOLISTQUESTS = function(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise2 = LibThingsLoad:Quests(E.OctoTable_QuestIDTEST):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	sort(list1, func_Reverse_order)
	local promise2 = LibThingsLoad:Quests(E.OctoTable_QuestIDTEST):FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	sort(list2, func_Reverse_order)
	promise2:Then(function()
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..LibOctopussy:func_questName(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..LibOctopussy:func_questName(id2).."\n"
			end
			fprint("begin /OCTOLISTQUESTS")
			editBox:SetText(str)
			editFrame:Show()
			fprint("end /OCTOLISTQUESTS")
	end)
end
------------------------------
SLASH_OCTOLISTCURRENCIES1 = "/OCTOLISTCURRENCIES"
SlashCmdList.OCTOLISTCURRENCIES = function(msg)
	local str3 = ""
	local headerName = ""
	local Collapsed = {}
	local listSize, i = C_CurrencyInfo.GetCurrencyListSize(), 1
	local headerIndex
	while listSize >= i do
		local info = C_CurrencyInfo.GetCurrencyListInfo(i)
		if info.isHeader then
			C_CurrencyInfo.ExpandCurrencyList(i, true)
			Collapsed[info.name] = true
			listSize = C_CurrencyInfo.GetCurrencyListSize()
			headerIndex = i
			headerName = C_CurrencyInfo.GetCurrencyListInfo(i)
			str3 = str3 .."|cff606060 ---> ".. headerName.name .. "|r\n"
		elseif info.name then
			local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
			local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
			local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
			local quantity = currencyInfo.quantity
			if currencyID then
				str3 = str3 ..tostringall(currencyID) .. " - ".. LibOctopussy:func_currencyicon(currencyID)..LibOctopussy:func_currencyName(currencyID) .." ("..quantity..")".. "\n"
			end
		end
		i = i + 1
	end
	fprint("begin /OCTOLISTCURRENCIES")
	editBox:SetText(str3)
	editFrame:Show()
	fprint("end /OCTOLISTCURRENCIES")
end
------------------------------
SLASH_OCTOLISTREP1 = "/OCTOLISTREP"
SlashCmdList.OCTOLISTREP = function(msg)
	local str4 = ""
	local str5 = ""
	local vivod = ""
	local list = {}
	for _, factionID in next, (E.OctoTable_reputation_ALL) do
		tinsert(list, factionID)
	end
	sort(list, func_Reverse_order)
	for _, factionID in next, (list) do
		if LibOctopussy.func_reputationName(factionID) ~= "|cffFF4C4F"..SEARCH_LOADING_TEXT.."|r" then
			str4 = str4..factionID..", --" ..LibOctopussy:func_reputationName(factionID).. LibOctopussy:func_CheckReputationByRepID(factionID).."\n"
		else
			str5 = str5..factionID..", --" ..LibOctopussy:func_reputationName(factionID).. LibOctopussy:func_CheckReputationByRepID(factionID).."\n"
		end
	end
	vivod = str4..str5
	editBox:SetText(vivod)
	editFrame:Show()
end
------------------------------
SLASH_OCTOLISTMOUNT1 = "/OCTOLISTMOUNT"
SlashCmdList.OCTOLISTMOUNT = function(msg)
	local str5, list5, i = "", {}, 1
	local mountsIDs = C_MountJournal.GetMountIDs()
	-- sort(mountsIDs, func_Reverse_order)
	sort(mountsIDs, func_Reverse_order)
	for _, id in next, (mountsIDs) do
		local name, spellID, icon,_,_,_,_, isFactionSpecific, faction = C_MountJournal.GetMountInfoByID(id)
		if isFactionSpecific then name = name.." ("..(faction == 0 and FACTION_HORDE or FACTION_ALLIANCE).. ")" end
		str5 = str5 .."[".. id .."] = true, -- "..spellID.." "..LibOctopussy:func_texturefromIcon(icon)..name.."\n"
		i = i + 1
	end
	editBox:SetText(str5)
	editFrame:Show()
end