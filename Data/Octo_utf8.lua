local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
local strbyte, strlen, strsub, type = string.byte, string.len, string.sub, type
function E.Octo_Func.utf8charbytes(s, i)
	i = i or 1
	if type(s) ~= "string" then
		error("error")
	end
	if type(i) ~= "number" then
		error("error")
	end
	local c = strbyte(s, i)
	if c > 0 and c <= 127 then
		return 1
	elseif c >= 194 and c <= 223 then
		local c2 = strbyte(s, i + 1)
		if not c2 then
			error("error")
		end
		if c2 < 128 or c2 > 191 then
			error("error")
		end
		return 2
	elseif c >= 224 and c <= 239 then
		local c2 = strbyte(s, i + 1)
		local c3 = strbyte(s, i + 2)
		if not c2 or not c3 then
			error("error")
		end
		if c == 224 and (c2 < 160 or c2 > 191) then
			error("error")
		elseif c == 237 and (c2 < 128 or c2 > 159) then
			error("error")
		elseif c2 < 128 or c2 > 191 then
			error("error")
		end
		if c3 < 128 or c3 > 191 then
			error("error")
		end
		return 3
	elseif c >= 240 and c <= 244 then
		local c2 = strbyte(s, i + 1)
		local c3 = strbyte(s, i + 2)
		local c4 = strbyte(s, i + 3)
		if not c2 or not c3 or not c4 then
			error("error")
		end
		if c == 240 and (c2 < 144 or c2 > 191) then
			error("error")
		elseif c == 244 and (c2 < 128 or c2 > 143) then
			error("error")
		elseif c2 < 128 or c2 > 191 then
			error("error")
		end
		if c3 < 128 or c3 > 191 then
			error("error")
		end
		if c4 < 128 or c4 > 191 then
			error("error")
		end
		return 4
	else
		error("error")
	end
end
function E.Octo_Func.utf8len(s)
	if type(s) ~= "string" then
		error("error")
	end
	local pos = 1
	local bytes = strlen(s)
	local len = 0
	while pos <= bytes do
		len = len + 1
		pos = pos + E.Octo_Func.utf8charbytes(s, pos)
	end
	return len
end
function E.Octo_Func.utf8sub(s, i, j)
	j = j or -1
	if type(s) ~= "string" then
		error("error")
	end
	if type(i) ~= "number" then
		error("error")
	end
	if type(j) ~= "number" then
		error("error")
	end
	local pos = 1
	local bytes = strlen(s)
	local len = 0
	local l = (i >= 0 and j >= 0) or E.Octo_Func.utf8len(s)
	local startChar = (i >= 0) and i or l + i + 1
	local endChar   = (j >= 0) and j or l + j + 1
	if startChar > endChar then
		return ""
	end
	local startByte, endByte = 1, bytes
	while pos <= bytes do
		len = len + 1
		if len == startChar then
			startByte = pos
		end
		pos = pos + E.Octo_Func.utf8charbytes(s, pos)
		if len == endChar then
			endByte = pos - 1
			break
		end
	end
	return strsub(s, startByte, endByte)
end
function E.Octo_Func.utf8replace(s, mapping)
	if type(s) ~= "string" then
		error("error")
	end
	if type(mapping) ~= "table" then
		error("error")
	end
	local pos = 1
	local bytes = strlen(s)
	local charbytes
	local newstr = ""
	while pos <= bytes do
		charbytes = E.Octo_Func.utf8charbytes(s, pos)
		local c = strsub(s, pos, pos + charbytes - 1)
		newstr = newstr .. (mapping[c] or c)
		pos = pos + charbytes
	end
	return newstr
end
function E.Octo_Func.utf8upper(s)
	return E.Octo_Func.utf8replace(s, E.Octo_Globals.utf8_lc_uc)
end
function E.Octo_Func.utf8lower(s)
	return E.Octo_Func.utf8replace(s, E.Octo_Globals.utf8_uc_lc)
end
function E.Octo_Func.utf8reverse(s)
	if type(s) ~= "string" then
		error("error")
	end
	local bytes = strlen(s)
	local pos = bytes
	local charbytes
	local newstr = ""
	local c
	while pos > 0 do
		c = strbyte(s, pos)
		while c >= 128 and c <= 191 do
			pos = pos - 1
			c = strbyte(pos)
		end
		charbytes = E.Octo_Func.utf8charbytes(s, pos)
		newstr = newstr .. strsub(s, pos, pos + charbytes - 1)
		pos = pos - 1
	end
	return newstr
end