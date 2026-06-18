local GlobalAddonName, E = ...
local L = E.L
local EventFrame = CreateFrame("FRAME")
local Octo_DebugFrame = CreateFrame("BUTTON", "Octo_DebugFrame", UIParent, "OctoBackdropTemplate")
Octo_DebugFrame:Hide()
Octo_editFrame_scrollFrame = CreateFrame("Frame", "Octo_editFrame_scrollFrame", Octo_DebugFrame, "ScrollingEditBoxTemplate")

table.insert(E.OctoTable_ColoredFrames, Octo_DebugFrame)

local MIN_WIDTH, MIN_HEIGHT = 1920 * .2, 1080 * .2
local MAX_WIDTH, MAX_HEIGHT = 1920 * .7, 1080 * .7
local INDENT = 20
local BUTTON_WIDTH, BUTTON_HEIGHT = 80, 20
local LibStub = LibStub
local L = E.L
local LibIndentation = LibStub("LibIndentation-1.0")
function E.func_createColorScheme(themeName)
	local theme = E.editorThemes[themeName] or E.editorThemes["Twilight"]
	return {
		[LibIndentation.tokens.TOKEN_UNKNOWN] = theme["Error"],
		[LibIndentation.tokens.TOKEN_NUMBER] = theme["Number"],
		[LibIndentation.tokens.TOKEN_LINEBREAK] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_WHITESPACE] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_IDENTIFIER] = theme["Foreground"],
		[LibIndentation.tokens.TOKEN_ASSIGNMENT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_EQUALITY] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_MINUS] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COMMENT_SHORT] = theme["Comment"],
		[LibIndentation.tokens.TOKEN_COMMENT_LONG] = theme["Comment"],
		[LibIndentation.tokens.TOKEN_STRING] = theme["String"],
		[LibIndentation.tokens.TOKEN_LEFTBRACKET] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_PERIOD] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_DOUBLEPERIOD] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_TRIPLEPERIOD] = theme["Special"],
		[LibIndentation.tokens.TOKEN_LTE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_LT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_GTE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_GT] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_NOTEQUAL] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COMMA] = theme["Special"],
		[LibIndentation.tokens.TOKEN_SEMICOLON] = theme["Special"],
		[LibIndentation.tokens.TOKEN_COLON] = theme["Special"],
		[LibIndentation.tokens.TOKEN_LEFTPAREN] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_RIGHTPAREN] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_PLUS] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_SLASH] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_LEFTWING] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_RIGHTWING] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_CIRCUMFLEX] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_ASTERISK] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_RIGHTBRACKET] = theme["Bracket"],
		[LibIndentation.tokens.TOKEN_KEYWORD] = theme["Keyword"],
		[LibIndentation.tokens.TOKEN_SPECIAL] = theme["Special"],
		[LibIndentation.tokens.TOKEN_VERTICAL] = theme["Special"],
		[LibIndentation.tokens.TOKEN_TILDE] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_COLORCODE_START] = theme["Special"],
		[LibIndentation.tokens.TOKEN_COLORCODE_STOP] = theme["Special"],
		[LibIndentation.tokens.TOKEN_HASH] = theme["Operator"],
		[LibIndentation.tokens.TOKEN_PERCENT] = theme["Operator"],
		["..."] = theme["Special"],
		[" .. "] = theme["Operator"],
		["|c"] = theme["Special"],
		["|r"] = theme["Special"],
		["and"] = theme["Keyword"],
		["break"] = theme["Keyword"],
		["do"] = theme["Keyword"],
		["else"] = theme["Keyword"],
		["elseif"] = theme["Keyword"],
		["end"] = theme["Keyword"],
		["false"] = theme["Constant"],
		["for"] = theme["Keyword"],
		["function"] = theme["Keyword"],
		["if"] = theme["Keyword"],
		["in"] = theme["Keyword"],
		["local"] = theme["Keyword"],
		["nil"] = theme["Constant"],
		["not"] = theme["Keyword"],
		["or"] = theme["Keyword"],
		["repeat"] = theme["Keyword"],
		["return"] = theme["Keyword"],
		["then"] = theme["Keyword"],
		["true"] = theme["Constant"],
		["until"] = theme["Keyword"],
		["while"] = theme["Keyword"],
		[0] = "|r"
	}
