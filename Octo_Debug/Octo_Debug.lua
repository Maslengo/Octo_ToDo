local GlobalAddonName, ns = ...
E = _G.OctoEngine

local Octo_EventFrame_Debug = CreateFrame("FRAME")
Octo_EventFrame_Debug:Hide()




----------------------------------------------------------------
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
----------------------------------------------------------------
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
	-- ["..."] = tableColor,
	-- ["{"] = tableColor,
	-- ["}"] = tableColor,
	-- ["["] = tableColor,
	-- ["]"] = tableColor,
	-- -- arithmetic operators
	-- ["+"] = arithmeticColor,
	-- ["-"] = arithmeticColor,
	-- ["/"] = arithmeticColor,
	-- ["*"] = arithmeticColor,
	-- [".."] = arithmeticColor,
	-- -- relational operators
	-- ["=="] = relationColor,
	-- ["<"] = relationColor,
	-- ["<="] = relationColor,
	-- [">"] = relationColor,
	-- [">="] = relationColor,
	-- ["~="] = relationColor,
	-- -- logical operators
	-- ["and"] = logicColor,
	-- ["or"] = logicColor,
	-- ["not"] = logicColor,
	-- misc
	[0] = "|r",
}
----------------------------------------------------------------------------------------------------------------------------------
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
local IndentationLib = IndentationLib
----------------------------------------------------------------
-- editFrame
----------------------------------------------------------------
local editFrame = CreateFrame("FRAME", "editFrame", UIParent, "MyAddonEditFrameTemplate")
editFrame:ClearAllPoints()
editFrame:SetPoint("CENTER")
-- editFrame:SetScale(1.5)
editFrame:SetScript("OnKeyDown", function(self, key)
		if not InCombatLockdown() then
			if key == GetBindingKey("TOGGLEGAMEMENU") then
				self:Hide()
				self:SetPropagateKeyboardInput(false)
			else
				self:SetPropagateKeyboardInput(true)
			end
		end
end)
local editBox = editFrame.editFrame
tinsert(E.OctoTable_Frames, editFrame)
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
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
			-- v = type(v) == "string" and '"'..v:gsub("[\"\\]", "\\%1")..'"' or tostringall(v)
			-- str = ("%s%s%s %s,\n"):format(str, indentStr, k, v)
			local vtype = type(v)
			v = vtype == "string" and '"'..v:gsub("[\"\\]", "\\%1")..'"' or vtype == "number" and v or '"'..tostringall(v)..'"'
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
local LOCAL_FPrintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E:func_Gradient(GlobalAddonName..": ")
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
	local message = strjoin(" ", E:func_Gradient(GlobalAddonName..": "), tostringall(...))
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
function E:func_mountslist(full)
	if C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
		fprint("|cffff0000NEED RELOAD|r")
	end
	full = full == "1"
	local tbl, types, currentTier, t, c, w = {}, {}, tonumber(GetBuildInfo():match("(.-)%.")), {}, 0, {}
	local i, j, str = 0, 0, ""
	local mountsIDs = C_MountJournal.GetMountIDs()
	sort(mountsIDs, E.func_Reverse_order)
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
			str = strjoin(str ~= "" and "\n" or "", str, ("[%s] = true, -- %s %s %s"):format(id, E:func_texturefromIcon(icon), spellID, name))
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
			local ids = type(m[3]) == "table" and E:func_tToStr(m[3]) or m[3]
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
end
------------------------------
function E:func_itemslist(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ItemsUsable_Other):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	promise1:FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	promise1:Then(function()
			sort(list1, E.func_Reverse_order)
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..E:func_texturefromIcon(E:func_GetItemIconByID(id1))..E:func_GetItemNameByID(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..E:func_texturefromIcon(E:func_GetItemIconByID(id2))..E:func_GetItemNameByID(id2).."\n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
function E:func_itemslistSort(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ItemsUsable_Other):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	promise1:FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	local count = 0
	promise1:Then(function()
			sort(list1, E.func_Reverse_order)
			for _, id1 in next, (list1) do
				count = count + 1
				if count < 24 then
					str = str..id1..", "
				else
					count = 0
					str = str..id1..", |n"
				end
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- UNKNOWN|n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
function E:func_itemslistSortBOOLEN(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local tbl = {}
	for k, v in next, (E.OctoTable_itemID_ItemsUsable_Other) do
		tinsert(tbl, k)
	end
	local promise1 = LibThingsLoad:Items(tbl):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	promise1:FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	local count = 0
	promise1:Then(function()
			sort(list1, E.func_Reverse_order)
			for _, id1 in next, (list1) do
				count = count + 1
				if count < 8 then
					str = str.."["..id1.."] = true, "
				else
					count = 0
					str = str.."["..id1.."] = true, |n"
				end
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- UNKNOWN|n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
------------------------------
function E:func_questslist(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise2 = LibThingsLoad:Quests(E.OctoTable_QuestID_Paragon):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	sort(list1, E.func_Reverse_order)
	promise2:FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	sort(list2, E.func_Reverse_order)
	promise2:Then(function()
			for _, id1 in next, (list1) do
				str = str..id1..", -- "..E:func_questName(id1).."\n"
			end
			for _, id2 in next, (list2) do
				str = str..id2..", -- "..E:func_questName(id2).."\n"
			end
			editBox:SetText(str)
			editFrame:Show()
	end)
end
------------------------------
function E:func_currencieslist(msg)
	-- local str1 = ""
	-- local headerName = ""
	-- for i = 1, C_CurrencyInfo.GetCurrencyListSize() do
	-- local info = C_CurrencyInfo.GetCurrencyListInfo(i)
	-- if info.isHeader then
	-- C_CurrencyInfo.ExpandCurrencyList(i, true)
	-- headerName = C_CurrencyInfo.GetCurrencyListInfo(i).name
	-- str1 = str1 .."|cff606060 ---> ".. headerName .. "|r\n"
	-- elseif info.name then
	-- local currencyLink = C_CurrencyInfo.GetCurrencyListLink(i)
	-- local CurrencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
	-- local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
	-- local quantity = currencyInfo.quantity
	-- if CurrencyID then
	-- str1 = str1 ..tostringall(CurrencyID) .. " - ".. E:func_currencyIcon(CurrencyID)..E:func_currencyName(CurrencyID) .." ("..quantity..")".. "\n"
	-- end
	-- end
	-- i = i + 1
	-- end
	local str1 = ""
	local str2 = ""
	local vivod = ""
	local list = {}
	for CurrencyID,	cachedName in next, (Octo_Cache_DB.AllCurrencies) do
		tinsert(list, CurrencyID)
	end
	sort(list, E.func_Reverse_order)
	for _, CurrencyID in ipairs(list) do

	-- for CurrencyID = 3360, 1, -1 do
		if E:func_currencyName(CurrencyID) ~= (CurrencyID.. " (UNKNOWN)") then
			str1 = str1..CurrencyID..", --" ..E:func_currencyName(CurrencyID).."|n"
		else
			str2 = str2..CurrencyID..", --" ..E:func_currencyName(CurrencyID).."|n"
		end
	end
	vivod = str1..str2
	editBox:SetText(vivod)
	editFrame:Show()
end
------------------------------
function E:func_reputationslist(msg)
	local str4 = ""
	local str5 = ""
	local vivod = ""
	local list = {}
	for _, reputationID in next, (E.OctoTable_allfaction) do
		tinsert(list, reputationID)
	end
	sort(list, E.func_Reverse_order)
	for _, reputationID in next, (list) do
		if E:func_reputationName(reputationID) ~= (reputationID.. " (UNKNOWN)") then
			str4 = str4..reputationID..", --" ..E:func_reputationName(reputationID).."|n"
		else
			str5 = str5..reputationID..", --" ..E:func_reputationName(reputationID).."|n"
		end
	end
	vivod = str4..str5
	editBox:SetText(vivod)
	editFrame:Show()
end
------------------------------
function E:func_spellslist(msg)
	local str4 = ""
	local str5 = ""
	local vivod = ""
	local list = {}
	for intexRow, tbl in next, (E.OctoTable_Portals) do
		for spellID, v in next, (tbl) do
			tinsert(list, spellID)
		end
	end
	sort(list, E.func_Reverse_order)
	for _, spellID in next, (list) do
		if E:func_GetSpellNameFull(spellID) ~= "|cffFF4C4F"..SEARCH_LOADING_TEXT.."|r" then
			str4 = str4..spellID..", --" ..E:func_GetSpellNameFull(spellID).."\n"
		else
			str5 = str5..spellID..", --" ..E:func_GetSpellNameFull(spellID).."\n"
		end
	end
	vivod = str4..str5
	editBox:SetText(vivod)
	editFrame:Show()
end
local function func_HandleCommand(msg)
	local command, arg1, arg2 = strsplit(" ", msg, 3)
	if (command == "mount" or command == "1") then
		E:func_mountslist(arg1)
	elseif (command == "item" or command == "2") then
		E:func_itemslist(arg1)
	elseif (command == "quest" or command == "3") then
		E:func_questslist(arg1)
	elseif (command == "currency" or command == "4") then
		E:func_currencieslist(arg1)
	elseif (command == "rep" or command == "5") then
		E:func_reputationslist(arg1)
	elseif (command == "spell" or command == "6") then
		E:func_spellslist(arg1)
	elseif (command == "item2" or command == "7") then
		E:func_itemslistSort(arg1)
	elseif (command == "item3" or command == "8") then
		E:func_itemslistSortBOOLEN(arg1)
	else
		DEFAULT_CHAT_FRAME:AddMessage("Команды:")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."mount".." (1)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."item".." (2)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."quest".." (3)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."currency".." (4)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."rep".." (5)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."spell".." (6)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."item2".." (7)")
		DEFAULT_CHAT_FRAME:AddMessage("/fp ".."item3".." (8)")
	end
end
SLASH_OCTOLIST1 = "/fp"
SlashCmdList["OCTOLIST"] = func_HandleCommand

local slashCommands = {
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			-- Поиск глобальных переменных по строке
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color.."GSEARCH:|r "..msg)

			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str..color..i.."|r - "..n.."\n"
				end
			end

			local editBox = _G.editFrame.editFrame
			editBox:SetText(str)
			_G.editFrame:Show()
		end
	}
}

-- Регистрируем все slash-команды
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler

	for i, cmd in ipairs(data.commands) do
		_G["SLASH_"..name..i] = cmd
	end
end



local MyEventsTable = {
	"ADDON_LOADED",
}
E:func_RegisterMyEventsToFrames(Octo_EventFrame_Debug, MyEventsTable)
function Octo_EventFrame_Debug:ADDON_LOADED(addonName)
	if addonName == GlobalAddonName then
		self:UnregisterEvent("ADDON_LOADED")
		self.ADDON_LOADED = nil
		E:func_CreateMinimapButton(GlobalAddonName, "Debug", Octo_Debug_DB)
	end
end

