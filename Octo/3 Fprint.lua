local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")


local function func_Reverse_order(a, b) return b < a end

local editor_themes = {
	["Standard"] = {
		["Special"] = "|c00ff3333",
		["Keyword"] = "|c004444ff",
		["Comment"] = "|c0000aa00",
		["Number"] = "|c00ff9900",
		["String"] = "|c00999999",
	},
	["Monokai"] = {
		["Special"] = "|c0066d9ef",
		["Keyword"] = "|c00f92672",
		["Comment"] = "|c0075715e",
		["Number"] = "|c00ae81ff",
		["String"] = "|c00e6db74",
	},
	["Obsidian"] = {
		["Special"] = "|c00AFC0E5",
		["Keyword"] = "|c0093C763",
		["Comment"] = "|c0066747B",
		["Number"] = "|c00FFCD22",
		["String"] = "|c00EC7600",
	},
	["Sublime"] = {
		["Special"] = "|cff66d9ef",
		["Keyword"] = "|cffF9EE98",
		["Comment"] = "|cff605A60",
		["Number"] = "|cffCF6137",
		["String"] = "|cff829D61",
	},
}

local colorScheme = {
	[IndentationLib.tokens.TOKEN_SPECIAL] = editor_themes["Sublime"]["Special"],
	[IndentationLib.tokens.TOKEN_KEYWORD] = editor_themes["Sublime"]["Keyword"],
	[IndentationLib.tokens.TOKEN_COMMENT_SHORT] = editor_themes["Sublime"]["Comment"],
	[IndentationLib.tokens.TOKEN_COMMENT_LONG] = editor_themes["Sublime"]["Comment"],
	[IndentationLib.tokens.TOKEN_NUMBER] = editor_themes["Sublime"]["Number"],
	[IndentationLib.tokens.TOKEN_STRING] = editor_themes["Sublime"]["String"],
	[IndentationLib.tokens.TOKEN_IDENTIFIER] = "|cff7587A6",
	[0] = "|r",
}

local editFrame = CreateFrame("FRAME", "editFrame", UIParent, "MyAddonEditFrameTemplate")
editFrame:ClearAllPoints()
editFrame:SetPoint("CENTER")
editFrame:SetScript("OnKeyDown", function(self, key)
	if key == GetBindingKey("TOGGLEGAMEMENU") then
		self:Hide()
		self:SetPropagateKeyboardInput(false)
	else
		self:SetPropagateKeyboardInput(true)
	end
end)
local editBox = editFrame.editFrame
tinsert(E.OctoTable_Frames, editFrame)

local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do indentStr = indentStr.." " end

	for k, v in next, msg do
		k = (type(k) == "number" and "["..k.."]" or type(k) == "string" and '["'..k..'"]' or tostringall(k)).." ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			str = str..indentStr..k.." {\n"..dumpEdit(indent + 1, v, tables)..indentStr.."},\n"
		else
			local vtype = type(v)
			v = vtype == "string" and '"'..v:gsub("[\"\\]", "\\%1")..'"' or vtype == "number" and v or '"'..tostringall(v)..'"'
			str = str..indentStr..k.." "..v..",\n"
		end
	end

	if indent == 0 then
		IndentationLib.enable(editBox:GetEditBox(), colorScheme, 4)
		editBox:SetText(str)
		IndentationLib.indentEditbox(editBox:GetEditBox())
		editFrame:Show()
	else
		return str
	end
end

local LOCAL_FPrintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E.func_Gradient(GlobalAddonName..": ")
		for i = 1, indent do indentStr = indentStr.." " end

		for k, v in next, msg do
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

	local message = strjoin(" ", E.func_Gradient(GlobalAddonName..": "), tostringall(...))
	local mFrame = DEFAULT_CHAT_FRAME
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		if frame and frame:IsShown() then
			mFrame = frame
			break
		end
	end

	mFrame:AddMessage(message)
	local first = select(1, ...)
	if first == "dump" or first == "dump1" then
		local msg = {}
		for i = 2, select("#", ...) do tinsert(msg, select(i, ...)) end
		sendMessage(mFrame, 0, msg, first ~= "dump1")
	elseif first == dumpe then
		local msg = {}
		for i = 2, select("#", ...) do tinsert(msg, select(i, ...)) end
		dumpEdit(0, msg)
	end
end

local function fprint_inner(...)
	forceinsecure()
	local ok, err = pcall(LOCAL_FPrintHandler, ...)
	if not ok then geterrorhandler()(err) end
end

dump, dump1, dumpe = "dump", "dump1", "dumpe"
function fprint(...) securecall(pcall, fprint_inner, ...) end
function fpd(...) fprint(dump, ...) end
function fpd1(...) fprint(dump1, ...) end
function fpde(...) fprint(dumpe, ...) end

