local GlobalAddonName, E = ...
local LibThingsLoad = LibStub("LibThingsLoad-1.0")

-- EDITBOX
local editFrame, editBox
if select(4, GetBuildInfo()) > 20000 then
	editFrame = CreateFrame("FRAME", GlobalAddonName.."EditFrame", UIParent, "MyAddonEditFrameTemplate")
	editFrame:ClearAllPoints()
	editFrame:SetPoint("TOPLEFT", (UIParent:GetWidth() - editFrame:GetWidth()) / 2, -100)
	editBox = editFrame.editFrame
end


local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do
		indentStr = indentStr.."   "
	end

	for k, v in pairs(msg) do
		k = "|c99bbbbff"..(type(k) == "number" and "["..k.."]" or type(k) == "string" and '["'..k..'"]' or tostringall(k)).."|r ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			str = str..strjoin(" ", indentStr, k, "{").."\n"
			str = str..dumpEdit(indent + 1, v, tables)
			str = str..strjoin(" ", indentStr, "},").."\n"
		else
			v = type(v) == "string" and '"'..v..'"' or tostringall(v)
			str = str..strjoin(" ", indentStr, k, v)..",\n"
		end
	end
	if indent == 0 then
		editBox:SetText(str)
		editFrame:Show()
	else
		return str
	end
end


-- FPRINT
local LOCAL_FPrintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E.Octo_Func.func_Gradient("MyTools:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
		for i = 1, indent do
			indentStr = indentStr.."   "
		end

		for k, v in pairs(msg) do
			k = "|c99bbbbff["..tostringall(k).."]|r ="
			if type(v) == "table" then
				if allChildren or indent + 1 == 1 then
					frame:AddMessage(strjoin(" ", indentStr, k, "table: {"))
					sendMessage(frame, indent + 1, v, allChildren)
					frame:AddMessage(strjoin(" ", indentStr, "   }"))
				else
					frame:AddMessage(strjoin(" ", indentStr, k, "table"))
				end
			else
				frame:AddMessage(strjoin(" ", indentStr, k, tostringall(v)))
			end
		end
	end

	local message = strjoin(" ", E.Octo_Func.func_Gradient("MyTools:", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), tostringall(...))
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
			local  n = select(i, ...)
			tinsert(msg, n)
		end
		sendMessage(mFrame, 0, msg, first ~= "dump1")
	end

	if first == dumpe then
		local msg = {}
		for i = 2, select("#", ...) do
			local  n = select(i, ...)
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
	if C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
		fprint("|cffff0000NEED RELOAD|r")
		-- return
	end

	fprint("begin /mountslist")
	full = full == "1"
	local tbl, types, currentTier, t, c, w = {}, {}, tonumber(GetBuildInfo():match("(.-)%.")), {}, 0, {}
	for k, v in pairs(MountsJournal.mountsDB) do
		c = c + 1
		tbl[k] = v
	end
	for k in pairs(MountsJournalFrame.mountTypes) do
		types[k] = 0
	end

	local i, j, str = 0, 0, ""
	local mountsIDs = C_MountJournal.GetMountIDs()
	sort(mountsIDs)
	for _, id in ipairs(mountsIDs) do
		local mountType = select(5, C_MountJournal.GetMountInfoExtraByID(id))
		if types[mountType] == nil then
			local name = C_MountJournal.GetMountInfoByID(id)
			fprint(("Unregistred mount type:%s, ID:%s, name: %s"):format(mountType, id, name))
		else
			types[mountType] = types[mountType] + 1
		end

		local name, spellID, _,_,_,_,_, isFactionSpecific, faction = C_MountJournal.GetMountInfoByID(id)
		if isFactionSpecific then name = name.." ("..(faction == 0 and FACTION_HORDE or FACTION_ALLIANCE).. ")"  end

		if full then
			local v = tbl[id]
			if not v then
				j = j + 1
				v = {currentTier, 0, 0}
			end
			tinsert(t, {id, v[1], v[2], v[3], spellID, name})
		elseif not tbl[id] then
			j = j + 1
			str = strjoin(str ~= "" and "\n" or "", str, ("[%s] = true, -- %s %s"):format(id, spellID, name))
		end
		i = i + 1
		w[id] = true
	end

	for k, v in pairs(types) do
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

	for id in pairs(tbl) do
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


-- отделил
SLASH_OCTOLISTIT1 = "/octolistIT"
SlashCmdList.OCTOLISTIT = function(msg1)
	local str1 = ""
	local list1 = {}
	local promise1 = LibThingsLoad:Items(E.Octo_Table.OctoTable_itemID_ItemsUsable_Toys):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	promise1:Then(function()
			sort(list1)
			for _, id1 in ipairs(list1) do
				str1 = str1..id1..", -- "..E.Octo_Func.func_itemName(id1).."\n"
			end
			fprint("begin /octolistIT")
			editBox:SetText(str1)
			editFrame:Show()
			fprint("end /octolistIT")
	end)
end

SLASH_OCTOLISTQW1 = "/octolistQW"
SlashCmdList.OCTOLISTQW = function(msg2)
	local str2 = ""
	local list2 = {}
	local promise2 = LibThingsLoad:Quests(E.Octo_Table.OctoTable_QuestID):ThenForAllWithCached(function(_, ids2)
			tinsert(list2, ids2)
	end)
	promise2:Then(function()
			sort(list2)
			for _, id2 in ipairs(list2) do
				str2 = str2..id2..", -- "..E.Octo_Func.func_questName(id2).."\n"
			end
			-- fpde(str2)
			fprint("begin /octolistQW")
			editBox:SetText(str2)
			editFrame:Show()
			fprint("end /octolistQW")
	end)
end