end
local function CreateMyAddonEditFrameTemplate()
	Octo_DebugFrame:SetPoint("CENTER")
	local width = E.PHYSICAL_SCREEN_WIDTH / 2
	local height = E.PHYSICAL_SCREEN_HEIGHT / 2
	Octo_DebugFrame:SetSize(width, height)
	Octo_DebugFrame:SetResizable(true)
	Octo_DebugFrame:SetDontSavePosition(true)
	Octo_DebugFrame:SetClampedToScreen(true)
	Octo_DebugFrame:EnableMouse(true)
	Octo_DebugFrame:SetMovable(true)
	Octo_DebugFrame:RegisterForClicks("RightButtonUp")
	Octo_DebugFrame:SetScript("OnClick", Octo_DebugFrame.Hide)
	Octo_DebugFrame.scrollBar = CreateFrame("EventFrame", nil, Octo_DebugFrame, "MinimalScrollBar")
	Octo_DebugFrame.scrollBar:SetPoint("TOPRIGHT", 14, 0)
	Octo_DebugFrame.scrollBar:SetPoint("BOTTOMRIGHT", 14, 0)
	Octo_editFrame_scrollFrame:SetPoint("TOPLEFT", INDENT, -INDENT)
	Octo_editFrame_scrollFrame:SetPoint("BOTTOMRIGHT", -INDENT, INDENT * 3)
	Octo_editFrame_scrollFrame.tex = Octo_editFrame_scrollFrame:CreateTexture()
	Octo_editFrame_scrollFrame.tex:SetAllPoints(Octo_editFrame_scrollFrame)
	Octo_editFrame_scrollFrame.tex:SetColorTexture(0, 0, 0, .7)
	Octo_DebugFrame.Import = CreateFrame("Button", nil, Octo_DebugFrame, "UIPanelButtonTemplate")
	Octo_DebugFrame.Import:SetPoint("BOTTOMRIGHT", -(INDENT * 2 + BUTTON_WIDTH), INDENT)
	Octo_DebugFrame.Import:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	Octo_DebugFrame.Import:SetText(L["IMPORT"])
	Octo_DebugFrame.Import:SetScript(
		"OnClick",
		function(self, button, down)
			local str = Octo_editFrame_scrollFrame:GetText()
			if not str or str == "" then
				E.func_PrintMessage(E.COLOR_RED .. "No data to import|r")
				return
			end
			local data = E.getDataFromString(str, true)
			if data then
				E.func_workWitchMyTable(data)
				Octo_DebugFrame:Hide()
			end
		end
	)
	Octo_DebugFrame.Import:RegisterForClicks("AnyUp")
	Octo_DebugFrame.closeButton = CreateFrame("Button", nil, Octo_DebugFrame, "UIPanelButtonTemplate")
	Octo_DebugFrame.closeButton:SetPoint("BOTTOMRIGHT", -INDENT, INDENT)
	Octo_DebugFrame.closeButton:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
	Octo_DebugFrame.closeButton:SetText(L["CLOSE"])
	Octo_DebugFrame.closeButton:SetScript(
		"OnClick",
		function(self, button, down)
			Octo_DebugFrame:Hide()
		end
	)
	Octo_DebugFrame.closeButton:RegisterForClicks("AnyUp")
	Octo_DebugFrame.resize = CreateFrame("BUTTON", nil, Octo_DebugFrame)
	Octo_DebugFrame.resize:SetSize(16, 16)
	Octo_DebugFrame.resize:SetPoint("BOTTOMRIGHT", 0, 0)
	Octo_DebugFrame.resize:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	Octo_DebugFrame.resize:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	Octo_DebugFrame.resize:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	Octo_DebugFrame.resize:RegisterForDrag("LeftButton")
	Octo_DebugFrame.lineText = Octo_DebugFrame:CreateFontString()
	Octo_DebugFrame.lineText:SetFontObject(OctoFont11)
	Octo_DebugFrame.lineText:SetPoint("BOTTOMLEFT", 20, 20)
	Octo_DebugFrame.lineText:SetText(L["Line"])
	local scrollBox = Octo_editFrame_scrollFrame:GetScrollBox()
	scrollBox:SetAllPoints(Octo_editFrame_scrollFrame)
	ScrollUtil.RegisterScrollBoxWithScrollBar(scrollBox, Octo_DebugFrame.scrollBar)
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(scrollBox, Octo_DebugFrame.scrollBar)
	local editBox = Octo_editFrame_scrollFrame:GetEditBox()
	editBox:HookScript("OnEnterPressed", function(self)
			self:Insert("\n")
		end
	)
	editBox:HookScript("OnEscapePressed", function(self)
			self:ClearFocus()
		end
	)
	if Octo_DevTool_DB then
		editBox:SetFont(E.Octo_font, Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_FONTSIZE, "")
	else
		editBox:SetFont(E.Octo_font, 11, "")
	end
	editBox:HookScript("OnCursorChanged", function(self)
			local text = self:GetText()
			local pos = self:GetCursorPosition()
			local next = -1
			local line = 0
			local totalLines = 1
			for _ in text:gmatch("\n") do
				totalLines = totalLines + 1
			end
			while next and pos >= next do
				next = text:find("[\n]", next + 1)
				line = line + 1
			end
			Octo_DebugFrame.lineText:SetText(L["Line"] .. ": " .. line .. "/" .. totalLines)
		end
	)
	Octo_DebugFrame:SetScript("OnMouseDown", function(_, button)
			if button == "LeftButton" then
				Octo_DebugFrame:StartMoving()
			end
		end
	)
	Octo_DebugFrame:SetScript("OnMouseUp", function(_, button)
			if button == "LeftButton" then
				Octo_DebugFrame:StopMovingOrSizing()
			end
		end
	)
	Octo_DebugFrame:SetScript("OnKeyDown", function(self, key)
			if not InCombatLockdown() then
				if key == GetBindingKey("TOGGLEGAMEMENU") then
					self:Hide()
					self:SetPropagateKeyboardInput(false)
				else
					self:SetPropagateKeyboardInput(true)
				end
			end
		end
	)
	local isResizing = false
	Octo_DebugFrame.resize:SetScript("OnDragStart", function(self)
			isResizing = true
			self:GetParent():StartSizing("BOTTOMRIGHT", true)
		end
	)
	Octo_DebugFrame.resize:SetScript("OnDragStop", function(self)
			isResizing = false
			self:GetParent():StopMovingOrSizing()
		end
	)
	Octo_DebugFrame:SetScript("OnUpdate", function(self, elapsed)
			if isResizing then
				local w, h = self:GetSize()
				self:SetSize(math.max(MIN_WIDTH, math.min(MAX_WIDTH, w)), math.max(MIN_HEIGHT, math.min(MAX_HEIGHT, h)))
			end
		end
	)