SLASH_FPRINT1 = "/fprint"
SlashCmdList["FPRINT"] = function(msg)
	local f, err = loadstring("return "..msg)
	if err then return fprint(err:gsub("\"return ", "\"")) end

	local status, value = pcall(f)
	if status then fprint(dumpe, value)
	else fprint(value:gsub("\"return ", "\"")) end
end

local function tToStr(t)
	local str = ""
	for _, v in ipairs(t) do str = str..v.."," end
	return "{"..str:sub(1, -2).."}"
end

local function processList(list, processor, showUnknown)
	local strKnown, strUnknown = "", ""
	for _, id in ipairs(list) do
		local result = processor(id)
		if showUnknown and result:find("UNKNOWN") then
			strUnknown = strUnknown..id..", --"..result.."|n"
		else
			strKnown = strKnown..id..", --"..result..(showUnknown and "|n" or "\n")
		end
	end
	editBox:SetText(strKnown..strUnknown)
	editFrame:Show()
end

function E.func_itemslist(msg)
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ItemsUsable_Other)
	promise1:ThenForAllWithCached(function(_, ids) processList(ids, function(id) return E.func_GetItemIconByID(id)..E.func_GetItemNameByID(id) end) end)
	promise1:FailWithChecked(function(_, ids) processList(ids, function(id) return E.func_GetItemIconByID(id)..E.func_GetItemNameByID(id) end) end)
end

function E.func_itemslistSort(msg)
	local promise1 = LibThingsLoad:Items(E.OctoTable_itemID_ItemsUsable_Other)
	promise1:ThenForAllWithCached(function(_, ids)
		local str = ""
		for i, id in ipairs(ids) do
			str = str..id..((i % 24 == 0) and ", |n" or ", ")
		end
		editBox:SetText(str)
		editFrame:Show()
	end)
	promise1:FailWithChecked(function(_, ids)
		for _, id in ipairs(ids) do
			editBox:SetText((editBox:GetText() or "")..id..", -- UNKNOWN|n")
		end
	end)
end

function E.func_itemslistSortBOOLEN(msg)
	local tbl = {}
	for k in next, E.OctoTable_itemID_ItemsDelete do tinsert(tbl, k) end

	local promise1 = LibThingsLoad:Items(tbl)
	promise1:ThenForAllWithCached(function(_, ids)
		local str = ""
		for i, id in ipairs(ids) do
			str = str.."["..id.."] = true"..((i % 8 == 0) and ", |n" or ", ")
		end
		editBox:SetText(str)
		editFrame:Show()
	end)
	promise1:FailWithChecked(function(_, ids)
		for _, id in ipairs(ids) do
			editBox:SetText((editBox:GetText() or "")..id..", -- UNKNOWN|n")
		end
	end)
end

function E.func_questslist(msg)
	local promise2 = LibThingsLoad:Quests(E.OctoTable_QuestID_Paragon)
	promise2:ThenForAllWithCached(function(_, ids) processList(ids, E.func_questName) end)
	promise2:FailWithChecked(function(_, ids) processList(ids, E.func_questName) end)
end

function E.func_currencieslist(msg)
	processList(E.TESTCURR, function(id) return E.func_currencyName(id) end, true)
end

function E.func_reputationslist(msg)
	processList(E.OctoTable_allfaction, function(id) return E.func_reputationName(id) end, true)
end

function E.func_spellslist(msg)
	local list = {}
	for _, tbl in next, E.OctoTable_Portals do
		for spellID in next, tbl do tinsert(list, spellID) end
	end
	processList(list, E.func_GetSpellName)
end

local function func_HandleCommand(msg)
	local command, arg = strsplit(" ", msg, 2)
	local commands = {
		item = E.func_itemslist,
		quest = E.func_questslist,
		currency = E.func_currencieslist,
		rep = E.func_reputationslist,
		spell = E.func_spellslist,
		item2 = E.func_itemslistSort,
		item3 = E.func_itemslistSortBOOLEN,
		["2"] = E.func_itemslist,
		["3"] = E.func_questslist,
		["4"] = E.func_currencieslist,
		["5"] = E.func_reputationslist,
		["6"] = E.func_spellslist,
		["7"] = E.func_itemslistSort,
		["8"] = E.func_itemslistSortBOOLEN,
	}

	if commands[command] then
		commands[command](arg)
	else
		print("Команды:")
		for i = 1, 8 do
			local name = i == 2 and "item" or i == 3 and "quest" or
						 i == 4 and "currency" or i == 5 and "rep" or i == 6 and "spell" or
						 i == 7 and "item2" or "item3"
			print("/fp "..name.." ("..i..")")
		end
	end
end

SLASH_OCTOLIST1 = "/fp"
SlashCmdList["OCTOLIST"] = func_HandleCommand