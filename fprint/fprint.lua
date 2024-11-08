local GlobalAddonName, E = ...
----------------------------------------------------------------------------------------------------------------------------------
-- fprint
local LibThingsLoad = LibStub("LibThingsLoad-1.0")
-- EDITBOX
local editFrame, editBox
if select(4, GetBuildInfo()) > 20000 then
	editFrame = CreateFrame("FRAME", GlobalAddonName.."EditFrame", UIParent, "MyAddonEditFrameTemplate")
	editFrame:ClearAllPoints()
	editFrame:SetPoint("TOPLEFT", (UIParent:GetWidth() - editFrame:GetWidth()) / 2, -100)
	-- editFrame:EnableMouse(true)
	-- editFrame:HookScript("OnMouseDown", function(self) self:Hide() end)
	-- editFrame:HookScript("OnMouseUp", function(self) self:Hide() end)
	-- editFrame:SetScript("OnKeyDown", function(self, key)
	--         if key == GetBindingKey("TOGGLEGAMEMENU") then
	--             self:GetParent():Hide()
	--             self:SetPropagateKeyboardInput(false)
	--         else
	--             self:SetPropagateKeyboardInput(true)
	--         end
	-- end)
	-- editFrame:RegisterForClicks("RightButtonUp")
	-- editFrame:SetScript("OnClick", function(self) self:Hide() end)
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
		local indentStr = E.Octo_Func.func_Gradient(GlobalAddonName..": ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color)
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
	local message = strjoin(" ", E.Octo_Func.func_Gradient(GlobalAddonName..": ", E.Octo_Globals.Addon_Left_Color, E.Octo_Globals.Addon_Right_Color), tostringall(...))
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
	-- for k, v in pairs(MountsJournal.mountsDB) do
	--     c = c + 1
	--     tbl[k] = v
	-- end
	-- for k in pairs(MountsJournalFrame.mountTypes) do
	--     types[k] = 0
	-- end
	local i, j, str = 0, 0, ""
	local mountsIDs = C_MountJournal.GetMountIDs()
	sort(mountsIDs, E.Octo_Func.reverse_order)
	for _, id in ipairs(mountsIDs) do
		local mountType = select(5, C_MountJournal.GetMountInfoExtraByID(id))
		if types[mountType] == nil then
			local name = C_MountJournal.GetMountInfoByID(id)
			fprint(("Unregistred mount type:%s, ID:%s, name: %s"):format(mountType, id, name))
		else
			types[mountType] = types[mountType] + 1
		end
		local name, spellID, icon, _,_,_,_, isFactionSpecific, faction = C_MountJournal.GetMountInfoByID(id)
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
			str = strjoin(str ~= "" and "\n" or "", str, ("[%s] = true, -- %s %s %s"):format(id, E.Octo_Func.func_texturefromIcon(icon), spellID, name))
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
------------------------------
-- отделил
SLASH_OCTOLISTIT1 = "/OCTOLISTIT"
SlashCmdList.OCTOLISTIT = function(msg)
	local str1 = ""
	local list1 = {}
	local promise1 = LibThingsLoad:Items(E.Octo_Table.OctoTable_itemID_ALL):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	local promise1 = LibThingsLoad:Items(E.Octo_Table.OctoTable_itemID_ALL):FailWithChecked(function(_, ids1)
			tinsert(list1, ids1)
	end)
	promise1:Then(function()
			sort(list1, E.Octo_Func.reverse_order)
			for _, id1 in pairs(list1) do
				str1 = str1..id1..", -- "..E.Octo_Func.func_itemTexture(id1)..E.Octo_Func.func_itemName(id1).."\n"
			end
			fprint("begin /OCTOLISTIT")
			editBox:SetText(str1)
			editFrame:Show()
			fprint("end /OCTOLISTIT")
	end)
end
------------------------------
SLASH_OCTOLISTQW1 = "/OCTOLISTQW"
SlashCmdList.OCTOLISTQW = function(msg)
	local str = ""
	local list1 = {}
	local list2 = {}
	local promise2 = LibThingsLoad:Quests(E.Octo_Table.OctoTable_QuestID):ThenForAllWithCached(function(_, ids1)
			tinsert(list1, ids1)
	end)
	sort(list1, E.Octo_Func.reverse_order)
	local promise2 = LibThingsLoad:Quests(E.Octo_Table.OctoTable_QuestID):FailWithChecked(function(_, ids2)
			tinsert(list2, ids2)
	end)
	sort(list2, E.Octo_Func.reverse_order)
	promise2:Then(function()
			for _, id1 in pairs(list1) do
				str = str..id1..", -- "..E.Octo_Func.func_questName(id1).."\n"
			end
			for _, id2 in pairs(list2) do
				str = str..id2..", -- "..E.Octo_Func.func_questName(id2).."\n"
			end
			fprint("begin /OCTOLISTQW")
			editBox:SetText(str)
			editFrame:Show()
			fprint("end /OCTOLISTQW")
	end)
end
------------------------------
SLASH_OCTOLISTCUR1 = "/OCTOLISTCUR"
SlashCmdList.OCTOLISTCUR = function(msg)
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
			local currencyLink =  C_CurrencyInfo.GetCurrencyListLink(i)
			local currencyID = currencyLink and C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink)
			local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
			local quantity = currencyInfo.quantity
			if currencyID then
				str3 = str3 ..tostringall(currencyID) .. " - ".. E.Octo_Func.func_currencyicon(currencyID)..E.Octo_Func.func_currencyName(currencyID) .." ("..quantity..")".. "\n"
			end
		end
		i = i + 1
	end
	editBox:SetText(str3)
	editFrame:Show()
end
------------------------------
SLASH_OCTOLISTREP1 = "/OCTOLISTREP"
SlashCmdList.OCTOLISTREP = function(msg)
	local str4 = ""
	local listSize, i = C_Reputation.GetNumFactions(), 1
	-- C_Reputation.CollapseAllFactionHeaders() -- закрыть
	C_Reputation.ExpandAllFactionHeaders() -- открыть
	while listSize >= i do
		local factionData = C_Reputation.GetFactionDataByIndex(i)
		str4 = str4 .. i ..") ".. factionData.name ..E.Octo_Globals.LightGray_Color.." ("..factionData.factionID.. ")|r\n"
		i = i + 1
	end
	editBox:SetText(str4)
	editFrame:Show()
end
------------------------------
SLASH_OCTOLISTMOUNT1 = "/OCTOLISTMOUNT"
SlashCmdList.OCTOLISTMOUNT = function(msg)
	local str5, list5, i = "", {}, 1
	local mountsIDs = C_MountJournal.GetMountIDs()
	-- sort(mountsIDs, E.Octo_Func.reverse_order)
	sort(mountsIDs, E.Octo_Func.reverse_order)
	for _, id in pairs(mountsIDs) do
		local name, spellID, icon,_,_,_,_, isFactionSpecific, faction = C_MountJournal.GetMountInfoByID(id)
		if isFactionSpecific then name = name.." ("..(faction == 0 and FACTION_HORDE or FACTION_ALLIANCE).. ")"  end
		str5 = str5 .."[".. id .."] = true, -- "..spellID.." "..E.Octo_Func.func_texturefromIcon(icon)..name.."\n"
		i = i + 1
	end
	editBox:SetText(str5)
	editFrame:Show()
end