end
function E.ShowImportExportFrame(defaultText)
	if SettingsPanel:IsVisible() then
		HideUIPanel(SettingsPanel)
	end
	if GameMenuFrame:IsVisible() then
		HideUIPanel(GameMenuFrame)
	end
	Octo_editFrame_scrollFrame:SetText(defaultText or "")
	Octo_DebugFrame:Show()
	Octo_editFrame_scrollFrame:SetFocus()
end
do
	local compressedCache, encodeForWoWAddonChannel, decodeForWoWAddonChannel
	function encodeForWoWAddonChannel(str)
		local encode_translate = {
			["\000"] = "\001\002",
			["\001"] = "\001\003"
		}
		function encodeForWoWAddonChannel(str)
			return str:gsub("[%z\001]", encode_translate)
		end
		return encodeForWoWAddonChannel(str)
	end
	function decodeForWoWAddonChannel(str)
		local decode_translate = {
			["\001\002"] = "\000",
			["\001\003"] = "\001"
		}
		function decodeForWoWAddonChannel(str)
			return str:gsub("\001[\002\003]", decode_translate)
		end
		return decodeForWoWAddonChannel(str)
	end
	function E.getStringFromData(data, forPrint)
		local serialized = C_EncodingUtil.SerializeCBOR(data)
		local ServerTime, compressed = E.TIME_SERVER()
		compressedCache = compressedCache or {}
		if compressedCache[serialized] then
			compressed = compressedCache[serialized].compressed
			compressedCache[serialized].lastAccess = ServerTime
		else
			compressed =
			C_EncodingUtil.CompressString(
				serialized,
				Enum.CompressionMethod.Deflate,
				Enum.CompressionLevel.OptimizeForSize
			)
			compressedCache[serialized] = {
				compressed = compressed,
				lastAccess = ServerTime
			}
		end
		local expiredTime = ServerTime - 300
		for k, v in next, compressedCache do
			if v.lastAccess < expiredTime then
				compressedCache[k] = nil
			end
		end
		if forPrint then
			return C_EncodingUtil.EncodeBase64(compressed, Enum.Base64Variant.StandardUrlSafe)
		else
			return encodeForWoWAddonChannel(compressed)
		end
	end
	function E.getDataFromString(str, fromPrint)
		local decoded, success, decompressed, data
		if fromPrint then
			decoded = C_EncodingUtil.DecodeBase64(str, Enum.Base64Variant.StandardUrlSafe)
		else
			decoded = decodeForWoWAddonChannel(str)
		end
		success, decompressed = pcall(C_EncodingUtil.DecompressString, decoded, Enum.CompressionMethod.Deflate)
		if not success then
			return
		end
		success, data = pcall(C_EncodingUtil.DeserializeCBOR, decompressed)
		if success then
			return data
		end
	end
	function E.func_workWitchMyTable(tbl)
		Octo_ToDo_DB_Levels = Octo_ToDo_DB_Levels or {}
		local count = 0
		local success = false
		for GUID, CharInfo in next, (tbl) do
			local pd = CharInfo.PlayerData
			local cm = CharInfo.MASLENGO
			if pd and cm and pd.Name then
				count = count + 1
				success = true
				Octo_ToDo_DB_Levels[GUID] = CharInfo
			end
		end
		if success then
			E.func_PrintMessage(E.COLOR_GREEN .. "Import successful, chars:|r", count)
		else
			E.func_PrintMessage(E.COLOR_YELLOW .. "Import failed:|r")
		end
	end
