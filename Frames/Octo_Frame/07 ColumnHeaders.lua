local GlobalAddonName, E = ...
local L = E.L
----------------------------------------------------------------
function E.func_createPool(frame, scrollContentFrame)
	local function ResetPoolFrame(_, self)
		self:Hide()
		self:ClearAllPoints()
	end
	local function InitializePoolFrame(self)
		self:RegisterForClicks("LeftButtonUp")
		self:SetSize(E.MIN_COLUMN_WIDTH_CENTER, E.HEADER_HEIGHT)

		self.Nickname = self:CreateFontString()
		self.Nickname:SetFontObject(OctoFont11)

		-- self.EXP = self:CreateFontString()
		-- self.EXP:SetFontObject(OctoFont11)

		self.Server = self:CreateFontString()
		self.Server:SetFontObject(OctoFont10)

		self.Mail = self:CreateFontString()
		self.Mail:SetFontObject(OctoFont10)

		self.Durability = self:CreateFontString()
		self.Durability:SetFontObject(OctoFont10)

		self.Text = self:CreateFontString()
		self.Text:SetFontObject(OctoFont11)

		self.Text:SetPoint("CENTER")
		self.Text:SetJustifyV("MIDDLE")
		self.Text:SetJustifyH("CENTER")
		self.Text:SetTextColor(E.textR, E.textG, E.textB, E.textA)

		self.CharTexture = self:CreateTexture(nil, "BACKGROUND", nil, -3)
		self.CharTexture:SetAllPoints()
		self.CharTexture:SetTexture(E.TEXTURE_HEADER)
	end
	frame.pool = CreateFramePool("BUTTON", scrollContentFrame, "OctoRectTemplate", ResetPoolFrame, false, InitializePoolFrame)
end

function E.func_CreateColumnHeaders(frame, sortedCharacters, columnWidthsCenter)
	local MAIN_FRAME = E.FRAMES[E.MAIN_FRAME_NAME]
	MAIN_FRAME.pool:ReleaseAll()

	-- /run E.FRAMES[E.MAIN_FRAME_NAME].pool:ReleaseAll()

	local accumulatedWidth = 0
	for count, CharInfo in ipairs(sortedCharacters) do
		local pd = CharInfo.PlayerData
		local HeaderFrameCenter = MAIN_FRAME.pool:Acquire()
		local columnWidth = columnWidthsCenter[count] or E.MIN_COLUMN_WIDTH_CENTER
		HeaderFrameCenter:SetPoint("TOPLEFT", MAIN_FRAME.scrollContentFrame, "TOPLEFT", accumulatedWidth, 0)
		HeaderFrameCenter:SetSize(columnWidth, E.HEADER_HEIGHT)
		accumulatedWidth = accumulatedWidth + columnWidth

		HeaderFrameCenter.Nickname:SetPoint("CENTER", 0, 0)
		HeaderFrameCenter.Nickname:SetWordWrap(false)
		HeaderFrameCenter.Nickname:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Nickname:SetJustifyH("CENTER")
		HeaderFrameCenter.Nickname:SetText("Name")

		HeaderFrameCenter.Mail:SetPoint("TOPRIGHT")
		HeaderFrameCenter.Mail:SetWordWrap(false)
		HeaderFrameCenter.Mail:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Mail:SetJustifyH("RIGHT")
		HeaderFrameCenter.Mail:SetText("Mail")

		HeaderFrameCenter.Durability:SetPoint("BOTTOMRIGHT")
		HeaderFrameCenter.Durability:SetWordWrap(false)
		HeaderFrameCenter.Durability:SetJustifyV("MIDDLE")
		HeaderFrameCenter.Durability:SetJustifyH("RIGHT")
		HeaderFrameCenter.Durability:SetText("Durability")


		-- HeaderFrameCenter.EXP:SetPoint("TOP")
		-- HeaderFrameCenter.EXP:SetWordWrap(false)
		-- HeaderFrameCenter.EXP:SetJustifyV("MIDDLE")
		-- HeaderFrameCenter.EXP:SetJustifyH("RIGHT")
		-- HeaderFrameCenter.EXP:SetText("EXP")



		local r, g, b, a = E.func_DB_HEADER_COLOR(CharInfo)
		HeaderFrameCenter.CharTexture:SetVertexColor(r, g, b, a)
		HeaderFrameCenter:SetScript("OnEnter", function(self)
				HeaderFrameCenter.tooltip = E.func_Tooltip_Chars(CharInfo, true)
				E.SafeTooltipShow(HeaderFrameCenter, {"BOTTOMLEFT", "TOPLEFT"})
		end)
		HeaderFrameCenter:SetScript("OnClick", function(self, button)
				if button == "LeftButton" and IsShiftKeyDown() then
					local GUID = pd.GUID
					E.Toggle_Octo_EquipmentsFrame(GUID)
					E.func_UPDATE_MAINFRAME(frame)
				end
				if button == "LeftButton" and IsControlKeyDown() then
					local GUID = pd.GUID
					local PlayerName = E.func_CharInfo_NickName(CharInfo, nil, true)
					local PlayerServer = E.func_CharInfo_Server(CharInfo, true, false)
					Octo_Todo_DB_Profiles.CHARACTERS.profiles[E.CHARACTERS_CURRENT].GUIDS[GUID] = false
					E.func_UPDATE_MAINFRAME(frame)
				end
		end)
		HeaderFrameCenter:SetScript("OnShow", function()
			local Name = E.func_CharInfo_NickName(CharInfo)
			HeaderFrameCenter.Nickname:SetText(Name)
			local Mail = E.func_CharInfo_Mail(CharInfo)
			HeaderFrameCenter.Mail:SetText(Mail)
			local Durability = E.func_CharInfo_Durability(CharInfo, false, 41)
			HeaderFrameCenter.Durability:SetText(Durability)
			-- HeaderFrameCenter.EXP:SetText(pd.IsXPUserDisabled and L["VIDEO_OPTIONS_DISABLED"] or "")
		end)
		HeaderFrameCenter:Show()
	end
end




	-- if pd.IsXPUserDisabled then
	-- 	tooltip[#tooltip+1] = {L["Experience Eliminator"] .. ": " .. E.COLOR_RED .. L["VIDEO_OPTIONS_DISABLED"] .. "|r"}
	-- end