end
local function dumpEdit(indent, msg, tables)
	local str, indentStr, tables = "", "", tables or {}
	for i = 1, indent do
		indentStr = indentStr .. " "
	end
	for k, v in next, (msg) do
		k =
		(type(k) == "number" and "[" .. k .. "]" or type(k) == "string" and '["' .. k .. '"]' or tostringall(k)) ..
		" ="
		if type(v) == "table" and not tables[v] then
			tables[v] = true
			str = ("%s%s%s {\n"):format(str, indentStr, k)
			str = str .. dumpEdit(indent + 1, v, tables)
			str = ("%s%s},\n"):format(str, indentStr)
		else
			local vtype = type(v)
			v =
			vtype == "string" and '"' .. v:gsub('["\\]', "\\%1") .. '"' or vtype == "number" and v or
			'"' .. tostringall(v) .. '"'
			str = ("%s%s%s %s,\n"):format(str, indentStr, k, v)
		end
	end
	if indent == 0 then
		LibIndentation.enable(
			Octo_editFrame_scrollFrame:GetEditBox(),
			E.func_createColorScheme(Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_EDITORTHEME or "Twilight"),
			Octo_DevTool_DB.CONFIG_DEBUG_EDITBOX_TABSPACES
		)
		Octo_editFrame_scrollFrame:SetText(str)
		LibIndentation.indentEditbox(Octo_editFrame_scrollFrame:GetEditBox())
		Octo_DebugFrame:Show()
	else
		return str
	end
end
local oprintHandler = function(...)
	local function sendMessage(frame, indent, msg, allChildren)
		local indentStr = E.func_Gradient(GlobalAddonName .. ": ")
		for i = 1, indent do
			indentStr = indentStr .. " "
		end
		for k, v in next, (msg) do
			k = "[" .. tostringall(k) .. "] ="
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
	local message = strjoin(" ", E.func_Gradient(GlobalAddonName .. ": "), tostringall(...))
	local mFrame = DEFAULT_CHAT_FRAME
	local i = 1
	repeat
		local frame = _G["ChatFrame" .. i]
		if frame and frame:IsShown() then
			mFrame = frame
			break
		end
		i = i + 1
	until not frame
	mFrame:AddMessage(message)
	local first = select(1, ...)
	if first == "dump" then
		local msg = {}
		for i = 2, select("#", ...) do
			local n = select(i, ...)
			tinsert(msg, n)
		end
		sendMessage(mFrame, 0, msg)
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
local function oprint_inner(...)
	forceinsecure()
	local ok, err = pcall(oprintHandler, ...)
	if not ok then
		geterrorhandler()(err)
	end
end
dump = "dump"
dumpe = "dumpe"
if not oprint then
	function oprint(...)
		securecall(pcall, oprint_inner, ...)
	end
end
if not opd then
	function opd(...)
		oprint(dump, ...)
	end
end
if not opde then
	function opde(...)
		oprint(dumpe, ...)
	end
end
SLASH_OPRINT1 = "/oprint"
SlashCmdList["OPRINT"] = function(msg)
	local f, err = loadstring("return " .. msg) -- было load
	if err then
		oprint(err:gsub('"return ', '"'))
		return
	end
	local status, value = pcall(f)
	if status then
		oprint(dumpe, value)
	else
		oprint(value:gsub('"return ', '"'))
	end
end
local slashCommands = {
	GSEARCH = {
		commands = {"/gsearch", "/gs"},
		handler = function(msg)
			local str = ""
			local color = E.classColorHexCurrent
			DEFAULT_CHAT_FRAME:AddMessage(color .. "GSEARCH:|r " .. msg)
			for i, n in pairs(_G) do
				if type(n) == "string" and n:find(msg) then
					str = str .. color .. i .. "|r - " .. n .. "\n"
				end
			end
			Octo_editFrame_scrollFrame:SetText(str)
			Octo_DebugFrame:Show()
		end
	}
}
for name, data in pairs(slashCommands) do
	SlashCmdList[name] = data.handler
	for i, cmd in ipairs(data.commands) do
		_G["SLASH_" .. name .. i] = cmd
	end
end
local MyEventsTable = {
	"PLAYER_LOGIN"
}
E.func_RegisterEvents(EventFrame, MyEventsTable)
function EventFrame:PLAYER_LOGIN()
	CreateMyAddonEditFrameTemplate()
	E.editFrame = Octo_DebugFrame
	E.editBox = Octo_editFrame_scrollFrame
	do
		local frame = Octo_DebugFrame
		local providerfunc = nil
		local buttonName = nil
		E.func_Create_DDframe_editFrame(frame, providerfunc, buttonName)
	end
end
E.Octo_DevTool_DB_DATA = "vb0JfBzFlT_u0ZzdM8IQIKgNGHHbYBvN6DaGIOsc67QkH5yirWlJg0czYg4bEQjiMme4w52ADcTkvyzrGBt8YZIlkGOzySib3U1IIISQLAnJhiSYLOEH_L9Vc3VX17RKxlI-eVhTU1NV7_tevaO6umpLf09EHdfii_01_urFFctr62tqayq2tHU29HU0d7V2P9vWmIrHtejg-G7nNxTvgc3to-oVK1NqNBlOjislHYrz4wnF-7GhuCyk-GzGkgWKz2kqkUwlpcaS4xTfEROK72hj6YTiIqWnghbi72MM39oUn39Csd2EL-tBDVvaLs99o692lOJrNrY6X_EFjSVXKL5ONLEStAp0vpF1-zuK72JzkYqaGigMGgVdDkoZ261VfOPGkgsU39WmOtcaShyK70a24BamwHYPOvsK6CEWkq-icDPoG6B_Bu1kxPgzxbcbxS-Cvg16pYCaR1_Ro_j-E1__HPQ66PdFwJ2r-P6Er_8CMuqLrNgen1BKjVJWbO8rpUcY2f-eUno0KkLEpQs3G-VWuhiFEHEpxFt6DqgZZJRcieLaaiiYN6d07-NK6Uq21nPGgRx5s-LaCY16AQQ4XHtZDXH9G0p_DJoE_QcIaLh-AQIarl-DfgP6H9DvJxS3F1QKmgs6EnR0Aa2ysHF09tLzFPexqHOqscduxX26qQT8u88CAQN3JagaVAsCHu6zQcDE3biZ00Ezr7AVtYOgdhC03d0Ngsa7ofHuCwsjlo1idF-MrwdAUHf3ICjGaJw7gcIUaCNoHPRF0NWga0DXgq4H3Qi6DfRl0J2gu0H3gqDC7gdAD4EeAUF73Y-BoMHuJ0BPgbaCoM3ufwJBo93_Avom6DkQZOfeC4I6u_8dBGm5IS03pOWG7rohMTck5v4VCFJzQ2ru324uSEdR3BCimwjxXRB02f1nEPTZ_TfQAdDfQR-CPgLBALo_nVA8JSAXSAYdBvoc6POgeaD5oJNAp4HOAC0xirVH8QRQWgNaCjoXtJxB1NOCwhWgLlAvaDXoAkMlu-K5hC0YMhS4FM9l-FkUFAdtAF3JGBHPl9iC61BrE-hW0B0gWBnP_aCHQV8DbQF9HfT_gbaDnge9CvoB6Eegn4D-C_RaAWLF9nvF8wbz-S39598ont8ZP0vAVQKuEnCVgKsEXCXgKgFXCbhKwFVaAgKSEpCUgKQEJKXlIIAnATwJ4EkATwJ40gWgS0DrCv0cpUjARwI-EvCRgI90JehLIKAgAQEJCEhAQAICEhCQgIAEBCQgIAEB6VkQUJCAgrQHtB_0ryAgIgERCYhIQEQCItJroDdAfwD9L-ivoA9A_wB9MqHI0CgZGiWDcxmcy-BcBufyfKPdcqcVGSDIAEEGCDJAkAGCDBBkgCADBBkgyABBBggyQJABggwAZAAgrwMNgcC6DNZlsC6DdRmsy2BdBusyFEAG-zLYl8G-DPZlsC6DdRmsy2BdBusyWJfBugzWZbAug3UZrMtgXQbrMliXwbr8GmOM5t-AwrdAvwMBDxk4yMBB_oQNErxAxHsa8_MHMR7vGbzCJRyr5w3wCmt4hUt5hQDU21swjk7DCBXFC-3yAlwvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9QLcEvDtBbhegOsFuF4ybuiWFwB7AbAXAHsBsBcAewGwF-CWvMf4Re-_Ggo-p5T8lfWp3h8x3tgLaXjfMgUx3t-Zi_5QYBefTV__r_XXf2UavFTxfsAUlSnefzBxwV2K9xNTYFliChpdphLZVHIYYxd9mEq-z282Bjd2D4OpXUItzCofZpUPs8qHWeXDrPItZYD0tRh7rFN8K0zBJKadHVGND9rhu8AcOV5iLlpnKHIqviG24DK2ACrmg4r5Nhi7b1F8RkNfNqD4jJa-rF3xXceGmJvYglvZAuisj8Sd0Fcf9NUHffVBX33QVx_01bedjUWfNwVdPuizD8bCB2Phe_XJ9mQsqUaa1XhUC5UY84G8kpWsSSW0_kK9lli8ExWT4wcU348MLcw1RKb5BuZaNIBZ4YONsiOqstfpFPvU8w0jP_1wxfcHIzM371J8MOQ-GHIfDFgpjHYpNK0UrqoUOlQaKBIxe5RSVqVKYWRKYbFLYalLYTxKAbL9WnY62AG_fRurOWWIAe0_NZZ2lSv2t1j9Rphjfw-EUMb-_-Ci7SA3CLGrB3GrB3GrB3Gp5wTQyaDTdVHSfMVzJooQinoQhnoAlgfhp-cLoEY2dkGU6Wk3jke6VPH0oXgNG7FcyBYMsyHMevwsBkJs6fkiG61cwxYg0vQgHfQg0vQgyvQgwvQguvQgsvQgqvQgovQgmvQgcvQg8vcgcvR8F4RY34NY34PI0fPfoF8w4cqv9J9_p3h-w3z_P_rP31cc15myHgkwS4BZAszSMSBALQFqCVBLp4OArwR8JeArAV8J-ErAV2oEAVIJQbuEgF0CjtIa0IUgROUSAJIAkJRgkJOAmIRIXEIULgEXCbhIwEUCLhJwkYCLBFwk4CIBFwm4SIiwJUTXEvCRgI8EfKSXQC-DgJMEnCTgJAEnCThJiK4lRNbSb0xBiuN9k4mTEGBLCK4lBNYSgmoJAbWEYFqGJsrQRBkQyYBIBkTyMRNlSE3kE8zRDwCTAZgMwGQAJgMwGYDJAEwGYDIAkwGYDMBkACYDMOci_AvAZAAmI4WRh0EATgZwMrIXGVjJwEoGVjKwkoGVDKxkYCUDK2cH_gVWMnCSgZMMnGTgJAMnGTjJwEkGTjJwkoGTDJxk4CQDJ2fEpAsykhAZ01EGIPKfjV8fu1aRgY8MfGTgIwMfL_Bx3syJobzQI-_pvEDoTF7hWbzwppJXWMsrPJtXCHC90EYvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9QJcL8D1AlwvwPUCXC_A9UIRvQDXC0X0AmAvAPYCYC8A9gJY70ts9AOUnW-bFMP7Y3ZByQv4vb8xxzf_Yx3AvGv9NTTY-zdmTeUmxft3puhcxfsRU4QffmqKceym-MVtKvGalq_msp72WHbdzAfj4sNc8WGu-DBXXKQMc8WHueLDXPF9wbT-ZjTlytIHFV-rKdZpZ4MCzDEf1MC1iA1PLjQHOQPmImiMb5j9KVTHB9XxbTR2v1jxfdEE4DXs-pprucn7-G5iR30bWwBt9EETfdBEHzTRB030QRN90EQfNNHHrB-pTys-KKcPs973smm2XaP4vlvQohImgIRl8EE1fbCgPlhQH0yBD6bA97fiC5gwB6VzzUtpR5qW0o5h8Sk9ll1UO9k0dUrPZOvAsJZCWUprzX1Cd0phZ11PF2EQo3AhGHRtZ0fi2oFS5IuuPaZvvoVSZI2uH4KQObrSIERmrp-CEJ25fgZCAu1CAu1CAuWeY9JUN2aXG7mz2wdCKOY-3NhJQHF_ju3WfRTqYVq4jzN9M9-0FHcK6p1mKl1gKkHq4K4AIX1wV4GQQrjrQEjO3ctATbyVuRZeYRtqI4V3w_m4kU-4e0AIEN3IKdxrQReBLgUhDXCPGQEpfV5xIzNwI_l0XwFCAuq-CoQk1D0BQiLqhgNxI9N33w5CZOm-C4S4030fCO7C_SAIgb77URCCfffjIAT87idBCPrdT4MQ-LufAUHe7m0gJKxuSNm9C7QPhEDf_a8TZWQxECJ1_8S48AbJun8JglTdb4KIZN8G_Q70DugPoD-CEGW739NFWPavKm5E3W5jiOFW3AjD3f8H-gcIIa77E4Ryc0AOkAcE3fAcDjoOVA6CTD0LjGEuIgUPxOeB6DwQmwci8zSxIS4k44FUPJCIpx-0lg1jL2ILQmxcO8IWRNDOGOgqNqaFvDyQledmEGTlgZw8kJEHcvFAJh7IwwNZeIC_ZwfbL4Tg-Q5b-D0UYqZ5IBIPZpjnZ0x0-0vm85tMtPs2s3j3DrN4B6glQC0BaglTTMIUkwC5BMglQC4tAAFnCThLwFkCzhJwls4DNYEArwR4JcArAV4Jyi5B2SUouzQCAlQSoJKSIGi3BM2WgJIElCSgJAElCShJQEmCFktASgJSEpCSgJQEjZWAlgRNlaCpEkCSYIGk74CAjQRsJGAjARsJlkeCjkrQTwk6KUEfJWRR0vsgqJoENZOhYjJUTAbfMviWwbcMvmXwLJebA1hAIAMCmQSlgEAGBDIgkAGBDAhkQCADApkEnYBABgQy2JdDILAvg30Z7MtgXwb7MtiXwb5MVtXAvgz2ZbAvg30ZrMtgXQbrMliXwboM1mWwLoN1GazLYF0G6zJYl8G6DNZlsC7_0uSsZaAgY4bKQEL-Y9EHR_J7bLwiAyoZUHkX8ALTRbzCCl64WcUrrOMVLuMV9hcZMlnHW1v4zs1-B_S9lxa-l_TfS4oXgvFCMF4IxgvBeCEYLwTjhWC8EIyXhOoQjBeC8UIwXgjGC730QjheCMcL4XghHC-E44VwvLt4Y4ekvN8yB70QlhfC8r5pDnPfNhe9Yx3a_tH6a-i9l0nrbG8r3v9j-ilXvBC1b44pUnOYAluPqcRnKjmcDXUxrXwwJT7MIx_mkW9R8SeYFYWvHExEhVnnqyvy0AtfLzNFx5iavqYiERqCujbTGiDmrg9z1wfz5bvIHPheai4KsXEwtMoXMeEIHfNBx3xXsCGOz-g8ypYpvgk2zr2BLbiZLbidLYDO-qCzvgdNI4EG-6DBPmiwDxrsgwb7trHy2sFJXX0wPj6otA_GxwfD44Me-6DHPthbH6yLD3bWBxtbCltaCltaCh9SepwJsdJyxo2WnsIWLOIE56UVzGpw6TI2AIa0S2GIS2GISyGF0shE2esTZeQx92sTZdpE2dBE2fBE2fhEGVnbRxhVsptpwXmuaaVuM3zt5ITi-JAZo22CDeNt15pKbjGt8O_mmM0SJN82owBhTxTbl03t3WEqudNUcpep5G5TyW_QIVxCiR30JPttyVOmEniekj0Tiv0MULXx238o9mWmknNMJeeybTruM5Xcz5Y4T2INi7MFIxmCQBFT2241tYB0xAGv6PzUlGKthzqEkYgcb1JHF8mz_YVoaN4c7z13KK6ALsRcq7gqzb-D-y-F5BxIOB1kkf3L0BQbyAmSQKWgI0DkkcL1bIB4PL44EXQqaCFoMcgPqgbVg84BNbCTcg1aIhU6QStBq0Dns4HixeyTFLIArLGRa5gtGEWty0EpdqTjRcwxvrqarXstGrgRdAuIwHE36CuAp5PRetumxxXPV_ElmV1Pgb6BCfkh46X-oXi-iQgEcLowsT0v4t9vsHL1vGLyrp7vo_K_o9MwM7k9_4kvfs6Exa8zn3_NhMm_1X9-SfH8Hm08hFFBbvL5plVAx9WmZycy8JCBh-N63faSs4ycLlIkKIwEhZGgMBIURlJA0BEJOuK4F_QVlnMJGiNBYyQohASNkaAxUgOoGRQEQUkkKIkEJZHOB10MUjFryO8wEyQIXILApRRoHIR8T4L8JIxXwnglyE-C_CTITwLHEsQlQVwSxCVBXNI_gyAfaSdoNwjykb4NegUEEUgQgQTDKQF16eeg10G_Bv22qOeXAK70JxAstoOsM38I-hjwYVbZwJoMkGSAJAMkmcyq-fgXw5HRpfNIM_KYVzK4lYGSDJRkoCQDJZk0BZRkoCQDJZmsWQMlJ6l7sX6vgQy8ZA0EvGTgJQMvGXjJwEsGXjLwcjaCSGvASwZeznYQaRV4ycDLhpZl4CUDL5noM_CSgZcMvGTg5RxkJSsDPRnoyUBPBnoy0JMhBRnoyb8FASYZMDnHzbH-AXwF1OSPi4OMKhKQkaDBrnNBQMSFLMZ1NmgpCCh5T-UF9wt5hYt5Ya-fV1jNK6znFLqcLCIuBxvE2CAR5ycmf_GWaS8CZOtdVQDDxWYJ-9l1akwTL8Tuhdi96MQLsXshdi_E7oXYvRC7F2L3Ypp4MU28ELsXYvdCQF5MEy_E7oXYvdBLL7FqELsXYrfdhgFjCnhfZDuEDnhfMXuXL0yUQQ-8kxNlX5oou2qijCzG_9qcHPzWXPR764TgT9Zf_4VdEi87Y6KjI5xIdg-tTGmJZGILzHd4c_dVg0NDLS1VjVUt_rP8V8WVu-etPaFQVkHKypnPfZlmetS4OhyLZlqb6AxGN2jRZCw-3j8-pt37jZXBpDZqKLO1kaIudVRbe1r60fSuyesmJ9LbyievS29L706_mN6f3k0-7Elvm7wJ396Y3tULDsKjqdGBplRcXReO0B1cLWHScBN07Klf9Q7SPbNJQ4WezEbaJOmtQ9ugRcrm0Z47wtH1a7901WA0uLJy6VVtpJmlgcr6ilr_0uz_AhVLA9U1-DewtGppTU11YGldnd-_1B-oqKldWluLrwJL62mtuqX-uszPrhq5UIyZi68auSreFByMRefNOe7R21ohGjJe-1YzUiUFpJakH0NbO9Lb0zsnryXNlae_mt6Z_ib9SLp5Lr2_PP0EamwjA8iDUxL41BKHTUYc_FVV_kCtJQ4B4FBZW2-Fw7SGqsdD-vmdeTw4mmMv4LEUbW5Lv5Tei1ZvQqu70NGu8vQLaPNaQpO3of9tk3dM3oKuaYfbCfyTE5N3WmtTSWDj9LXpyyyKlfX1PG2qzKA4pSIdNG8GMOv9VsrlKIBZlX4SneynHV6Hf0nrd5JW96P4xYwQUYAOrocYt03eTAqyiClP3WKCxlZAZowiE8ghUwXVMamXvwpEIaivyUNwECPSM18yN5ljvoSjSUcVmF-U_hqa2Esn6E6K9s7y9EvQzJ1UQ6_Dv3tJ33vR9zae7lyts0Rv8nTnakvduYZjiQKfQXemwY3RFN1iNfVcBcCOTz88eT0Q35beUw5J7IUInieGL9M0D6EFhdn1psxDaIElQuuZ2VVXVxWo4SAkYJmsRm5QH-e9Vmi4WcNMzNrzZJLiA5TyNjojr6WqSyfoPUSPibXjwXNBHh5b_9948FxggueYAjobjOjU1QbqKk0zDM5raU2tv8IAS6DeYLGFedAD5flHjxVQngJQlXCP"